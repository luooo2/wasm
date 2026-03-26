#!/usr/bin/env python3
"""
Batch run native and wasm programs with reliability-focused metrics.

Outputs:
1) summary CSV: label + mean/median/std/min/max
2) raw CSV: one row per run

Label rule by ratio r = wasm_median / native_median:
- r > 1 + threshold => native-better
- r < 1 - threshold => wasm-better
- else => similar
"""

import argparse
import csv
import shlex
import statistics
import subprocess
import time
from pathlib import Path
from typing import List, Optional


def run_once(cmd: List[str], timeout_sec: int) -> tuple[bool, float, str]:
    t0 = time.perf_counter()
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout_sec)
        t1 = time.perf_counter()
        return p.returncode == 0, (t1 - t0) * 1000.0, (p.stderr or "").strip()
    except subprocess.TimeoutExpired:
        t1 = time.perf_counter()
        return False, (t1 - t0) * 1000.0, f"timeout after {timeout_sec}s"


def label_by_ratio(ratio: float, threshold: float) -> str:
    if ratio > 1.0 + threshold:
        return "native-better"
    if ratio < 1.0 - threshold:
        return "wasm-better"
    return "similar"


def stats(values: List[float]) -> dict:
    if not values:
        return {
            "mean": 0.0,
            "median": 0.0,
            "std": 0.0,
            "min": 0.0,
            "max": 0.0,
        }
    return {
        "mean": statistics.mean(values),
        "median": statistics.median(values),
        "std": statistics.stdev(values) if len(values) >= 2 else 0.0,
        "min": min(values),
        "max": max(values),
    }


