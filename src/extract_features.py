#!/usr/bin/env python3
"""
Extract V2 feature set from C source + LLVM IR.

Output columns (exactly 18 features + program):
- ir_instruction_count
- basic_block_count
- compute_density
- memory_access_density
- load_count
- store_count
- branch_instr_count
- call_instr_count
- max_loop_depth
- hostcall_count
- hostcall_density
- time_call_count
- alloc_call_count
- avg_bb_size
- compute_to_memory_ratio
- load_store_ratio
- call_to_bb_ratio
- hostcall_per_bb
"""

import argparse
import csv
import re
from pathlib import Path
from typing import Dict, List

COMPUTE_OPS = {
    "add", "sub", "mul", "udiv", "sdiv", "urem", "srem",
    "fadd", "fsub", "fmul", "fdiv", "frem",
    "and", "or", "xor", "shl", "lshr", "ashr",
}
MEMORY_OPS = {"load", "store", "atomicrmw", "cmpxchg"}
BRANCH_OPS = {"br", "switch", "indirectbr", "select"}
CALL_OPS = {"call", "invoke", "callbr"}

HOST_IO = {
    "printf", "fprintf", "puts", "putchar", "fputs",
    "read", "write", "fread", "fwrite", "open", "close", "fopen", "fclose",
}
HOST_TIME = {"time", "gettimeofday", "clock_gettime", "clock"}
HOST_FS = {"getcwd", "chdir", "stat", "lstat", "fstat", "opendir", "readdir"}
ALLOC_API = {"malloc", "calloc", "realloc", "free", "aligned_alloc"}

RE_LABEL = re.compile(r"^[A-Za-z0-9_.-]+:\s*(;.*)?$")
RE_INST = re.compile(r"^\s*(?:[%@][A-Za-z0-9_.-]+\s*=\s*)?([A-Za-z_][A-Za-z0-9_.]*)\b")
RE_CALL_SYMBOL = re.compile(r"\b([A-Za-z_][A-Za-z0-9_]*)\s*\(")


def safe_div(a: float, b: float) -> float:
    return a / b if b else 0.0


def source_features(c_text: str) -> Dict[str, float]:
    syms = RE_CALL_SYMBOL.findall(c_text)
    io_cnt = sum(1 for s in syms if s in HOST_IO)
    time_cnt = sum(1 for s in syms if s in HOST_TIME)
    fs_cnt = sum(1 for s in syms if s in HOST_FS)
    alloc_cnt = sum(1 for s in syms if s in ALLOC_API)

    # approximate max loop depth from source
    max_depth = 0
    depth = 0
    pending_loop = 0
    tokens = re.findall(r"for|while|do|\{|\}", c_text)
    for tk in tokens:
        if tk in {"for", "while", "do"}:
            pending_loop += 1
        elif tk == "{":
            if pending_loop > 0:
                depth += 1
                pending_loop -= 1
                max_depth = max(max_depth, depth)
        elif tk == "}" and depth > 0:
            depth -= 1

    hostcall_count = io_cnt + time_cnt + fs_cnt
    return {
        "hostcall_count": hostcall_count,
        "time_call_count": time_cnt,
        "alloc_call_count": alloc_cnt,
        "max_loop_depth": max_depth,
    }


def ir_features(ll_text: str) -> Dict[str, float]:
    inst_cnt = 0
    bb_cnt = 0
    compute_cnt = 0
    mem_cnt = 0
    load_cnt = 0
    store_cnt = 0
    br_cnt = 0
    call_cnt = 0

    for raw in ll_text.splitlines():
        line = raw.strip()
        if not line or line.startswith(";"):
            continue

        if RE_LABEL.match(line):
            bb_cnt += 1
            continue

        m = RE_INST.match(line)
        if not m:
            continue

        op = m.group(1)
        inst_cnt += 1

        if op in COMPUTE_OPS:
            compute_cnt += 1
        if op in MEMORY_OPS:
            mem_cnt += 1
        if op == "load":
            load_cnt += 1
        if op == "store":
            store_cnt += 1
        if op in BRANCH_OPS:
            br_cnt += 1
        if op in CALL_OPS:
            call_cnt += 1

    compute_density = safe_div(compute_cnt, inst_cnt)
    memory_access_density = safe_div(mem_cnt, inst_cnt)

    return {
        "ir_instruction_count": inst_cnt,
        "basic_block_count": bb_cnt,
        "compute_density": round(compute_density, 6),
        "memory_access_density": round(memory_access_density, 6),
        "load_count": load_cnt,
        "store_count": store_cnt,
        "branch_instr_count": br_cnt,
        "call_instr_count": call_cnt,
    }


def derive_v2_features(row: Dict[str, float]) -> Dict[str, float]:
    ir_inst = row["ir_instruction_count"]
    bb = row["basic_block_count"]
    call_cnt = row["call_instr_count"]
    hostcall_cnt = row["hostcall_count"]
    mem_density = row["memory_access_density"]

    row["hostcall_density"] = round(safe_div(hostcall_cnt, max(ir_inst, 1)), 6)
    row["avg_bb_size"] = round(safe_div(ir_inst, max(bb, 1)), 6)
    row["compute_to_memory_ratio"] = round(safe_div(row["compute_density"], max(mem_density, 1e-6)), 6)
    row["load_store_ratio"] = round(safe_div(row["load_count"], max(row["store_count"], 1)), 6)
    row["call_to_bb_ratio"] = round(safe_div(call_cnt, max(bb, 1)), 6)
    row["hostcall_per_bb"] = round(safe_div(hostcall_cnt, max(bb, 1)), 6)
    return row


def extract_one(c_path: Path, ll_path: Path) -> Dict[str, float]:
    row: Dict[str, float] = {"program": c_path.stem}

    c_text = c_path.read_text(encoding="utf-8", errors="ignore")
    row.update(source_features(c_text))

    if ll_path.exists():
        ll_text = ll_path.read_text(encoding="utf-8", errors="ignore")
        row.update(ir_features(ll_text))
    else:
        row.update(
            {
                "ir_instruction_count": 0,
                "basic_block_count": 0,
                "compute_density": 0.0,
                "memory_access_density": 0.0,
                "load_count": 0,
                "store_count": 0,
                "branch_instr_count": 0,
                "call_instr_count": 0,
            }
        )

    return derive_v2_features(row)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--src-dir", default="data/microbenchmarks", help="Directory of .c files")
    parser.add_argument("--ir-dir", default="data/build", help="Directory of .ll files")
    parser.add_argument("--out-csv", default="data/results/features.csv", help="Output feature CSV")
    args = parser.parse_args()

    src_dir = Path(args.src_dir)
    ir_dir = Path(args.ir_dir)
    out_csv = Path(args.out_csv)
    out_csv.parent.mkdir(parents=True, exist_ok=True)

    c_files = sorted(src_dir.glob("*.c"))
    rows = [extract_one(c_file, ir_dir / f"{c_file.stem}.ll") for c_file in c_files]

    fieldnames: List[str] = [
        "program",
        "ir_instruction_count",
        "basic_block_count",
        "compute_density",
        "memory_access_density",
        "load_count",
        "store_count",
        "branch_instr_count",
        "call_instr_count",
        "max_loop_depth",
        "hostcall_count",
        "hostcall_density",
        "time_call_count",
        "alloc_call_count",
        "avg_bb_size",
        "compute_to_memory_ratio",
        "load_store_ratio",
        "call_to_bb_ratio",
        "hostcall_per_bb",
    ]

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"extracted {len(rows)} programs -> {out_csv}")


if __name__ == "__main__":
    main()
