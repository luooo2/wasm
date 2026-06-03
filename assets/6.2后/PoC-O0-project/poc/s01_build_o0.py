#!/usr/bin/env python3
"""Build the O0 baseline wasm and native binaries, then measure baseline timing.

This script:
  1. Invokes build_llvm_direct.py with --opt -O0 and outputs into
     PoC-O0-project/build/ (the same programs as the O2 PoC cohort).
  2. Runs a quick benchmark (3 repeats, 1 warmup) on every successfully built
     program to measure the O0 raw wasm runtime and wasm/native ratio.
  3. Writes the measured values back into config/programs.csv so subsequent
     pipeline steps (prompt generation, LLM calls) show accurate O0 numbers.

Requirements:
  - /opt/wasi-sdk/bin/clang (or WASI_CC env) for wasm target
  - clang for native target
  - wasmer, wasm-opt, wasm-validate on PATH

Usage:
  python3 s01_build_o0.py [--wasi-cc /opt/wasi-sdk/bin/clang] [--native-cc clang]
  python3 s01_build_o0.py --skip-build   # only re-measure timing, skip compile
"""

from __future__ import annotations

import argparse
import csv
import shlex
import subprocess
import sys
from pathlib import Path
from typing import Dict, List

# Ensure common is importable when run from outside poc/
sys.path.insert(0, str(Path(__file__).resolve().parent))

from common import (
    BUILD_DIR,
    CONFIG_DIR,
    REPO_ROOT,
    Program,
    bench_native,
    bench_wasm_aot,
    check_tools,
    load_programs,
)

BUILD_SCRIPT = REPO_ROOT / "src" / "build_llvm_direct.py"
BUILD_STRATEGY_CSV = REPO_ROOT / "data" / "results" / "llvm_direct_build_strategy.csv"
DIRECT_LIST = REPO_ROOT / "data" / "results" / "llvm_direct_run_list.txt"
BENCH_ROOT = REPO_ROOT / "data" / "llvm-test-suite" / "SingleSource" / "Benchmarks"

QUICK_REPEATS = 3
QUICK_WARMUP = 1
BENCH_TIMEOUT = 300


def run_build(wasi_cc: str, native_cc: str, programs: List[str]) -> Dict[str, bool]:
    """Invoke build_llvm_direct.py for the PoC program subset."""
    # Write a temporary subset list so the builder only touches our programs.
    tmp_list = BUILD_DIR / "_poc_o0_list.txt"
    tmp_list.write_text("\n".join(programs) + "\n", encoding="utf-8")

    cmd = [
        sys.executable,
        str(BUILD_SCRIPT),
        "--opt=-O0",  # '=' form required: argparse treats '-O0' as a flag otherwise
        "--out-dir", str(BUILD_DIR),
        "--bench-root", str(BENCH_ROOT),
        "--direct-list", str(tmp_list),
        "--wrapper", str(REPO_ROOT / "src" / "llvm_timing_wrapper.c"),
        "--native-cc", native_cc,
        "--wasi-cc", wasi_cc,
        "--strategy-csv", str(BUILD_STRATEGY_CSV),
    ]
    print("[build] command:", " ".join(shlex.quote(c) for c in cmd))
    result = subprocess.run(cmd, text=True)
    tmp_list.unlink(missing_ok=True)

    # Parse build report to know which programs succeeded
    report = BUILD_DIR / "build_report_llvm_direct.csv"
    ok_map: Dict[str, bool] = {}
    if report.exists():
        with report.open(newline="", encoding="utf-8") as f:
            for r in csv.DictReader(f):
                name = r.get("program", "").strip()
                ok_map[name] = (r.get("native_ok", "0") == "1" and r.get("wasm_ok", "0") == "1")
    return ok_map


