#!/usr/bin/env python3
"""
Build all 30 PolyBench/C kernels (native + wasm) using the internal PolyBench
timer (POLYBENCH_TIME).

This script is meant to be run inside the wasm-dev Docker container, from the
project root (/code).

It relies on:
- native compiler: clang (or override via --native-cc)
- WASI compiler:  /opt/wasi-sdk/bin/clang (or override via --wasi-cc)

Outputs go to data/polybench_build:
- <name>.native  (Linux executable)
- <name>.wasm    (WASI module)
- build_report_polybench.csv
"""

import argparse
import csv
import shlex
import subprocess
from pathlib import Path
from typing import List, Tuple


POLYBENCH_ROOT_DEFAULT = "data/webassembly-polybench-c-master"


def run_cmd(cmd: List[str], cwd: Path | None = None) -> subprocess.CompletedProcess:
    print("$", " ".join(shlex.quote(c) for c in cmd))
    return subprocess.run(
        cmd,
        cwd=str(cwd) if cwd else None,
        capture_output=True,
        text=True,
    )


def kernel_name_from_rel(rel_path: Path) -> str:
    """
    Derive a stable short name from the benchmark_list entry.

    Examples:
    - datamining/correlation/correlation.c   -> correlation
    - linear-algebra/kernels/2mm/2mm.c      -> 2mm
    - stencils/jacobi-2d/jacobi-2d.c        -> jacobi-2d
    """
    return rel_path.stem


def compile_one(
    root: Path,
    rel_c_path: Path,
    out_dir: Path,
    native_cc: str,
    wasi_cc: str,
    opt_flag: str,
    wasi_target: str,
    wasi_sysroot: str,
) -> Tuple[dict, list[str]]:
    """
    Compile a single PolyBench kernel to native and wasm.
    Returns:
      - row dict for CSV
      - list of human-readable log lines (for optional debugging)
    """
    logs: list[str] = []

    c_path = root / rel_c_path
    if not c_path.exists():
        name = kernel_name_from_rel(rel_c_path)
        return (
            {
                "program": name,
                "c_path": str(rel_c_path),
                "native_ok": 0,
                "wasm_ok": 0,
                "native_bin": "",
                "wasm_file": "",
                "native_error": f"missing source {c_path}",
                "wasm_error": f"missing source {c_path}",
            },
            logs,
        )

    name = kernel_name_from_rel(rel_c_path)
    native_bin = out_dir / f"{name}.native"
    wasm_file = out_dir / f"{name}.wasm"

    logs.append(f"=== Building {name} ({rel_c_path}) ===")

    # Include dirs: PolyBench utilities + directory of the kernel
    include_util = root / "utilities"
    include_kernel_dir = c_path.parent

    # Native build
    native_cmd = [
        native_cc,
        opt_flag,
        "-I",
        str(include_util),
        "-I",
        str(include_kernel_dir),
        str(root / "utilities" / "polybench.c"),
        str(c_path),
        "-DPOLYBENCH_TIME",
        "-o",
        str(native_bin),
        "-lm",
    ]
    p_native = run_cmd(native_cmd)
    native_ok = p_native.returncode == 0
    if not native_ok:
        logs.append(f"[native] failed for {name}: {p_native.stderr.strip()}")

    # WASM build (WASI)
    wasm_cmd = [
        wasi_cc,
        opt_flag,
        "-target",
        wasi_target,
        "-I",
        str(include_util),
        "-I",
        str(include_kernel_dir),
        str(root / "utilities" / "polybench.c"),
        str(c_path),
        "-DPOLYBENCH_TIME",
        "-o",
        str(wasm_file),
    ]
    if wasi_sysroot:
        wasm_cmd[4:4] = ["--sysroot", wasi_sysroot]
    p_wasm = run_cmd(wasm_cmd)
    wasm_ok = p_wasm.returncode == 0
    if not wasm_ok:
        logs.append(f"[wasm] failed for {name}: {p_wasm.stderr.strip()}")

    row = {
        "program": name,
        "c_path": str(rel_c_path),
        "native_ok": int(native_ok),
        "wasm_ok": int(wasm_ok),
        "native_bin": str(native_bin),
        "wasm_file": str(wasm_file),
        "native_error": p_native.stderr.strip(),
        "wasm_error": p_wasm.stderr.strip(),
    }
    return row, logs


def load_benchmark_list(root: Path) -> list[Path]:
    """
    Read utilities/benchmark_list and return a list of relative Paths to .c files.
    """
    bl_path = root / "utilities" / "benchmark_list"
    if not bl_path.exists():
        raise FileNotFoundError(f"benchmark_list not found at {bl_path}")

    rel_paths: list[Path] = []
    for line in bl_path.read_text(encoding="utf-8", errors="ignore").splitlines():
        s = line.strip()
        if not s or s.startswith("#"):
            continue
        # Entries are like: ./datamining/correlation/correlation.c
        if s.startswith("./"):
            s = s[2:]
        rel_paths.append(Path(s))
    return rel_paths


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--polybench-root",
        default=POLYBENCH_ROOT_DEFAULT,
        help="Root of webassembly-polybench-c-master",
    )
    parser.add_argument(
        "--out-dir",
        default="data/polybench_build",
        help="Directory for compiled artifacts",
    )
    parser.add_argument(
        "--native-cc",
        default="clang",
        help="Native C compiler (default: clang)",
    )
    parser.add_argument(
        "--wasi-cc",
        default="/opt/wasi-sdk/bin/clang",
        help="WASI C compiler (default: /opt/wasi-sdk/bin/clang)",
    )
    parser.add_argument(
        "--opt",
        default="-O3",
        help="Optimization flag passed to compilers (default: -O3)",
    )
    parser.add_argument(
        "--wasi-target",
        default="wasm32-wasip1",
        help="WASI target triple (default: wasm32-wasip1)",
    )
    parser.add_argument(
        "--wasi-sysroot",
        default="",
        help="Optional WASI sysroot passed as --sysroot",
    )
    parser.add_argument(
        "--report",
        default="data/results/build_report_polybench.csv",
        help="CSV path for build report",
    )
    args = parser.parse_args()

    root = Path(args.polybench_root)
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    report_path = Path(args.report)
    report_path.parent.mkdir(parents=True, exist_ok=True)

    rel_c_paths = load_benchmark_list(root)
    rows: list[dict] = []

    for rel in rel_c_paths:
        row, logs = compile_one(
            root=root,
            rel_c_path=rel,
            out_dir=out_dir,
            native_cc=args.native_cc,
            wasi_cc=args.wasi_cc,
            opt_flag=args.opt,
            wasi_target=args.wasi_target,
            wasi_sysroot=args.wasi_sysroot,
        )
        for line in logs:
            print(line)
        rows.append(row)

    with report_path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "program",
                "c_path",
                "native_ok",
                "wasm_ok",
                "native_bin",
                "wasm_file",
                "native_error",
                "wasm_error",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)

    total = len(rows)
    native_ok_n = sum(r["native_ok"] for r in rows)
    wasm_ok_n = sum(r["wasm_ok"] for r in rows)

    print("\n=== PolyBench Build Summary ===")
    print(f"total kernels: {total}")
    print(f"native ok:     {native_ok_n}/{total}")
    print(f"wasm ok:       {wasm_ok_n}/{total}")
    print(f"report:        {report_path}")


if __name__ == "__main__":
    main()

