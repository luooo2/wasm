#!/usr/bin/env python3
"""
Batch-run llvm direct-run benchmarks from llvm_direct_runnable.csv.

This is a thin wrapper around run_llvm.py style logic:
- internal timing from TIME_NS line
- external end-to-end timing
- supports wasm jit / aot / both
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
    ap.add_argument("--out-csv", default="data/results/labels_llvm_direct_from_runnable.csv")
    ap.add_argument("--raw-csv", default="data/results/labels_raw_llvm_direct_from_runnable.csv")
    ap.add_argument("--wasmtime", default="wasmtime")
    ap.add_argument("--wasm-mode", choices=["jit", "aot", "both"], default="both")
    ap.add_argument("--aot-cache-dir", default="data/build/llvm_direct/aot_cache")
    ap.add_argument("--repeats", type=int, default=10)
    ap.add_argument("--warmup", type=int, default=1)
    ap.add_argument("--timeout", type=int, default=180)
    ap.add_argument("--threshold", type=float, default=0.10)
    args = ap.parse_args()

    build_dir = Path(args.build_dir)
    runnable_csv = Path(args.runnable_csv)
    out_csv = Path(args.out_csv)
    raw_csv = Path(args.raw_csv)
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    raw_csv.parent.mkdir(parents=True, exist_ok=True)
    aot_cache = Path(args.aot_cache_dir)
    aot_cache.mkdir(parents=True, exist_ok=True)

    programs = load_runnable(runnable_csv)
    req_modes = ["jit", "aot"] if args.wasm_mode == "both" else [args.wasm_mode]

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
                w_cmd = [args.wasmtime, "--dir=.", str(wb)]
            else:
                cwasm = aot_cache / f"{prog}.cwasm"
                if not cwasm.exists():
                    cp = subprocess.run(
                        [args.wasmtime, "compile", str(wb), "-o", str(cwasm)],
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
                w_cmd = [args.wasmtime, "run", "--allow-precompiled", "--dir=.", str(cwasm)]

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

        row: Dict[str, object] = {"program": prog}
        for mode in ["jit", "aot"]:
            if mode not in req_modes:
                row[f"{mode}_ok"] = 0
                row[f"{mode}_label"] = "not-requested"
                row[f"ratio_{mode}_over_native_internal"] = 0.0
                row[f"ratio_{mode}_over_native_external"] = 0.0
                row[f"{mode}_error"] = "not requested"
                continue
            mr = mode_results.get(mode, {"ok": False, "err": "missing mode result", "n_in": [], "n_ex": [], "w_in": [], "w_ex": []})
            ns_i = stats(mr["n_in"])  # type: ignore[arg-type]
            ns_e = stats(mr["n_ex"])  # type: ignore[arg-type]
            ws_i = stats(mr["w_in"])  # type: ignore[arg-type]
            ws_e = stats(mr["w_ex"])  # type: ignore[arg-type]
            ri = (ws_i["median"] / ns_i["median"]) if ns_i["median"] > 0 else 0.0
            re = (ws_e["median"] / ns_e["median"]) if ns_e["median"] > 0 else 0.0
            ok_mode = bool(mr["ok"])
            row[f"{mode}_ok"] = int(ok_mode)
            row[f"{mode}_label"] = label_by_ratio(ri, args.threshold) if ok_mode else "run-failed"
            row[f"{mode}_native_median_internal_ms"] = round(ns_i["median"], 6)
            row[f"{mode}_wasm_median_internal_ms"] = round(ws_i["median"], 6)
            row[f"ratio_{mode}_over_native_internal"] = round(ri, 6)
            row[f"{mode}_native_median_external_ms"] = round(ns_e["median"], 6)
            row[f"{mode}_wasm_median_external_ms"] = round(ws_e["median"], 6)
            row[f"ratio_{mode}_over_native_external"] = round(re, 6)
            row[f"{mode}_error"] = str(mr["err"])

        sum_rows.append(row)

    sum_fields = [
        "program",
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
                "run_index",
                "internal_ms",
                "external_ms",
                "ok",
                "error",
            ],
        )
        w.writeheader()
        w.writerows(raw_rows)

    print(f"summary output: {out_csv}")
    print(f"raw output:     {raw_csv}")


if __name__ == "__main__":
    main()

