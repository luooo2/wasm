#!/usr/bin/env python3
"""
build_polybench_benchmarks.py

Compile selected PolyBench/C kernels to:
  1) native binary  (.native)
  2) LLVM IR        (.ll)
  3) wasm binary    (.wasm)

Key differences from build_benchmarks.py (microbenchmarks):
  - Each kernel lives in its own subdirectory with its own .h file.
  - We link against polybench_stub.c instead of the original polybench.c
    so that both native and wasm32-wasip1 builds work without any changes
    to the kernel source files.
  - Dataset size is controlled with -DMEDIUM_DATASET (adjustable via --dataset).
  - Output binaries are prefixed with 'poly_' to avoid name collisions with
    the existing microbenchmarks in data/build/.

Selected kernel list (8 kernels, see KERNEL_LIST below):

  Kernel             Category        Reason for selection
  ---------          -----------     ------------------------------------------------------
  gemm               BLAS            Dense matmul; high compute_density, deep loops
  gemver             BLAS            Mixed matmul+vector; moderate compute+memory
  gesummv            BLAS            Sym matmul+vector; similar to gemver, lighter
  2mm                kernels         Two consecutive matmuls; more loop depth
  atax               kernels         Ax + A^Tx pattern; different memory access shape
  jacobi-1d          stencils        Simple 1-D stencil; high memory_access_density
  jacobi-2d          stencils        2-D stencil; deep nested loop
  floyd-warshall     medley          Triple-nested loop with branch; tests branch_density

These 8 kernels were chosen to:
  - Cover high compute_density (likely -> similar / wasm-better)
  - Cover stencil/memory-heavy patterns (explore memory_access_density axis)
  - Add moderate branch structure (floyd-warshall)
  - Avoid kernels with sqrt/pow/transcendental by default (those need libm,
    and wasm libm behaviour can differ; kept for a later batch)
"""

import argparse
import csv
import shlex
import subprocess
from pathlib import Path
from typing import List, Dict

# ---------------------------------------------------------------------------
# Kernel registry
# Each entry: (output_stem, path_relative_to_polybench_root, kernel_h_dir)
# path_relative_to_polybench_root is the directory containing the .c file.
# ---------------------------------------------------------------------------
KERNEL_LIST: List[Dict] = [
    {
        "name":    "poly_gemm",
        "reldir":  "linear-algebra/blas/gemm",
        "cstem":   "gemm",
    },
    {
        "name":    "poly_gemver",
        "reldir":  "linear-algebra/blas/gemver",
        "cstem":   "gemver",
    },
    {
        "name":    "poly_gesummv",
        "reldir":  "linear-algebra/blas/gesummv",
        "cstem":   "gesummv",
    },
    {
        "name":    "poly_2mm",
        "reldir":  "linear-algebra/kernels/2mm",
        "cstem":   "2mm",
    },
    {
        "name":    "poly_atax",
        "reldir":  "linear-algebra/kernels/atax",
        "cstem":   "atax",
    },
    {
        "name":    "poly_jacobi_1d",
        "reldir":  "stencils/jacobi-1d",
        "cstem":   "jacobi-1d",
    },
    {
        "name":    "poly_jacobi_2d",
        "reldir":  "stencils/jacobi-2d",
        "cstem":   "jacobi-2d",
    },
    {
        "name":    "poly_floyd_warshall",
        "reldir":  "medley/floyd-warshall",
        "cstem":   "floyd-warshall",
    },
]


def run_cmd(cmd: List[str], cwd: Path = None) -> subprocess.CompletedProcess:
    print("$", " ".join(shlex.quote(c) for c in cmd))
    return subprocess.run(
        cmd,
        cwd=str(cwd) if cwd else None,
        capture_output=True,
        text=True,
    )


