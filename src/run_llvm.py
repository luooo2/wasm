#!/usr/bin/env python3
"""
Run llvm direct-run benchmarks with:
- internal timing (TIME_NS from benchmark output)
- external end-to-end timing (perf_counter)
"""

import argparse
import csv
import re
import shlex
import statistics
import subprocess
import time
from pathlib import Path
from typing import List, Optional, Tuple

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


def stats(vals: List[float]) -> dict:
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


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--build-dir", default="data/build/llvm_direct")
    ap.add_argument("--out-csv", default="data/results/labels_llvm_direct_jit.csv")
    ap.add_argument("--raw-csv", default="data/results/labels_raw_llvm_direct_jit.csv")
    ap.add_argument("--wasmtime", default="wasmtime")
    ap.add_argument("--wasm-mode", choices=["jit", "aot"], default="jit")
    ap.add_argument("--aot-cache-dir", default="data/build/llvm_direct/aot_cache")
    ap.add_argument("--repeats", type=int, default=10)
    ap.add_argument("--warmup", type=int, default=1)
    ap.add_argument("--timeout", type=int, default=120)
    ap.add_argument("--threshold", type=float, default=0.10)
    ap.add_argument("--programs", default="")
    args = ap.parse_args()

    build_dir = Path(args.build_dir)
    out_csv = Path(args.out_csv)
    raw_csv = Path(args.raw_csv)
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    raw_csv.parent.mkdir(parents=True, exist_ok=True)

    selected = {x.strip() for x in args.programs.split(",") if x.strip()}
    use_select = len(selected) > 0

    raw_rows = []
    sum_rows = []
    aot_cache = Path(args.aot_cache_dir)
    aot_cache.mkdir(parents=True, exist_ok=True)

    for nb in sorted(build_dir.glob("*.native")):
        prog = nb.stem.replace(".native", "") if nb.name.endswith(".native") else nb.stem
        if use_select and prog not in selected:
            continue
        wb = build_dir / f"{prog}.wasm"
        if not wb.exists():
            continue

        if args.wasm_mode == "jit":
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
                    sum_rows.append(
                        {
                            "program": prog,
                            "label": "aot-compile-failed",
                            "native_ok": 0,
                            "wasm_ok": 0,
                            "ratio_wasm_over_native_internal": 0.0,
                            "native_error": "",
                            "wasm_error": (cp.stderr or cp.stdout or "").strip(),
                        }
                    )
                    continue
            w_cmd = [args.wasmtime, "run", "--allow-precompiled", "--dir=.", str(cwasm)]

        n_cmd = [str(nb)]
        print(f"\n=== Running {prog} ({args.wasm_mode}) ===")

        for _ in range(max(args.warmup, 0)):
            ok_n, _, _, _ = run_once(n_cmd, args.timeout)
            ok_w, _, _, _ = run_once(w_cmd, args.timeout)
            if not ok_n or not ok_w:
                break

        n_in, n_ex, w_in, w_ex = [], [], [], []
        n_ok, w_ok = True, True
        n_err, w_err = "", ""

        for i in range(1, args.repeats + 1):
            print("$", " ".join(shlex.quote(c) for c in n_cmd))
            ok_n, ni, ne, err_n = run_once(n_cmd, args.timeout)
            raw_rows.append(
                {
                    "program": prog,
                    "runtime": "native",
                    "run_index": i,
                    "internal_ms": round(ni, 6) if ni is not None else 0.0,
                    "external_ms": round(ne, 6),
                    "ok": int(ok_n),
                    "error": err_n,
                }
            )
            if not ok_n or ni is None:
                n_ok = False
                n_err = err_n
                break
            n_in.append(ni)
            n_ex.append(ne)

            print("$", " ".join(shlex.quote(c) for c in w_cmd))
            ok_w, wi, we, err_w = run_once(w_cmd, args.timeout)
            raw_rows.append(
                {
                    "program": prog,
                    "runtime": f"wasm-{args.wasm_mode}",
                    "run_index": i,
                    "internal_ms": round(wi, 6) if wi is not None else 0.0,
                    "external_ms": round(we, 6),
                    "ok": int(ok_w),
                    "error": err_w,
                }
            )
            if not ok_w or wi is None:
                w_ok = False
                w_err = err_w
                break
            w_in.append(wi)
            w_ex.append(we)

        ns_i, ns_e = stats(n_in), stats(n_ex)
        ws_i, ws_e = stats(w_in), stats(w_ex)
        ratio_i = (ws_i["median"] / ns_i["median"]) if ns_i["median"] > 0 else 0.0
        ratio_e = (ws_e["median"] / ns_e["median"]) if ns_e["median"] > 0 else 0.0
        label = label_by_ratio(ratio_i, args.threshold) if (n_ok and w_ok) else "run-failed"

        sum_rows.append(
            {
                "program": prog,
                "label": label,
                "native_ok": int(n_ok),
                "wasm_ok": int(w_ok),
                "native_median_internal_ms": round(ns_i["median"], 6),
                "wasm_median_internal_ms": round(ws_i["median"], 6),
                "ratio_wasm_over_native_internal": round(ratio_i, 6),
                "native_median_external_ms": round(ns_e["median"], 6),
                "wasm_median_external_ms": round(ws_e["median"], 6),
                "ratio_wasm_over_native_external": round(ratio_e, 6),
                "native_error": n_err,
                "wasm_error": w_err,
            }
        )

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(
            f,
            fieldnames=[
                "program",
                "label",
                "native_ok",
                "wasm_ok",
                "native_median_internal_ms",
                "wasm_median_internal_ms",
                "ratio_wasm_over_native_internal",
                "native_median_external_ms",
                "wasm_median_external_ms",
                "ratio_wasm_over_native_external",
                "native_error",
                "wasm_error",
            ],
        )
        w.writeheader()
        w.writerows(sum_rows)

    with raw_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(
            f,
            fieldnames=["program", "runtime", "run_index", "internal_ms", "external_ms", "ok", "error"],
        )
        w.writeheader()
        w.writerows(raw_rows)

    print(f"summary output: {out_csv}")
    print(f"raw output:     {raw_csv}")


if __name__ == "__main__":
    main()