def measure_baseline(programs: List[Program]) -> Dict[str, Dict[str, float]]:
    """Quick benchmark of O0 raw wasm to measure wasm/native ratio and wasm ms."""
    results: Dict[str, Dict[str, float]] = {}
    for prog in programs:
        if not prog.native_bin.exists() or not prog.raw_wasm.exists():
            print(f"  [skip] {prog.name}: build artifacts missing")
            continue
        print(f"  [bench] {prog.name} ...", end=" ", flush=True)
        nb = bench_native(prog, repeats=QUICK_REPEATS, warmup=QUICK_WARMUP, timeout=BENCH_TIMEOUT)
        wasmu = BUILD_DIR / f"{prog.name}.raw_baseline.wasmu"
        wb = bench_wasm_aot(prog.raw_wasm, wasmu, repeats=QUICK_REPEATS, warmup=QUICK_WARMUP, timeout=BENCH_TIMEOUT)
        if nb.ok and wb.ok:
            native_ms = nb.internal.get("median", 0.0)
            wasm_ms = wb.internal.get("median", 0.0)
            ratio = round(wasm_ms / native_ms, 4) if native_ms > 0 else 0.0
            results[prog.name] = {
                "wasmer_aot_ratio": ratio,
                "wasmer_aot_wasm_ms": round(wasm_ms, 4),
            }
            print(f"ratio={ratio:.3f}  wasm={wasm_ms:.1f}ms  native={native_ms:.1f}ms")
        else:
            print(f"FAILED (native={'ok' if nb.ok else 'fail'}  wasm={'ok' if wb.ok else 'fail'})")
            if not nb.ok:
                print(f"    native error: {nb.error}")
            if not wb.ok:
                print(f"    wasm error: {wb.error}")
    return results


def update_programs_csv(measurements: Dict[str, Dict[str, float]]) -> None:
    """Patch config/programs.csv with the measured O0 baseline values."""
    csv_path = CONFIG_DIR / "programs.csv"
    rows: List[Dict[str, str]] = []
    with csv_path.open(newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames or []
        for r in reader:
            name = r["program"].strip()
            if name in measurements:
                r["wasmer_aot_ratio"] = str(measurements[name]["wasmer_aot_ratio"])
                r["wasmer_aot_wasm_ms"] = str(measurements[name]["wasmer_aot_wasm_ms"])
            rows.append(r)

    with csv_path.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames)
        w.writeheader()
        w.writerows(rows)
    print(f"[ok] updated {csv_path} with O0 baseline measurements")


def main() -> None:
    ap = argparse.ArgumentParser(description="Build O0 wasm/native and measure baseline timing.")
    ap.add_argument("--wasi-cc", default="/opt/wasi-sdk/bin/clang")
    ap.add_argument("--native-cc", default="clang")
    ap.add_argument("--skip-build", action="store_true",
                    help="Skip recompilation; only re-run timing measurements.")
    ap.add_argument("--skip-measure", action="store_true",
                    help="Skip timing; only (re-)compile.")
    args = ap.parse_args()

    missing = check_tools()
    if missing:
        raise SystemExit(f"missing tools on PATH: {missing}")

    programs = load_programs()
    prog_names = [p.name for p in programs]

    if not args.skip_build:
        print(f"\n=== Step 1: compile {len(prog_names)} programs with -O0 ===")
        ok_map = run_build(args.wasi_cc, args.native_cc, prog_names)
        built = sum(1 for v in ok_map.values() if v)
        failed = [n for n, v in ok_map.items() if not v]
        print(f"[build] ok={built}/{len(ok_map)}")
        if failed:
            print(f"[build] failed: {failed}")
    else:
        print("[build] skipping compilation (--skip-build)")

    if not args.skip_measure:
        print("\n=== Step 2: measuring O0 baseline timing ===")
        measurements = measure_baseline(programs)
        if measurements:
            update_programs_csv(measurements)
        else:
            print("[warn] no measurements collected; programs.csv not updated")
    else:
        print("[measure] skipping timing (--skip-measure)")

    print("\n[done] O0 build artifacts are in:", BUILD_DIR)
    print("       Run s02_extract_features.py next.")


if __name__ == "__main__":
    main()