def build_kernel(
    kernel: Dict,
    poly_root: Path,
    out_dir: Path,
    native_cc: str,
    wasi_cc: str,
    opt: str,
    wasi_target: str,
    dataset: str,
) -> Dict:
    name    = kernel["name"]
    reldir  = kernel["reldir"]
    cstem   = kernel["cstem"]

    src_dir  = poly_root / reldir
    c_file   = src_dir / f"{cstem}.c"
    util_dir = poly_root / "utilities"
    stub_c   = util_dir / "polybench_stub.c"

    native_bin = out_dir / f"{name}.native"
    ir_file    = out_dir / f"{name}.ll"
    wasm_file  = out_dir / f"{name}.wasm"

    print(f"\n=== Building {name} ===")

    # Common flags shared by all builds
    common_flags = [
        opt,
        f"-D{dataset}",
        "-I", str(util_dir),   # find polybench.h
        "-I", str(src_dir),    # find kernel-specific .h  (e.g. gemm.h)
    ]

    # ---- native binary ----
    p_native = run_cmd([
        native_cc,
        *common_flags,
        str(stub_c),
        str(c_file),
        "-o", str(native_bin),
    ])
    native_ok = p_native.returncode == 0

    # ---- LLVM IR (native clang, emit-llvm) ----
    # We compile only the kernel .c (not stub) to IR so that
    # extract_features.py sees a clean single-module IR.
    p_ir = run_cmd([
        native_cc,
        *common_flags,
        "-S", "-emit-llvm",
        str(c_file),
        "-o", str(ir_file),
    ])
    ir_ok = p_ir.returncode == 0

    # ---- wasm binary ----
    p_wasm = run_cmd([
        wasi_cc,
        *common_flags,
        "-target", wasi_target,
        str(stub_c),
        str(c_file),
        "-o", str(wasm_file),
    ])
    wasm_ok = p_wasm.returncode == 0

    return {
        "program":      name,
        "native_ok":    int(native_ok),
        "ir_ok":        int(ir_ok),
        "wasm_ok":      int(wasm_ok),
        "native_bin":   str(native_bin),
        "ir_file":      str(ir_file),
        "wasm_file":    str(wasm_file),
        "native_error": p_native.stderr.strip(),
        "ir_error":     p_ir.stderr.strip(),
        "wasm_error":   p_wasm.stderr.strip(),
    }


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Compile selected PolyBench/C kernels for native + wasm measurement."
    )
    parser.add_argument(
        "--poly-root",
        default="data/polybench-c-4.2.1-beta",
        help="Root directory of PolyBench/C source tree",
    )
    parser.add_argument(
        "--out-dir",
        default="data/build",
        help="Output directory (shared with microbenchmarks)",
    )
    parser.add_argument("--native-cc",   default="clang")
    parser.add_argument("--wasi-cc",     default="/opt/wasi-sdk/bin/clang")
    parser.add_argument("--opt",         default="-O2")
    parser.add_argument("--wasi-target", default="wasm32-wasip1")
    parser.add_argument(
        "--dataset",
        default="MEDIUM_DATASET",
        choices=["MINI_DATASET", "SMALL_DATASET", "MEDIUM_DATASET",
                 "LARGE_DATASET", "EXTRALARGE_DATASET"],
        help="PolyBench dataset size macro",
    )
    parser.add_argument(
        "--kernels",
        default="",
        help="Comma-separated list of output stems to build (default: all). Example: poly_gemm,poly_jacobi_1d",
    )
    args = parser.parse_args()

    poly_root = Path(args.poly_root)
    out_dir   = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    kernels_to_build = KERNEL_LIST
    if args.kernels:
        wanted = set(args.kernels.split(','))
        kernels_to_build = [k for k in KERNEL_LIST if k['name'] in wanted]
        if not kernels_to_build:
            print(f'No matching kernels found for: {args.kernels}')
            return

    rows = []
    for kernel in kernels_to_build:
        row = build_kernel(
            kernel=kernel,
            poly_root=poly_root,
            out_dir=out_dir,
            native_cc=args.native_cc,
            wasi_cc=args.wasi_cc,
            opt=args.opt,
            wasi_target=args.wasi_target,
            dataset=args.dataset,
        )
        rows.append(row)

    report_path = out_dir / 'build_report_polybench.csv'
    fieldnames = [
        'program', 'native_ok', 'ir_ok', 'wasm_ok',
        'native_bin', 'ir_file', 'wasm_file',
        'native_error', 'ir_error', 'wasm_error',
    ]
    with report_path.open('w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    total       = len(rows)
    native_ok_n = sum(r['native_ok'] for r in rows)
    ir_ok_n     = sum(r['ir_ok']     for r in rows)
    wasm_ok_n   = sum(r['wasm_ok']   for r in rows)

    print('\n=== Build Summary (PolyBench) ===')
    print(f'native ok: {native_ok_n}/{total}')
    print(f'ir ok:     {ir_ok_n}/{total}')
    print(f'wasm ok:   {wasm_ok_n}/{total}')
    print(f'report:    {report_path}')


if __name__ == '__main__':
    main()
