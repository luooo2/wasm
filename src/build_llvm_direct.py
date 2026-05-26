#!/usr/bin/env python3
"""
Build llvm-test-suite direct-run C benchmarks with internal timing wrapper.
"""

import argparse
import csv
import shlex
import subprocess
from pathlib import Path
from typing import Dict, List


def run_cmd(cmd: List[str]) -> subprocess.CompletedProcess:
    print("$", " ".join(shlex.quote(c) for c in cmd))
    return subprocess.run(cmd, capture_output=True, text=True)


def to_program_name(c_path: Path, bench_root: Path) -> str:
    rel = c_path.relative_to(bench_root)
    stem = str(rel.with_suffix("")).replace("\\", "_").replace("/", "_")
    return f"llvmss_{stem.lower()}"


def read_program_list(path: Path) -> set:
    if not path.exists():
        return set()
    vals = [x.strip() for x in path.read_text(encoding="utf-8").splitlines()]
    return {x for x in vals if x}


def read_strategy(path: Path) -> Dict[str, Dict[str, str]]:
    if not path.exists():
        return {}
    rows = list(csv.DictReader(path.open("r", encoding="utf-8", newline="")))
    out: Dict[str, Dict[str, str]] = {}
    for r in rows:
        key = (r.get("program") or "").strip()
        if key:
            out[key] = r
    return out


def list_flags(val: str) -> List[str]:
    vals = [x.strip() for x in (val or "").split(";")]
    return [x for x in vals if x]


def detect_wasi_sysroot(wasi_cc: str, requested_sysroot: str) -> str:
    if requested_sysroot:
        return requested_sysroot
    cc_path = Path(wasi_cc)
    if cc_path.exists():
        sdk_root = cc_path.parent.parent
        cand = sdk_root / "share" / "wasi-sysroot"
        if cand.is_dir():
            return str(cand)
    return ""


