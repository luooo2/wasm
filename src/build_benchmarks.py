#!/usr/bin/env python3
"""
Batch compile C microbenchmarks to:
1) native binary
2) LLVM IR (.ll)
3) wasm binary (.wasm)

Designed for wasm-dev-container environment:
- native clang: clang
- wasi clang: /opt/wasi-sdk/bin/clang
"""

import argparse
import csv
import shlex
import subprocess
from pathlib import Path
from typing import List


def run_cmd(cmd: List[str], cwd: Path = None) -> subprocess.CompletedProcess:
    print("$", " ".join(shlex.quote(c) for c in cmd))
    return subprocess.run(cmd, cwd=str(cwd) if cwd else None, capture_output=True, text=True)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--src-dir", default="data/microbenchmarks", help="Directory of .c benchmark files")
    parser.add_argument("--out-dir", default="data/build", help="Output directory")
    parser.add_argument("--native-cc", default="clang", help="Native compiler")
    parser.add_argument("--wasi-cc", default="/opt/wasi-sdk/bin/clang", help="WASI clang path")
    parser.add_argument("--opt", default="-O2", help="Optimization level")
    parser.add_argument("--wasi-target", default="wasm32-wasip1", help="WASI target triple")
    args = parser.parse_args()

    src_dir = Path(args.src_dir)
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    c_files = sorted(src_dir.glob("*.c"))
    if not c_files:
        print(f"No .c files found in {src_dir}")
        return

    rows = []
    for c_file in c_files:
        name = c_file.stem
        native_bin = out_dir / f"{name}.native"
        ir_file = out_dir / f"{name}.ll"
        wasm_file = out_dir / f"{name}.wasm"

        print(f"\n=== Building {name} ===")

        p_native = run_cmd([args.native_cc, args.opt, str(c_file), "-o", str(native_bin)])
        native_ok = p_native.returncode == 0

        p_ir = run_cmd([args.native_cc, args.opt, "-S", "-emit-llvm", str(c_file), "-o", str(ir_file)])
        ir_ok = p_ir.returncode == 0

        p_wasm = run_cmd([
            args.wasi_cc,
            args.opt,
            "-target",
            args.wasi_target,
            str(c_file),
            "-o",
            str(wasm_file),
        ])
        wasm_ok = p_wasm.returncode == 0

        rows.append(
            {
                "program": name,
                "native_ok": int(native_ok),
                "ir_ok": int(ir_ok),
                "wasm_ok": int(wasm_ok),
                "native_bin": str(native_bin),
                "ir_file": str(ir_file),
                "wasm_file": str(wasm_file),
                "native_error": p_native.stderr.strip(),
                "ir_error": p_ir.stderr.strip(),
                "wasm_error": p_wasm.stderr.strip(),
            }
        )

    report_path = out_dir / "build_report.csv"
    with report_path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "program",
                "native_ok",
                "ir_ok",
                "wasm_ok",
                "native_bin",
                "ir_file",
                "wasm_file",
                "native_error",
                "ir_error",
                "wasm_error",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)

    total = len(rows)
    native_ok_n = sum(r["native_ok"] for r in rows)
    ir_ok_n = sum(r["ir_ok"] for r in rows)
    wasm_ok_n = sum(r["wasm_ok"] for r in rows)

    print("\n=== Build Summary ===")
    print(f"native ok: {native_ok_n}/{total}")
    print(f"ir ok:     {ir_ok_n}/{total}")
    print(f"wasm ok:   {wasm_ok_n}/{total}")
    print(f"report:    {report_path}")


if __name__ == "__main__":
    main()
