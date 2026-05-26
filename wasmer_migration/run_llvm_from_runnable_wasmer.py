#!/usr/bin/env python3
"""
Batch-run llvm direct-run benchmarks on the Wasmer runtime (cranelift backend).

Mirrors src/run_llvm_from_runnable.py 1:1, with the wasmtime invocations
replaced by wasmer equivalents. We keep the same per-program TIME_NS internal
timer, external timer, repeats/warmup logic, and CSV schema so downstream
analysis can pivot wasmtime vs wasmer by (program, mode).

JIT  : wasmer run --cranelift --mapdir=.:. <file.wasm>
AOT  : wasmer compile --cranelift <file.wasm> -o <file.wasmu>
       wasmer run <file.wasmu>     (no --allow-precompiled; wasmer detects)

Outputs (relative to repo root):
- data/results/wasmer/labels_llvm_direct_from_runnable_wasmer_cranelift.csv
- data/results/wasmer/labels_raw_llvm_direct_from_runnable_wasmer_cranelift.csv

Both CSVs include extra columns:
- runtime_engine  : "wasmer"
- compiler        : "cranelift"
so they can be unioned with wasmtime rows by adding the same columns.
"""

import argparse
import csv
import re
import shlex
import statistics
import subprocess
import time
from pathlib import Path
from typing import Dict, List, Optional, Tuple

RE_TIME_NS = re.compile(r"TIME_NS\s*:\s*([0-9]+)")


def parse_internal_ms(out: str) -> Optional[float]:
    m = RE_TIME_NS.search(out or "")
    if not m:
        return None
    try:
        return int(m.group(1)) / 1_000_000.0
    except ValueError:
        return None


def run_once(cmd: List[str], timeout_sec: int) -> Tuple[bool, Optional[float], float, str]:
    t0 = time.perf_counter()
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout_sec)
    except subprocess.TimeoutExpired:
        t1 = time.perf_counter()
        return False, None, (t1 - t0) * 1000.0, f"timeout after {timeout_sec}s"
    t1 = time.perf_counter()
    ext_ms = (t1 - t0) * 1000.0

    out = f"{p.stdout or ''}\n{p.stderr or ''}"
    if p.returncode != 0:
        err = (p.stderr or p.stdout or "").strip() or f"exit code {p.returncode}"
        return False, None, ext_ms, err

    inner_ms = parse_internal_ms(out)
    if inner_ms is None:
        return False, None, ext_ms, "internal timing not found (TIME_NS:<ns>)"
    return True, inner_ms, ext_ms, ""


def stats(vals: List[float]) -> Dict[str, float]:
    if not vals:
        return {"mean": 0.0, "median": 0.0, "std": 0.0, "min": 0.0, "max": 0.0}
    return {
        "mean": statistics.mean(vals),
        "median": statistics.median(vals),
        "std": statistics.stdev(vals) if len(vals) >= 2 else 0.0,
        "min": min(vals),
        "max": max(vals),
    }


def label_by_ratio(r: float, threshold: float) -> str:
    if r > 1.0 + threshold:
        return "native-better"
    if r < 1.0 - threshold:
        return "wasm-better"
    return "similar"


