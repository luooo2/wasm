#!/usr/bin/env python3
"""
Extract PolyBench static features (per assets/特征设计final.md) and merge with
PolyBench labels (AOT) produced by src/run_polybench.py.

Output:
- data/results/dataset_polybench.csv  (features + label_aot)
"""

from __future__ import annotations

import argparse
import csv
import re
import shlex
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Optional, Tuple

ROOT = Path(__file__).parent.parent
POLY_ROOT_DEFAULT = ROOT / "data" / "webassembly-polybench-c-master"
BENCH_LIST_REL = Path("utilities") / "benchmark_list"

# [FIX] 补充了 icmp, fcmp 等关键比较指令
COMPUTE_OPS = {
    "add", "sub", "mul", "udiv", "sdiv", "urem", "srem",
    "fadd", "fsub", "fmul", "fdiv", "frem",
    "and", "or", "xor", "shl", "lshr", "ashr",
    "icmp", "fcmp" 
}
# [FIX] 补充了 alloca 和 getelementptr (GEP)
MEMORY_OPS = {"load", "store", "atomicrmw", "cmpxchg", "alloca", "getelementptr"}
BRANCH_OPS = {"br", "switch", "indirectbr", "select"}
CALL_OPS = {"call", "invoke", "callbr"}

HOST_IO = {
    "printf", "fprintf", "puts", "putchar", "fputs", "read", 
    "write", "fread", "fwrite", "open", "close", "fopen", "fclose"
}
HOST_TIME = {"time", "gettimeofday", "clock_gettime", "clock"}
HOST_FS = {"getcwd", "chdir", "stat", "lstat", "fstat", "opendir", "readdir"}

RE_LABEL = re.compile(r"^[A-Za-z0-9$._-]+:\s*(;.*)?$")

# [FIX] 兼容 LLVM 中特有的 tail/musttail/notail 前缀，防止遗漏 call 指令
RE_INST = re.compile(
    r"^\s*(?:[%@][A-Za-z0-9$._-]+\s*=\s*)?(?:tail\s+|musttail\s+|notail\s+)?([A-Za-z_][A-Za-z0-9_.]*)\b"
)
RE_DEFINE = re.compile(r"^\s*define\b")
RE_CALL_CALLEE = re.compile(r"\b(?:call|invoke|callbr)\b.*?@([A-Za-z_][A-Za-z0-9_$.]*)")
RE_CALL_ANY = re.compile(r"\b(?:call|invoke|callbr)\b")
RE_INDIRECT_CALL = re.compile(r"\b(?:call|invoke|callbr)\b[^@]*[%]")

RE_SWITCH_LABELS = re.compile(r"\blabel\s+%[A-Za-z0-9$._-]+")


def safe_div(a: float, b: float) -> float:
    return a / b if b else 0.0

def run_cmd(cmd: List[str], cwd: Optional[Path] = None, timeout_sec: int = 180) -> subprocess.CompletedProcess:
    print("$", " ".join(shlex.quote(c) for c in cmd))
    return subprocess.run(
        cmd, cwd=str(cwd) if cwd else None, capture_output=True, text=True, timeout=timeout_sec
    )

def load_benchmark_list(poly_root: Path) -> List[Path]:
    bench_list = poly_root / BENCH_LIST_REL
    lines = bench_list.read_text(encoding="utf-8", errors="ignore").splitlines()
    rels: List[Path] = []
    for ln in lines:
        s = ln.strip()
        if not s or s.startswith("#"):
            continue
        if s.startswith("./"):
            s = s[2:]
        rels.append(Path(s))
    return rels

