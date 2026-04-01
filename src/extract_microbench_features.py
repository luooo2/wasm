#!/usr/bin/env python3
"""
Extract microbench static features (per assets/特征设计final.md).

Input:
- C sources: data/microbenchmarks/*.c
- LLVM IR  : data/build/microbench_internal/*.ll
- Labels   : data/results/labels_microbench_internal.csv (optional)

Output:
- data/results/dataset_microbench.csv
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

COMPUTE_OPS = {
    "add", "sub", "mul", "udiv", "sdiv", "urem", "srem",
    "fadd", "fsub", "fmul", "fdiv", "frem",
    "and", "or", "xor", "shl", "lshr", "ashr",
    "icmp", "fcmp",
}
MEMORY_OPS = {"load", "store", "atomicrmw", "cmpxchg", "alloca", "getelementptr"}
BRANCH_OPS = {"br", "switch", "indirectbr", "select"}
CALL_OPS = {"call", "invoke", "callbr"}

HOST_IO = {
    "printf", "fprintf", "puts", "putchar", "fputs", "read",
    "write", "fread", "fwrite", "open", "close", "fopen", "fclose",
}
HOST_TIME = {"time", "gettimeofday", "clock_gettime", "clock"}
HOST_FS = {"getcwd", "chdir", "stat", "lstat", "fstat", "opendir", "readdir"}

RE_LABEL = re.compile(r"^[A-Za-z0-9$._-]+:\s*(;.*)?$")
RE_INST = re.compile(
    r"^\s*(?:[%@][A-Za-z0-9$._-]+\s*=\s*)?(?:tail\s+|musttail\s+|notail\s+)?([A-Za-z_][A-Za-z0-9_.]*)\b"
)
RE_DEFINE = re.compile(r"^\s*define\b")
RE_CALL_CALLEE = re.compile(r"\b(?:call|invoke|callbr)\b.*?@([A-Za-z_][A-Za-z0-9_$.]*)")
RE_INDIRECT_CALL = re.compile(r"\b(?:call|invoke|callbr)\b[^@]*[%]")
RE_SWITCH_LABELS = re.compile(r"\blabel\s+%[A-Za-z0-9$._-]+")


def safe_div(a: float, b: float) -> float:
    return a / b if b else 0.0


def run_cmd(cmd: List[str], cwd: Optional[Path] = None, timeout_sec: int = 180) -> subprocess.CompletedProcess:
    print("$", " ".join(shlex.quote(c) for c in cmd))
    return subprocess.run(
        cmd,
        cwd=str(cwd) if cwd else None,
        capture_output=True,
        text=True,
        timeout=timeout_sec,
    )


def load_labels(summary_csv: Path) -> Dict[str, Dict[str, str]]:
    if not summary_csv.exists():
        return {}

    out: Dict[str, Dict[str, str]] = {}
    with summary_csv.open("r", encoding="utf-8", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            prog = (row.get("program") or "").strip()
            if not prog:
                continue
            out[prog] = {
                "label": (row.get("label") or "").strip(),
                "label_jit": (row.get("label_jit") or "").strip(),
                "label_aot": (row.get("label_aot") or "").strip(),
            }
    return out


def source_max_loop_depth(c_text: str) -> int:
    clean_text = re.sub(r"//.*", "", c_text)
    clean_text = re.sub(r"/\*.*?\*/", "", clean_text, flags=re.DOTALL)
    clean_text = re.sub(r'".*?"', '""', clean_text)

    max_depth = 0
    depth = 0
    pending_loop = 0
    block_depths: List[int] = []

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


def parse_ir_stats(ll_text: str, loop_bbs: Optional[set[str]] = None) -> IRStats:
    inst_cnt = bb_cnt = br_cnt = call_cnt = indir_call_cnt = 0
    compute_cnt = mem_cnt = func_cnt = syscall_cnt = io_cnt = 0
    total_succ = 0

    current_bb: Optional[str] = None
    bb_instr_count: Dict[str, int] = {}
    in_switch = False

    for raw in ll_text.splitlines():
        line = raw.strip()
        if not line or line.startswith(";"):
            continue

        if RE_DEFINE.match(line):
            func_cnt += 1
            continue

        if line == "}":
            current_bb = None
            in_switch = False
            continue

        if RE_LABEL.match(line):
            bb_cnt += 1
            current_bb = line.split(":", 1)[0]
            bb_instr_count.setdefault(current_bb, 0)
            continue

        if in_switch:
            if "]" in line:
                in_switch = False
            else:
                total_succ += len(RE_SWITCH_LABELS.findall(line))
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

        if op == "br":
            total_succ += 2 if ", label %" in line else 1
        elif op == "switch":
            in_switch = True
            total_succ += max(len(RE_SWITCH_LABELS.findall(line)), 1)

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

    bbs = {m.group(1) for m in re.finditer(r"%([A-Za-z0-9$._-]+)", text)}
    return bbs if bbs else None


def extract_one(c_path: Path, ll_path: Path, labels: Dict[str, Dict[str, str]], opt_cmd: str) -> Optional[Dict[str, object]]:
    if not ll_path.exists():
        print(f"[WARN] skip {c_path.stem}: missing IR {ll_path}")
        return None

    c_text = c_path.read_text(encoding="utf-8", errors="ignore")
    max_loop_depth = source_max_loop_depth(c_text)

    ll_text = ll_path.read_text(encoding="utf-8", errors="ignore")
    loop_bbs = try_get_loop_bbs_with_opt(opt_cmd, ll_path)
    ir = parse_ir_stats(ll_text, loop_bbs)

    br_density = safe_div(ir.br_instr_count, ir.total_instr_count)
    compute_density = safe_div(ir.compute_instr_count, ir.total_instr_count)
    ls_ratio = safe_div(ir.mem_instr_count, ir.total_instr_count)
    call_density = safe_div(ir.call_instr_count, ir.total_instr_count)
    syscall_density = safe_div(ir.syscall_count, ir.total_instr_count)
    io_density = safe_div(ir.io_call_count, ir.total_instr_count)
    avg_bb_size = safe_div(ir.total_instr_count, ir.basic_block_count)
    compute_mem_ratio = safe_div(ir.compute_instr_count, ir.mem_instr_count)
    call_bb_ratio = safe_div(ir.call_instr_count, ir.basic_block_count)

    program = c_path.stem
    lab = labels.get(program, {})

    return {
        "program": program,
        "label": lab.get("label", ""),
        "label_jit": lab.get("label_jit", ""),
        "label_aot": lab.get("label_aot", ""),
        "total_instr_count": ir.total_instr_count,
        "basic_block_count": ir.basic_block_count,
        "avg_bb_size": round(avg_bb_size, 6),
        "avg_bb_out_degree": ir.avg_bb_out_degree,
        "max_loop_depth": int(max_loop_depth),
        "loop_instr_count": int(ir.loop_instr_count),
        "br_instr_count": ir.br_instr_count,
        "br_density": round(br_density, 6),
        "compute_instr_count": ir.compute_instr_count,
        "compute_density": round(compute_density, 6),
        "mem_instr_count": ir.mem_instr_count,
        "ls_ratio": round(ls_ratio, 6),
        "func_count": ir.func_count,
        "call_instr_count": ir.call_instr_count,
        "indirect_call_count": ir.indirect_call_count,
        "call_density": round(call_density, 6),
        "syscall_count": ir.syscall_count,
        "syscall_density": round(syscall_density, 6),
        "io_call_count": ir.io_call_count,
        "io_density": round(io_density, 6),
        "compute_mem_ratio": round(compute_mem_ratio, 6),
        "call_bb_ratio": round(call_bb_ratio, 6),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--src-dir", default="data/microbenchmarks", help="Directory of .c files")
    parser.add_argument("--ir-dir", default="data/build/microbench_internal", help="Directory of .ll files")
    parser.add_argument("--labels-csv", default="data/results/labels_microbench_internal.csv", help="Summary labels CSV")
    parser.add_argument("--out-csv", default="data/results/dataset_microbench.csv", help="Output dataset CSV")
    parser.add_argument("--opt", default="opt", help="LLVM opt command (optional, for LoopInfo)")
    args = parser.parse_args()

    root = Path(__file__).resolve().parent.parent
    src_dir = root / args.src_dir
    ir_dir = root / args.ir_dir
    labels_csv = root / args.labels_csv
    out_csv = root / args.out_csv
    out_csv.parent.mkdir(parents=True, exist_ok=True)

    labels = load_labels(labels_csv)

    rows: List[Dict[str, object]] = []
    for c_path in sorted(src_dir.glob("*.c")):
        row = extract_one(c_path, ir_dir / f"{c_path.stem}.ll", labels, args.opt)
        if row is not None:
            rows.append(row)
            print(f"extracted {c_path.stem} (label={row['label'] or 'NA'})")

    fieldnames = [
        "program", "label", "label_jit", "label_aot",
        "total_instr_count", "basic_block_count", "avg_bb_size", "avg_bb_out_degree",
        "max_loop_depth", "loop_instr_count", "br_instr_count", "br_density",
        "compute_instr_count", "compute_density", "mem_instr_count", "ls_ratio",
        "func_count", "call_instr_count", "indirect_call_count", "call_density",
        "syscall_count", "syscall_density", "io_call_count", "io_density",
        "compute_mem_ratio", "call_bb_ratio",
    ]

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"\nDataset written: {out_csv} (rows={len(rows)})")


if __name__ == "__main__":
    main()