def load_runnable(path: Path) -> List[str]:
    rows = list(csv.DictReader(path.open("r", encoding="utf-8", newline="")))
    progs = [r.get("program", "").strip() for r in rows]
    return [p for p in progs if p]


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--build-dir", default="data/build/llvm_direct")
    ap.add_argument("--runnable-csv", default="data/results/llvm_direct_runnable.csv")
    ap.add_argument(
        "--out-csv",
        default="data/results/wasmer/labels_llvm_direct_from_runnable_wasmer_cranelift.csv",
    )
    ap.add_argument(
        "--raw-csv",
        default="data/results/wasmer/labels_raw_llvm_direct_from_runnable_wasmer_cranelift.csv",
    )
    ap.add_argument("--wasmer", default="wasmer", help="path to wasmer binary")
    ap.add_argument(
        "--compiler",
        default="cranelift",
        choices=["cranelift"],
        help="wasmer compiler backend (cranelift only for this experiment)",
    )
    ap.add_argument("--wasm-mode", choices=["jit", "aot", "both"], default="both")
    ap.add_argument(
        "--aot-cache-dir",
        default="data/build/llvm_direct/aot_cache_wasmer/cranelift",
    )
    ap.add_argument("--repeats", type=int, default=10)
    ap.add_argument("--warmup", type=int, default=1)
    ap.add_argument("--timeout", type=int, default=180)
    ap.add_argument("--threshold", type=float, default=0.10)
    ap.add_argument(
        "--programs",
        default="",
        help="optional comma-separated subset of programs to run",
    )
    args = ap.parse_args()

    build_dir = Path(args.build_dir)
    runnable_csv = Path(args.runnable_csv)
    out_csv = Path(args.out_csv)
    raw_csv = Path(args.raw_csv)
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    raw_csv.parent.mkdir(parents=True, exist_ok=True)
    aot_cache = Path(args.aot_cache_dir)
    aot_cache.mkdir(parents=True, exist_ok=True)

    compiler_flag = f"--{args.compiler}"

    programs = load_runnable(runnable_csv)
    subset = {p.strip() for p in args.programs.split(",") if p.strip()}
    if subset:
        programs = [p for p in programs if p in subset]
    req_modes = ["jit", "aot"] if args.wasm_mode == "both" else [args.wasm_mode]

    print(f"[info] wasmer={args.wasmer} compiler={args.compiler}")
    print(f"[info] programs={len(programs)} modes={req_modes}")
    print(f"[info] out_csv={out_csv}")
    print(f"[info] raw_csv={raw_csv}")
    print(f"[info] aot_cache={aot_cache}")

    raw_rows: List[Dict[str, object]] = []
    sum_rows: List[Dict[str, object]] = []

    for prog in programs:
        nb = build_dir / f"{prog}.native"
        wb = build_dir / f"{prog}.wasm"
        if not nb.exists() or not wb.exists():
            continue
        print(f"\n=== Running {prog} ({args.wasm_mode}) ===")
        n_cmd = [str(nb)]

        mode_results: Dict[str, Dict[str, object]] = {}
        for mode in req_modes:
            if mode == "jit":
                w_cmd = [
                    args.wasmer,
                    "run",
                    compiler_flag,
                    "--mapdir=.:.",
                    str(wb),
                ]
            else:
                wasmu = aot_cache / f"{prog}.wasmu"
                if not wasmu.exists():
                    cp = subprocess.run(
                        [
                            args.wasmer,
                            "compile",
                            compiler_flag,
                            str(wb),
                            "-o",
                            str(wasmu),
                        ],
                        capture_output=True,
                        text=True,
                    )
                    if cp.returncode != 0:
                        mode_results[mode] = {
                            "ok": False,
                            "err": (cp.stderr or cp.stdout or "").strip(),
                            "n_in": [],
                            "n_ex": [],
                            "w_in": [],
                            "w_ex": [],
                        }
                        continue
                w_cmd = [args.wasmer, "run", str(wasmu)]

            for _ in range(max(args.warmup, 0)):
                run_once(n_cmd, args.timeout)
                run_once(w_cmd, args.timeout)

            n_in: List[float] = []
            n_ex: List[float] = []
            w_in: List[float] = []
            w_ex: List[float] = []
            ok_pair = True
            err_pair = ""
            for i in range(1, args.repeats + 1):
                print("$", " ".join(shlex.quote(c) for c in n_cmd))
                ok_n, ni, ne, err_n = run_once(n_cmd, args.timeout)
                raw_rows.append(
                    {
                        "program": prog,
                        "mode": mode,
                        "runtime": "native",
                        "runtime_engine": "native",
                        "compiler": "",
                        "run_index": i,
                        "internal_ms": round(ni, 6) if ni is not None else 0.0,
                        "external_ms": round(ne, 6),
                        "ok": int(ok_n),
                        "error": err_n,
                    }
                )
                if not ok_n or ni is None:
                    ok_pair = False
                    err_pair = err_n
                    break
                n_in.append(ni)
                n_ex.append(ne)

                print("$", " ".join(shlex.quote(c) for c in w_cmd))
                ok_w, wi, we, err_w = run_once(w_cmd, args.timeout)
                raw_rows.append(
                    {
                        "program": prog,
                        "mode": mode,
                        "runtime": f"wasm-{mode}",
                        "runtime_engine": "wasmer",
                        "compiler": args.compiler,
                        "run_index": i,
                        "internal_ms": round(wi, 6) if wi is not None else 0.0,
                        "external_ms": round(we, 6),
                        "ok": int(ok_w),
                        "error": err_w,
                    }
                )
                if not ok_w or wi is None:
                    ok_pair = False
                    err_pair = err_w
                    break
                w_in.append(wi)
                w_ex.append(we)

            mode_results[mode] = {
                "ok": ok_pair,
                "err": err_pair,
                "n_in": n_in,
                "n_ex": n_ex,
                "w_in": w_in,
                "w_ex": w_ex,
            }

        row: Dict[str, object] = {
            "program": prog,
            "runtime_engine": "wasmer",
            "compiler": args.compiler,
        }
        for mode in ["jit", "aot"]:
            if mode not in req_modes:
                row[f"{mode}_ok"] = 0
                row[f"{mode}_label"] = "not-requested"
                row[f"ratio_{mode}_over_native_internal"] = 0.0
                row[f"ratio_{mode}_over_native_external"] = 0.0
                row[f"{mode}_error"] = "not requested"
                continue
            mr = mode_results.get(
                mode,
                {"ok": False, "err": "missing mode result", "n_in": [], "n_ex": [], "w_in": [], "w_ex": []},
            )
            ns_i = stats(mr["n_in"])  # type: ignore[arg-type]
            ns_e = stats(mr["n_ex"])  # type: ignore[arg-type]
            ws_i = stats(mr["w_in"])  # type: ignore[arg-type]
            ws_e = stats(mr["w_ex"])  # type: ignore[arg-type]
            ri = (ws_i["median"] / ns_i["median"]) if ns_i["median"] > 0 else 0.0
            re_ = (ws_e["median"] / ns_e["median"]) if ns_e["median"] > 0 else 0.0
            ok_mode = bool(mr["ok"])
            row[f"{mode}_ok"] = int(ok_mode)
            row[f"{mode}_label"] = label_by_ratio(ri, args.threshold) if ok_mode else "run-failed"
            row[f"{mode}_native_median_internal_ms"] = round(ns_i["median"], 6)
            row[f"{mode}_wasm_median_internal_ms"] = round(ws_i["median"], 6)
            row[f"ratio_{mode}_over_native_internal"] = round(ri, 6)
            row[f"{mode}_native_median_external_ms"] = round(ns_e["median"], 6)
            row[f"{mode}_wasm_median_external_ms"] = round(ws_e["median"], 6)
            row[f"ratio_{mode}_over_native_external"] = round(re_, 6)
            row[f"{mode}_error"] = str(mr["err"])

        sum_rows.append(row)

    sum_fields = [
        "program",
        "runtime_engine",
        "compiler",
        "jit_ok",
        "jit_label",
        "jit_native_median_internal_ms",
        "jit_wasm_median_internal_ms",
        "ratio_jit_over_native_internal",
        "jit_native_median_external_ms",
        "jit_wasm_median_external_ms",
        "ratio_jit_over_native_external",
        "jit_error",
        "aot_ok",
        "aot_label",
        "aot_native_median_internal_ms",
        "aot_wasm_median_internal_ms",
        "ratio_aot_over_native_internal",
        "aot_native_median_external_ms",
        "aot_wasm_median_external_ms",
        "ratio_aot_over_native_external",
        "aot_error",
    ]
    with out_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=sum_fields)
        w.writeheader()
        w.writerows(sum_rows)

    with raw_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(
            f,
            fieldnames=[
                "program",
                "mode",
                "runtime",
                "runtime_engine",
                "compiler",
                "run_index",
                "internal_ms",
                "external_ms",
                "ok",
                "error",
            ],
        )
        w.writeheader()
        w.writerows(raw_rows)

    print(f"\nsummary output: {out_csv}")
    print(f"raw output:     {raw_csv}")


if __name__ == "__main__":
    main()
