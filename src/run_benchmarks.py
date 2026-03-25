#!/usr/bin/env python3
"""
Batch run native and wasm programs, then label by ratio:
r = T_wasm / T_native
- r > 1 + threshold: native-better
- r < 1 - threshold: wasm-better
- else: similar
"""

import argparse
import csv
import shlex
import statistics
import subprocess
import time
from pathlib import Path
from typing import List


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


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--build-dir", default="data/build", help="Directory containing *.native/*.wasm")
    parser.add_argument("--out-csv", default="data/results/labels.csv", help="Output CSV path")
    parser.add_argument("--wasmtime", default="wasmtime", help="wasmtime command")
    parser.add_argument("--repeats", type=int, default=5, help="Run repeats")
    parser.add_argument("--timeout", type=int, default=120, help="Per-run timeout seconds")
    parser.add_argument("--threshold", type=float, default=0.10, help="Similarity threshold")
    args = parser.parse_args()

    build_dir = Path(args.build_dir)
    out_csv = Path(args.out_csv)
    out_csv.parent.mkdir(parents=True, exist_ok=True)

    native_bins = sorted(build_dir.glob("*.native"))
    rows = []

    for nb in native_bins:
        prog = nb.stem.replace(".native", "") if nb.stem.endswith(".native") else nb.name
        # because nb is '*.native', stem is program
        prog = nb.name[:-7] if nb.name.endswith(".native") else nb.stem
        wb = build_dir / f"{prog}.wasm"

        print(f"\n=== Running {prog} ===")

        if not wb.exists():
            rows.append(
                {
                    "program": prog,
                    "native_ok": 0,
                    "wasm_ok": 0,
                    "native_median_ms": 0,
                    "wasm_median_ms": 0,
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

        for _ in range(args.repeats):
            n_cmd = [str(nb)]
            print("$", " ".join(shlex.quote(c) for c in n_cmd))
            ok_n, t_n, err_n = run_once(n_cmd, args.timeout)
            if not ok_n:
                native_ok = False
                native_err = err_n
                break
            native_times.append(t_n)

            w_cmd = [args.wasmtime, str(wb)]
            print("$", " ".join(shlex.quote(c) for c in w_cmd))
            ok_w, t_w, err_w = run_once(w_cmd, args.timeout)
            if not ok_w:
                wasm_ok = False
                wasm_err = err_w
                break
            wasm_times.append(t_w)

        n_med = statistics.median(native_times) if native_times else 0.0
        w_med = statistics.median(wasm_times) if wasm_times else 0.0
        ratio = (w_med / n_med) if n_med > 0 else 0.0

        label = "run-failed"
        if native_ok and wasm_ok:
            label = label_by_ratio(ratio, args.threshold)

        rows.append(
            {
                "program": prog,
                "native_ok": int(native_ok),
                "wasm_ok": int(wasm_ok),
                "native_median_ms": round(n_med, 6),
                "wasm_median_ms": round(w_med, 6),
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
                "native_median_ms",
                "wasm_median_ms",
                "ratio_wasm_over_native",
                "label",
                "native_error",
                "wasm_error",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)

    print("\n=== Label Summary ===")
    summary = {}
    for r in rows:
        summary[r["label"]] = summary.get(r["label"], 0) + 1
    for k in sorted(summary):
        print(f"{k}: {summary[k]}")
    print(f"output: {out_csv}")


if __name__ == "__main__":
    main()
