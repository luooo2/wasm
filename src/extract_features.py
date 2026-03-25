#!/usr/bin/env python3
"""
Extract static features based on assets/feature_design_table.md.
Input directory should contain:
- source: *.c
- LLVM IR: same stem *.ll (optional but recommended)

Output CSV contains exactly the current agreed feature set.
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

RE_FUNC = re.compile(r"^define\s+")
RE_LABEL = re.compile(r"^[A-Za-z0-9_.-]+:\s*(;.*)?$")
RE_INST = re.compile(r"^\s*(?:[%@][A-Za-z0-9_.-]+\s*=\s*)?([A-Za-z_][A-Za-z0-9_.]*)\b")
RE_CALL_SYMBOL = re.compile(r"\b([A-Za-z_][A-Za-z0-9_]*)\s*\(")
RE_LOOP_HINT = re.compile(r"(llvm\.loop|\.lr\.ph|\.preheader|\.backedge)", re.IGNORECASE)


def safe_div(a: float, b: float) -> float:
    return a / b if b else 0.0


def source_features(c_text: str) -> Dict[str, int]:
    syms = RE_CALL_SYMBOL.findall(c_text)
    io_cnt = sum(1 for s in syms if s in HOST_IO)
    time_cnt = sum(1 for s in syms if s in HOST_TIME)
    fs_cnt = sum(1 for s in syms if s in HOST_FS)
    alloc_cnt = sum(1 for s in syms if s in ALLOC_API)

    # naive max loop depth from source text
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
                if depth > max_depth:
                    max_depth = depth
        elif tk == "}":
            if depth > 0:
                depth -= 1

    return {
        "hostcall_count": io_cnt + time_cnt + fs_cnt,
        "io_call_count": io_cnt,
        "time_call_count": time_cnt,
        "filesystem_call_count": fs_cnt,
        "alloc_call_count": alloc_cnt,
        "max_loop_depth": max_depth,
    }


def ir_features(ll_text: str) -> Dict[str, float]:
    func_cnt = 0
    bb_cnt = 0
    inst_cnt = 0
    compute_cnt = 0
    mem_cnt = 0
    load_cnt = 0
    store_cnt = 0
    br_cnt = 0
    call_cnt = 0
    indirect_call_cnt = 0
    loop_cnt = 0

    for raw in ll_text.splitlines():
        line = raw.strip()
        if not line or line.startswith(";"):
            continue

        if RE_FUNC.match(line):
            func_cnt += 1
            continue

        if RE_LABEL.match(line):
            bb_cnt += 1
            if RE_LOOP_HINT.search(line):
                loop_cnt += 1
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
            if ("call" in line and "@" not in line) or "call " in line and "*" in line:
                indirect_call_cnt += 1

    return {
        "ir_instruction_count": inst_cnt,
        "function_count": func_cnt,
        "basic_block_count": bb_cnt,
        "compute_instr_count": compute_cnt,
        "compute_density": round(safe_div(compute_cnt, inst_cnt), 6),
        "memory_instr_count": mem_cnt,
        "memory_access_density": round(safe_div(mem_cnt, inst_cnt), 6),
        "load_count": load_cnt,
        "store_count": store_cnt,
        "branch_instr_count": br_cnt,
        "branch_density": round(safe_div(br_cnt, inst_cnt), 6),
        "call_instr_count": call_cnt,
        "call_density": round(safe_div(call_cnt, inst_cnt), 6),
        "indirect_call_count": indirect_call_cnt,
        "loop_count": loop_cnt,
    }


def extract_one(c_path: Path, ll_path: Path) -> Dict[str, float]:
    row: Dict[str, float] = {"program": c_path.stem}

    c_text = c_path.read_text(encoding="utf-8", errors="ignore")
    row.update(source_features(c_text))

    if ll_path.exists():
        ll_text = ll_path.read_text(encoding="utf-8", errors="ignore")
        row.update(ir_features(ll_text))
    else:
        # fill required IR features with 0 when missing
        row.update(
            {
                "ir_instruction_count": 0,
                "function_count": 0,
                "basic_block_count": 0,
                "compute_instr_count": 0,
                "compute_density": 0,
                "memory_instr_count": 0,
                "memory_access_density": 0,
                "load_count": 0,
                "store_count": 0,
                "branch_instr_count": 0,
                "branch_density": 0,
                "call_instr_count": 0,
                "call_density": 0,
                "indirect_call_count": 0,
                "loop_count": 0,
            }
        )

    row["hostcall_density"] = round(safe_div(row["hostcall_count"], max(row["call_instr_count"], 1)), 6)

    return row


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
    rows = []
    for c_file in c_files:
        ll_file = ir_dir / f"{c_file.stem}.ll"
        rows.append(extract_one(c_file, ll_file))

    fieldnames = [
        "program",
        "ir_instruction_count",
        "function_count",
        "basic_block_count",
        "compute_instr_count",
        "compute_density",
        "memory_instr_count",
        "memory_access_density",
        "load_count",
        "store_count",
        "branch_instr_count",
        "branch_density",
        "call_instr_count",
        "call_density",
        "indirect_call_count",
        "loop_count",
        "max_loop_depth",
        "hostcall_count",
        "hostcall_density",
        "io_call_count",
        "time_call_count",
        "filesystem_call_count",
        "alloc_call_count",
    ]

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for r in rows:
            writer.writerow(r)

    print(f"extracted {len(rows)} programs -> {out_csv}")


if __name__ == "__main__":
    main()