def detect_wasi_target(wasi_cc: str, requested_target: str) -> str:
    if requested_target:
        return requested_target
    try:
        p = subprocess.run(
            [wasi_cc, "--print-resource-dir"],
            capture_output=True,
            text=True,
            check=False,
        )
    except FileNotFoundError:
        return "wasm32-wasi"
    if p.returncode == 0:
        res = Path((p.stdout or "").strip())
        if (res / "lib" / "wasip1" / "libclang_rt.builtins-wasm32.a").is_file():
            return "wasm32-wasip1"
        if (res / "lib" / "wasi" / "libclang_rt.builtins-wasm32.a").is_file():
            return "wasm32-wasi"
    return "wasm32-wasi"


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--bench-root", default="data/llvm-test-suite/SingleSource/Benchmarks")
    ap.add_argument("--direct-list", default="data/results/llvm_direct_run_list.txt")
    ap.add_argument("--out-dir", default="data/build/llvm_direct")
    ap.add_argument("--wrapper", default="src/llvm_timing_wrapper.c")
    ap.add_argument("--native-cc", default="clang")
    ap.add_argument("--wasi-cc", default="/opt/wasi-sdk/bin/clang")
    ap.add_argument("--opt", default="-O2")
    ap.add_argument(
        "--wasi-target",
        default="",
        help="WASI target triple (auto-detect if empty)",
    )
    ap.add_argument(
        "--wasi-sysroot",
        default="",
        help="WASI sysroot path (auto-detect from wasi-cc if empty)",
    )
    ap.add_argument("--limit", type=int, default=0, help="Build first N direct-run programs (0=all)")
    ap.add_argument(
        "--strategy-csv",
        default="data/results/llvm_direct_build_strategy.csv",
        help="Per-program build strategy table",
    )
    args = ap.parse_args()

    bench_root = Path(args.bench_root)
    direct_list = Path(args.direct_list)
    out_dir = Path(args.out_dir)
    wrapper = Path(args.wrapper)
    out_dir.mkdir(parents=True, exist_ok=True)
    strategy = read_strategy(Path(args.strategy_csv))
    wasi_target = detect_wasi_target(args.wasi_cc, args.wasi_target)
    wasi_sysroot = detect_wasi_sysroot(args.wasi_cc, args.wasi_sysroot)
    wasi_extra_flags: List[str] = []
    if wasi_sysroot:
        wasi_extra_flags.append(f"--sysroot={wasi_sysroot}")
    print(f"[info] wasi_target={wasi_target}")
    if wasi_sysroot:
        print(f"[info] wasi_sysroot={wasi_sysroot}")
    else:
        print("[info] wasi_sysroot=<not-set>")

    wanted = read_program_list(direct_list)
    if not wanted:
        print(f"No direct-run program list found or empty: {direct_list}")
        return

    rows: List[Dict[str, str]] = []
    c_files = sorted(bench_root.rglob("*.c"))
    built = 0
    for c in c_files:
        if "Polybench" in c.parts:
            continue
        program = to_program_name(c, bench_root)
        if program not in wanted:
            continue
        if args.limit > 0 and built >= args.limit:
            break

        src_dir = c.parent
        native_bin = out_dir / f"{program}.native"
        wasm_file = out_dir / f"{program}.wasm"
        ir_file = out_dir / f"{program}.ll"

        common_inc = ["-I", str(src_dir)]
        main_rename = ["-Dmain=llvm_bench_main"]
        st = strategy.get(program, {})
        native_std = st.get("native_std", "gnu89")
        wasm_std = st.get("wasm_std", "gnu89")
        native_extra_cflags = list_flags(st.get("native_extra_cflags", ""))
        wasi_extra_cflags = list_flags(st.get("wasi_extra_cflags", ""))
        native_link_flags = list_flags(st.get("native_link_flags", ""))
        wasi_link_flags = list_flags(st.get("wasi_link_flags", ""))

        print(f"\n=== Building {program} ===")
        # Build benchmark object with renamed main, then link with wrapper.
        bench_native_o = out_dir / f"{program}.bench.native.o"
        wrapper_native_o = out_dir / f"{program}.wrapper.native.o"
        p_bench_native = run_cmd(
            [
                args.native_cc,
                args.opt,
                f"-std={native_std}",
                *common_inc,
                *main_rename,
                *native_extra_cflags,
                "-c",
                str(c),
                "-o",
                str(bench_native_o),
            ]
        )
        p_wrap_native = run_cmd(
            [
                args.native_cc,
                args.opt,
                "-std=gnu11",
                "-c",
                str(wrapper),
                "-o",
                str(wrapper_native_o),
            ]
        )
        if p_bench_native.returncode == 0 and p_wrap_native.returncode == 0:
            p_native = run_cmd(
                [
                    args.native_cc,
                    str(bench_native_o),
                    str(wrapper_native_o),
                    *native_link_flags,
                    "-o",
                    str(native_bin),
                ]
            )
        else:
            p_native = subprocess.CompletedProcess(
                args=[],
                returncode=1,
                stdout="",
                stderr=(p_bench_native.stderr or "") + "\n" + (p_wrap_native.stderr or ""),
            )
        p_ir = run_cmd(
            [
                args.native_cc,
                args.opt,
                *common_inc,
                *main_rename,
                "-S",
                "-emit-llvm",
                str(c),
                "-o",
                str(ir_file),
            ]
        )
        bench_wasm_o = out_dir / f"{program}.bench.wasm.o"
        wrapper_wasm_o = out_dir / f"{program}.wrapper.wasm.o"
        p_bench_wasm = run_cmd(
            [
                args.wasi_cc,
                args.opt,
                f"-std={wasm_std}",
                *common_inc,
                *main_rename,
                *wasi_extra_cflags,
                *wasi_extra_flags,
                "-target",
                wasi_target,
                "-c",
                str(c),
                "-o",
                str(bench_wasm_o),
            ]
        )
        p_wrap_wasm = run_cmd(
            [
                args.wasi_cc,
                args.opt,
                "-std=gnu11",
                *wasi_extra_flags,
                "-target",
                wasi_target,
                "-c",
                str(wrapper),
                "-o",
                str(wrapper_wasm_o),
            ]
        )
        if p_bench_wasm.returncode == 0 and p_wrap_wasm.returncode == 0:
            p_wasm = run_cmd(
                [
                    args.wasi_cc,
                    *wasi_extra_flags,
                    "-target",
                    wasi_target,
                    str(bench_wasm_o),
                    str(wrapper_wasm_o),
                    *wasi_link_flags,
                    "-o",
                    str(wasm_file),
                ]
            )
        else:
            p_wasm = subprocess.CompletedProcess(
                args=[],
                returncode=1,
                stdout="",
                stderr=(p_bench_wasm.stderr or "") + "\n" + (p_wrap_wasm.stderr or ""),
            )

        rows.append(
            {
                "program": program,
                "source_path": str(c).replace("\\", "/"),
                "native_ok": int(p_native.returncode == 0),
                "ir_ok": int(p_ir.returncode == 0),
                "wasm_ok": int(p_wasm.returncode == 0),
                "native_error": (p_native.stderr or "").strip(),
                "ir_error": (p_ir.stderr or "").strip(),
                "wasm_error": (p_wasm.stderr or "").strip(),
                "native_std": native_std,
                "wasm_std": wasm_std,
                "native_extra_cflags": ";".join(native_extra_cflags),
                "wasi_extra_cflags": ";".join(wasi_extra_cflags),
                "native_link_flags": ";".join(native_link_flags),
                "wasi_link_flags": ";".join(wasi_link_flags),
            }
        )
        built += 1

    report = out_dir / "build_report_llvm_direct.csv"
    with report.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(
            f,
            fieldnames=[
                "program",
                "source_path",
                "native_ok",
                "ir_ok",
                "wasm_ok",
                "native_error",
                "ir_error",
                "wasm_error",
                "native_std",
                "wasm_std",
                "native_extra_cflags",
                "wasi_extra_cflags",
                "native_link_flags",
                "wasi_link_flags",
            ],
        )
        w.writeheader()
        w.writerows(rows)

    print(f"\nbuilt programs: {built}")
    print(f"report: {report}")


if __name__ == "__main__":
    main()