def parse_programs_arg(programs_arg: str) -> Optional[set]:
    if not programs_arg:
        return None
    vals = [x.strip() for x in programs_arg.split(",") if x.strip()]
    return set(vals) if vals else None


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--build-dir", default="data/build", help="Directory containing *.native/*.wasm")
    parser.add_argument("--out-csv", default="data/results/labels.csv", help="Summary CSV path")
    parser.add_argument("--raw-csv", default="data/results/labels_raw.csv", help="Raw per-run CSV path")
    parser.add_argument("--wasmtime", default="wasmtime", help="wasmtime command")
    parser.add_argument("--repeats", type=int, default=30, help="Run repeats (default 30)")
    parser.add_argument("--warmup", type=int, default=2, help="Warmup runs for native and wasm before measuring")
    parser.add_argument("--timeout", type=int, default=180, help="Per-run timeout seconds")
    parser.add_argument("--threshold", type=float, default=0.10, help="Similarity threshold")
    parser.add_argument("--programs", default="", help="Optional comma-separated program names for focused rerun")
    args = parser.parse_args()

    build_dir = Path(args.build_dir)
    out_csv = Path(args.out_csv)
    raw_csv = Path(args.raw_csv)
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    raw_csv.parent.mkdir(parents=True, exist_ok=True)

    selected = parse_programs_arg(args.programs)

    native_bins = sorted(build_dir.glob("*.native"))
    summary_rows = []
    raw_rows = []

    for nb in native_bins:
        prog = nb.name[:-7] if nb.name.endswith(".native") else nb.stem
        if selected is not None and prog not in selected:
            continue

        wb = build_dir / f"{prog}.wasm"

        print(f"\n=== Running {prog} ===")

        if not wb.exists():
            summary_rows.append(
                {
                    "program": prog,
                    "native_ok": 0,
                    "wasm_ok": 0,
                    "native_mean_ms": 0,
                    "native_median_ms": 0,
                    "native_std_ms": 0,
                    "native_min_ms": 0,
                    "native_max_ms": 0,
                    "wasm_mean_ms": 0,
                    "wasm_median_ms": 0,
                    "wasm_std_ms": 0,
                    "wasm_min_ms": 0,
                    "wasm_max_ms": 0,
                    "ratio_wasm_over_native": 0,
                    "label": "missing-artifact",
                    "native_error": "",
                    "wasm_error": f"missing {wb}",
                }
            )
            continue

        native_times: List[float] = []
        wasm_times: List[float] = []
        native_ok = True
        wasm_ok = True
        native_err = ""
        wasm_err = ""

        n_cmd = [str(nb)]
        w_cmd = [args.wasmtime, "--dir=.", str(wb)]

        # warmup phase (not recorded)
        for _ in range(max(args.warmup, 0)):
            ok_n, _, _ = run_once(n_cmd, args.timeout)
            ok_w, _, _ = run_once(w_cmd, args.timeout)
            if not ok_n or not ok_w:
                break

        # measured phase
        for i in range(1, args.repeats + 1):
            print("$", " ".join(shlex.quote(c) for c in n_cmd))
            ok_n, t_n, err_n = run_once(n_cmd, args.timeout)
            raw_rows.append(
                {
                    "program": prog,
                    "runtime": "native",
                    "run_index": i,
                    "elapsed_ms": round(t_n, 6),
                    "ok": int(ok_n),
                    "error": err_n,
                }
            )
            if not ok_n:
                native_ok = False
                native_err = err_n
                break
            native_times.append(t_n)

            print("$", " ".join(shlex.quote(c) for c in w_cmd))
            ok_w, t_w, err_w = run_once(w_cmd, args.timeout)
            raw_rows.append(
                {
                    "program": prog,
                    "runtime": "wasm",
                    "run_index": i,
                    "elapsed_ms": round(t_w, 6),
                    "ok": int(ok_w),
                    "error": err_w,
                }
            )
            if not ok_w:
                wasm_ok = False
                wasm_err = err_w
                break
            wasm_times.append(t_w)

        n_stats = stats(native_times)
        w_stats = stats(wasm_times)

        ratio = (w_stats["median"] / n_stats["median"]) if n_stats["median"] > 0 else 0.0
        label = "run-failed"
        if native_ok and wasm_ok:
            label = label_by_ratio(ratio, args.threshold)

        summary_rows.append(
            {
                "program": prog,
                "native_ok": int(native_ok),
                "wasm_ok": int(wasm_ok),
                "native_mean_ms": round(n_stats["mean"], 6),
                "native_median_ms": round(n_stats["median"], 6),
                "native_std_ms": round(n_stats["std"], 6),
                "native_min_ms": round(n_stats["min"], 6),
                "native_max_ms": round(n_stats["max"], 6),
                "wasm_mean_ms": round(w_stats["mean"], 6),
                "wasm_median_ms": round(w_stats["median"], 6),
                "wasm_std_ms": round(w_stats["std"], 6),
                "wasm_min_ms": round(w_stats["min"], 6),
                "wasm_max_ms": round(w_stats["max"], 6),
                "ratio_wasm_over_native": round(ratio, 6),
                "label": label,
                "native_error": native_err,
                "wasm_error": wasm_err,
            }
        )

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "program",
                "native_ok",
                "wasm_ok",
                "native_mean_ms",
                "native_median_ms",
                "native_std_ms",
                "native_min_ms",
                "native_max_ms",
                "wasm_mean_ms",
                "wasm_median_ms",
                "wasm_std_ms",
                "wasm_min_ms",
                "wasm_max_ms",
                "ratio_wasm_over_native",
                "label",
                "native_error",
                "wasm_error",
            ],
        )
        writer.writeheader()
        writer.writerows(summary_rows)

    with raw_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=["program", "runtime", "run_index", "elapsed_ms", "ok", "error"],
        )
        writer.writeheader()
        writer.writerows(raw_rows)

    print("\n=== Label Summary ===")
    summary = {}
    for r in summary_rows:
        summary[r["label"]] = summary.get(r["label"], 0) + 1
    for k in sorted(summary):
        print(f"{k}: {summary[k]}")
    print(f"summary output: {out_csv}")
    print(f"raw output:     {raw_csv}")


if __name__ == "__main__":
    main()
