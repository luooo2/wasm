#!/usr/bin/env python3
"""
Thin convenience wrapper for building llvm-test-suite direct-run benchmarks.

This keeps naming/style aligned with src/build_polybench.py.
It forwards all common build arguments to src/build_llvm_direct.py.
"""

import argparse
import shlex
import subprocess
import sys
from pathlib import Path


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--bench-root", default="data/llvm-test-suite/SingleSource/Benchmarks")
    ap.add_argument("--direct-list", default="data/results/llvm_direct_run_list.txt")
    ap.add_argument("--out-dir", default="data/build/llvm_direct")
    ap.add_argument("--wrapper", default="src/llvm_timing_wrapper.c")
    ap.add_argument("--native-cc", default="clang")
    ap.add_argument("--wasi-cc", default="/opt/wasi-sdk/bin/clang")
    ap.add_argument("--opt", default="-O2")
    ap.add_argument("--wasi-target", default="")
    ap.add_argument("--wasi-sysroot", default="")
    ap.add_argument("--limit", type=int, default=0, help="Build first N programs (0=all)")
    ap.add_argument(
        "--strategy-csv",
        default="data/results/llvm_direct_build_strategy.csv",
        help="Per-program build strategy table",
    )
    args = ap.parse_args()

    direct_builder = Path(__file__).with_name("build_llvm_direct.py")
    cmd = [
        sys.executable,
        str(direct_builder),
        "--bench-root",
        args.bench_root,
        "--direct-list",
        args.direct_list,
        "--out-dir",
        args.out_dir,
        "--wrapper",
        args.wrapper,
        "--native-cc",
        args.native_cc,
        "--wasi-cc",
        args.wasi_cc,
        # Use --opt=<value> so values like -O2 are not re-parsed as options
        f"--opt={args.opt}",
        "--wasi-target",
        args.wasi_target,
        "--wasi-sysroot",
        args.wasi_sysroot,
        "--limit",
        str(args.limit),
        "--strategy-csv",
        args.strategy_csv,
    ]

    print("$", " ".join(shlex.quote(x) for x in cmd))
    p = subprocess.run(cmd)
    raise SystemExit(p.returncode)


if __name__ == "__main__":
    main()