def load_aot_labels(summary_csv: Path) -> Dict[str, str]:
    labels: Dict[str, str] = {}
    with summary_csv.open("r", encoding="utf-8", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            prog = (row.get("program") or "").strip()
            lab = (row.get("label_aot") or "").strip()
            if prog:
                labels[prog] = lab
    return labels

def source_max_loop_depth(c_text: str) -> int:
    # [FIX] 过滤 C 语言的注释和字符串，防止内部文字影响正则匹配
    clean_text = re.sub(r'//.*', '', c_text)
    clean_text = re.sub(r'/\*.*?\*/', '', clean_text, flags=re.DOTALL)
    clean_text = re.sub(r'".*?"', '""', clean_text)
    
    max_depth = 0
    depth = 0
    pending_loop = 0
    block_depths = [] # 记录进入大括号时消耗的 pending_loop
    
    # [FIX] 增加 \b 边界，防止匹配到 force 等变量名
    tokens = re.findall(r"\b(?:for|while|do)\b|\{|\}", clean_text)
    for tk in tokens:
        if tk in {"for", "while", "do"}:
            pending_loop += 1
        elif tk == "{":
            depth += pending_loop
            max_depth = max(max_depth, depth)
            block_depths.append(pending_loop)
            pending_loop = 0
        elif tk == "}":
            if block_depths:
                depth -= block_depths.pop()
    return max_depth

@dataclass
class IRStats:
    total_instr_count: int
    basic_block_count: int
    br_instr_count: int
    call_instr_count: int
    indirect_call_count: int
    compute_instr_count: int
    mem_instr_count: int
    func_count: int
    syscall_count: int
    io_call_count: int
    avg_bb_out_degree: float
    loop_instr_count: int

def parse_ir_stats(
    ll_text: str,
    *,
    scope: str = "module",
    kernel_prefix: str = "kernel_",
    loop_bbs: Optional[set[str]] = None,
) -> IRStats:
    inst_cnt = bb_cnt = br_cnt = call_cnt = indir_call_cnt = 0
    compute_cnt = mem_cnt = func_cnt = syscall_cnt = io_cnt = 0
    total_succ = 0

    current_bb: Optional[str] = None
    bb_instr_count: Dict[str, int] = {}
    current_fn: Optional[str] = None
    in_selected_fn = True
    in_switch = False

    for raw in ll_text.splitlines():
        line = raw.strip()
        if not line or line.startswith(";"):
            continue

        if RE_DEFINE.match(line):
            m = re.search(r"@([A-Za-z0-9$._-]+)\s*\(", line)
            current_fn = m.group(1) if m else None
            if scope == "kernel":
                in_selected_fn = bool(current_fn and current_fn.startswith(kernel_prefix))
            else:
                in_selected_fn = True
            
            # [FIX] 只统计位于作用域内的函数总数
            if in_selected_fn:
                func_cnt += 1
            continue

        if line == "}":
            current_fn = None
            in_selected_fn = True
            current_bb = None
            in_switch = False
            continue

        if not in_selected_fn:
            continue

        if RE_LABEL.match(line):
            bb_cnt += 1
            current_bb = line.split(":", 1)[0]
            if current_bb not in bb_instr_count:
                bb_instr_count[current_bb] = 0
            continue

        # [FIX] 专门处理跨行的 switch 指令
        if in_switch:
            if "]" in line:
                in_switch = False
            else:
                total_succ += len(RE_SWITCH_LABELS.findall(line))
            
            # switch 内部的 label 行不是普通指令，直接 continue
            if not RE_INST.match(line):
                continue

        m = RE_INST.match(line)
        if not m:
            continue

        op = m.group(1)
        inst_cnt += 1
        if current_bb is not None:
            bb_instr_count[current_bb] = bb_instr_count.get(current_bb, 0) + 1

        if op in COMPUTE_OPS:
            compute_cnt += 1
        if op in MEMORY_OPS:
            mem_cnt += 1
        if op in BRANCH_OPS:
            br_cnt += 1
        if op in CALL_OPS:
            call_cnt += 1
            callee = None
            mm = RE_CALL_CALLEE.search(line)
            if mm:
                callee = mm.group(1)
            if RE_INDIRECT_CALL.search(line) and callee is None:
                indir_call_cnt += 1

            if callee:
                if callee in HOST_IO:
                    io_cnt += 1
                    syscall_cnt += 1
                elif callee in HOST_TIME or callee in HOST_FS:
                    syscall_cnt += 1

        # CFG 出度统计
        if op == "br":
            succ = 2 if ", label %" in line else 1
            total_succ += succ
        elif op == "switch":
            in_switch = True
            succ = len(RE_SWITCH_LABELS.findall(line))
            total_succ += max(succ, 1)

    avg_out = safe_div(float(total_succ), float(bb_cnt))

    loop_instr = 0
    if loop_bbs:
        for bb in loop_bbs:
            loop_instr += bb_instr_count.get(bb, 0)

    return IRStats(
        total_instr_count=inst_cnt,
        basic_block_count=bb_cnt,
        br_instr_count=br_cnt,
        call_instr_count=call_cnt,
        indirect_call_count=indir_call_cnt,
        compute_instr_count=compute_cnt,
        mem_instr_count=mem_cnt,
        func_count=func_cnt,
        syscall_count=syscall_cnt,
        io_call_count=io_cnt,
        avg_bb_out_degree=round(avg_out, 6),
        loop_instr_count=loop_instr,
    )

def try_get_loop_bbs_with_opt(opt_cmd: str, ll_path: Path) -> Optional[set[str]]:
    try:
        p = run_cmd([opt_cmd, "-disable-output", "-passes=print<loop-info>", str(ll_path)], timeout_sec=180)
    except (FileNotFoundError, subprocess.TimeoutExpired):
        return None

    text = (p.stderr or "") + "\n" + (p.stdout or "")
    if p.returncode != 0 or not text.strip():
        return None

    bbs = set()
    for m in re.finditer(r"%([A-Za-z0-9$._-]+)", text):
        bbs.add(m.group(1))
    return bbs if bbs else None

def emit_llvm_ir(
    clang_cmd: str, poly_root: Path, kernel_rel_c: Path, out_ll: Path, opt_flag: str, dataset_macro: str,
    extra_args: Optional[List[str]] = None,
) -> Tuple[bool, str]:
    kernel_c = poly_root / kernel_rel_c
    inc_util = poly_root / "utilities"
    inc_kernel = kernel_c.parent

    cmd = [clang_cmd, opt_flag, "-S", "-emit-llvm", "-I", str(inc_util), "-I", str(inc_kernel), str(kernel_c), "-o", str(out_ll)]
    if dataset_macro:
        cmd.insert(1, f"-D{dataset_macro}")
    if extra_args:
        cmd[1:1] = extra_args

    try:
        p = run_cmd(cmd, cwd=ROOT, timeout_sec=180)
    except subprocess.TimeoutExpired:
        return False, "clang -emit-llvm timeout"

    if p.returncode != 0:
        return False, (p.stderr or p.stdout or "").strip()
    return True, ""

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--poly-root", default=str(POLY_ROOT_DEFAULT), help="PolyBench root directory")
    parser.add_argument("--summary-csv", default="data/results/polybench_summary.csv", help="PolyBench summary CSV (labels)")
    parser.add_argument("--out-csv", default="data/results/dataset_polybench.csv", help="Output dataset CSV")
    parser.add_argument("--ir-out-dir", default="data/polybench_ir", help="Directory to store generated *.ll files")
    parser.add_argument("--clang", default="native-clang", help="Native clang command (container default: native-clang)")
    parser.add_argument("--wasi-clang", default="wasi-clang", help="WASI clang command to use as fallback")
    parser.add_argument("--wasi-target", default="wasm32-wasip1", help="WASI target triple for fallback IR emission")
    parser.add_argument("--opt", default="opt", help="LLVM opt command (optional, for LoopInfo)")
    parser.add_argument("--opt-flag", default="-O0", help="Optimization flag for IR emission (default -O0)")
    parser.add_argument("--scope", choices=["module", "kernel"], default="module", help="Feature scope")
    parser.add_argument("--dataset", default="", help="Optional dataset macro (e.g., MINI_DATASET)")
    args = parser.parse_args()

    poly_root = Path(args.poly_root)
    summary_csv = ROOT / args.summary_csv
    out_csv = ROOT / args.out_csv
    ir_out_dir = ROOT / args.ir_out_dir

    out_csv.parent.mkdir(parents=True, exist_ok=True)
    ir_out_dir.mkdir(parents=True, exist_ok=True)

    labels = load_aot_labels(summary_csv)
    kernels = load_benchmark_list(poly_root)
    rows: List[Dict[str, object]] = []

    for rel_c in kernels:
        program = rel_c.stem
        c_path = poly_root / rel_c
        c_text = c_path.read_text(encoding="utf-8", errors="ignore")
        max_loop_depth = source_max_loop_depth(c_text)

        ll_path = ir_out_dir / f"{program}.ll"
        ok_ir, err = emit_llvm_ir(args.clang, poly_root, rel_c, ll_path, args.opt_flag, args.dataset)
        if not ok_ir and "unistd.h" in err:
            ok_ir, err = emit_llvm_ir(
                args.wasi_clang, poly_root, rel_c, ll_path, args.opt_flag, args.dataset,
                extra_args=["-target", args.wasi_target],
            )
        if not ok_ir:
            print(f"[WARN] IR emit failed for {program}: {err}")
            continue

        ll_text = ll_path.read_text(encoding="utf-8", errors="ignore")
        loop_bbs = try_get_loop_bbs_with_opt(args.opt, ll_path)
        ir = parse_ir_stats(ll_text, scope=args.scope, loop_bbs=loop_bbs)

        br_density = safe_div(ir.br_instr_count, ir.total_instr_count)
        compute_density = safe_div(ir.compute_instr_count, ir.total_instr_count)
        ls_ratio = safe_div(ir.mem_instr_count, ir.total_instr_count)
        call_density = safe_div(ir.call_instr_count, ir.total_instr_count)
        syscall_density = safe_div(ir.syscall_count, ir.total_instr_count)
        io_density = safe_div(ir.io_call_count, ir.total_instr_count)
        avg_bb_size = safe_div(ir.total_instr_count, ir.basic_block_count)
        compute_mem_ratio = safe_div(ir.compute_instr_count, ir.mem_instr_count)
        call_bb_ratio = safe_div(ir.call_instr_count, ir.basic_block_count)

        label_aot = labels.get(program, "")

        rows.append({
            "program": program, "label": label_aot,
            "total_instr_count": ir.total_instr_count, "basic_block_count": ir.basic_block_count,
            "avg_bb_size": round(avg_bb_size, 6), "avg_bb_out_degree": ir.avg_bb_out_degree,
            "max_loop_depth": int(max_loop_depth), "loop_instr_count": int(ir.loop_instr_count),
            "br_instr_count": ir.br_instr_count, "br_density": round(br_density, 6),
            "compute_instr_count": ir.compute_instr_count, "compute_density": round(compute_density, 6),
            "mem_instr_count": ir.mem_instr_count, "ls_ratio": round(ls_ratio, 6),
            "func_count": ir.func_count, "call_instr_count": ir.call_instr_count,
            "indirect_call_count": ir.indirect_call_count, "call_density": round(call_density, 6),
            "syscall_count": ir.syscall_count, "syscall_density": round(syscall_density, 6),
            "io_call_count": ir.io_call_count, "io_density": round(io_density, 6),
            "compute_mem_ratio": round(compute_mem_ratio, 6), "call_bb_ratio": round(call_bb_ratio, 6),
        })
        print(f"extracted {program} (label_aot={label_aot or 'NA'})")

    fieldnames = [
        "program", "label", "total_instr_count", "basic_block_count", "avg_bb_size",
        "avg_bb_out_degree", "max_loop_depth", "loop_instr_count", "br_instr_count", "br_density",
        "compute_instr_count", "compute_density", "mem_instr_count", "ls_ratio", "func_count",
        "call_instr_count", "indirect_call_count", "call_density", "syscall_count", "syscall_density",
        "io_call_count", "io_density", "compute_mem_ratio", "call_bb_ratio",
    ]

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"\nDataset written: {out_csv} (rows={len(rows)})")

if __name__ == "__main__":
    main()