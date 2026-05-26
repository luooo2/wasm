#!/usr/bin/env python3
"""
Extract a minimal static LLVM IR feature table and optionally join it with
existing perf stat CSV data.

Default outputs are written next to this script:
  - static_features_llvm_direct.csv
  - perf_medians_llvm_direct.csv
  - static_perf_join_llvm_direct.csv
"""

from __future__ import annotations

import argparse
import csv
import re
import statistics
import subprocess
from collections import defaultdict
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Tuple


SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parents[1]

EVENT_ALIASES = {
    "r81d0": "all_loads_retired",
    "r82d0": "all_stores_retired",
    "r00c4": "branches_retired",
    "r01c4": "conditional_branches",
    "r1c0": "instructions_retired",
    "cpu-cycles": "cpu_cycles",
    "L1-icache-load-misses": "L1_icache_load_misses",
    "branch-misses": "branch_misses",
}

COMPUTE_OPS = {
    "add",
    "fadd",
    "sub",
    "fsub",
    "mul",
    "fmul",
    "udiv",
    "sdiv",
    "fdiv",
    "urem",
    "srem",
    "frem",
    "shl",
    "lshr",
    "ashr",
    "and",
    "or",
    "xor",
    "icmp",
    "fcmp",
    "select",
    "trunc",
    "zext",
    "sext",
    "fptrunc",
    "fpext",
    "fptoui",
    "fptosi",
    "uitofp",
    "sitofp",
    "ptrtoint",
    "inttoptr",
    "bitcast",
    "addrspacecast",
    "getelementptr",
}

MEMORY_OPS = {"load", "store", "atomicrmw", "cmpxchg"}
BRANCH_OPS = {"br", "switch", "indirectbr", "select"}
CALL_OPS = {"call", "invoke", "callbr"}

HOSTCALL_NAMES = {
    "printf",
    "fprintf",
    "sprintf",
    "snprintf",
    "scanf",
    "fscanf",
    "sscanf",
    "puts",
    "fputs",
    "putchar",
    "fputc",
    "gets",
    "fgets",
    "getchar",
    "fgetc",
    "fopen",
    "freopen",
    "fclose",
    "fread",
    "fwrite",
    "fflush",
    "fseek",
    "ftell",
    "rewind",
    "remove",
    "rename",
    "read",
    "write",
    "open",
    "close",
    "lseek",
    "stat",
    "fstat",
    "time",
    "clock",
    "gettimeofday",
    "clock_gettime",
}

ALLOC_NAMES = {"malloc", "calloc", "realloc", "free", "aligned_alloc", "posix_memalign"}


def safe_div(num: float, den: float, default: float = 0.0) -> float:
    return num / den if den else default


def clean_ir_line(line: str) -> str:
    # Metadata and comments after instructions are not needed for opcode counts.
    if ";" in line:
        line = line.split(";", 1)[0]
    return line.strip()


def is_label_line(line: str) -> bool:
    return bool(re.match(r"^[A-Za-z$._-][\w$._-]*:\s*$|^\d+:\s*$", clean_ir_line(line)))


def is_instruction_line(line: str) -> bool:
    s = clean_ir_line(line)
    if not s:
        return False
    if s.startswith(("declare ", "define ", "attributes ", "target ", "source_filename", "!", "@", "}")):
        return False
    if is_label_line(s):
        return False
    return True


def extract_opcode(line: str) -> str:
    s = clean_ir_line(line)
    if " = " in s:
        s = s.split(" = ", 1)[1].strip()
    tokens = s.split()
    idx = 0
    while idx < len(tokens) and tokens[idx] in {
        "tail",
        "musttail",
        "notail",
        "fast",
        "nuw",
        "nsw",
        "exact",
        "inbounds",
        "volatile",
        "atomic",
    }:
        idx += 1
    return tokens[idx] if idx < len(tokens) else ""


def called_function_name(line: str) -> Optional[str]:
    s = clean_ir_line(line)
    # Direct calls look like: call ... @printf(...)
    matches = re.findall(r"@([A-Za-z_$.\-][\w$.\-]*)\s*\(", s)
    return matches[-1] if matches else None


def cfg_edges_from_terminator(line: str, opcode: str) -> int:
    s = clean_ir_line(line)
    if opcode == "br":
        return 2 if s.startswith("br i1 ") else 1
    if opcode == "switch":
        # Counts default target plus explicit case targets.
        return max(1, len(re.findall(r"label\s+%", s)))
    if opcode == "indirectbr":
        return max(1, len(re.findall(r"label\s+%", s)))
    return 0


def parse_ir_features(ir_path: Path, source_path: str = "") -> Dict[str, object]:
    lines = ir_path.read_text(encoding="utf-8", errors="replace").splitlines()

    function_count = 0
    explicit_label_count = 0
    ir_instruction_count = 0
    cfg_edge_count = 0
    compute_instr_count = 0
    load_count = 0
    store_count = 0
    memory_instr_count = 0
    branch_instr_count = 0
    call_instr_count = 0
    hostcall_count = 0
    alloc_call_count = 0

    in_function = False
    saw_instruction_in_function = False

    for raw in lines:
        stripped = clean_ir_line(raw)
        if stripped.startswith("define "):
            function_count += 1
            in_function = True
            saw_instruction_in_function = False
            continue
        if in_function and stripped == "}":
            in_function = False
            continue
        if not in_function:
            continue
        if is_label_line(raw):
            explicit_label_count += 1
            continue
        if not is_instruction_line(raw):
            continue

        saw_instruction_in_function = True
        ir_instruction_count += 1
        opcode = extract_opcode(raw)

        if opcode in COMPUTE_OPS:
            compute_instr_count += 1
        if opcode == "load":
            load_count += 1
        if opcode == "store":
            store_count += 1
        if opcode in MEMORY_OPS:
            memory_instr_count += 1
        if opcode in BRANCH_OPS:
            branch_instr_count += 1
        if opcode in CALL_OPS:
            call_instr_count += 1
            callee = called_function_name(raw)
            if callee in HOSTCALL_NAMES:
                hostcall_count += 1
            if callee in ALLOC_NAMES:
                alloc_call_count += 1
        cfg_edge_count += cfg_edges_from_terminator(raw, opcode)

    # Each function has an implicit entry block even if LLVM IR omits its label.
    basic_block_count = explicit_label_count + function_count
    avg_bb_size = safe_div(ir_instruction_count, basic_block_count)
    avg_bb_out_degree = safe_div(cfg_edge_count, basic_block_count)
    compute_density = safe_div(compute_instr_count, ir_instruction_count)
    memory_access_density = safe_div(memory_instr_count, ir_instruction_count)
    branch_density = safe_div(branch_instr_count, ir_instruction_count)

    return {
        "program": ir_path.stem,
        "source_path": source_path,
        "ir_path": str(ir_path),
        "function_count": function_count,
        "ir_instruction_count": ir_instruction_count,
        "basic_block_count": basic_block_count,
        "avg_bb_size": avg_bb_size,
        "cfg_edge_count": cfg_edge_count,
        "avg_bb_out_degree": avg_bb_out_degree,
        "branch_instr_count": branch_instr_count,
        "branch_density": branch_density,
        "compute_instr_count": compute_instr_count,
        "compute_density": compute_density,
        "load_count": load_count,
        "store_count": store_count,
        "memory_instr_count": memory_instr_count,
        "memory_access_density": memory_access_density,
        "compute_to_memory_ratio": compute_density / max(memory_access_density, 1e-6),
        "load_store_ratio": load_count / max(store_count, 1),
        "call_instr_count": call_instr_count,
        "call_to_bb_ratio": safe_div(call_instr_count, basic_block_count),
        "hostcall_count": hostcall_count,
        "hostcall_density": safe_div(hostcall_count, ir_instruction_count),
        "alloc_call_count": alloc_call_count,
    }


def opt_loop_features(ir_path: Path, opt_bin: str) -> Tuple[int, int, bool, str]:
    try:
        proc = subprocess.run(
            [opt_bin, "-passes=print<loops>", "-disable-output", str(ir_path)],
            capture_output=True,
            text=True,
            check=False,
        )
    except FileNotFoundError:
        return 0, 0, False, f"opt not found: {opt_bin}"

    output = f"{proc.stdout}\n{proc.stderr}"
    depths = [int(x) for x in re.findall(r"Loop at depth\s+(\d+)", output)]
    if proc.returncode != 0:
        note = (proc.stderr or proc.stdout or "").strip().replace("\n", " ")[:300]
        return len(depths), max(depths) if depths else 0, False, note
    return len(depths), max(depths) if depths else 0, True, ""


def load_runnable_sources(runnable_csv: Path, bench_root: Path) -> Dict[str, str]:
    if not runnable_csv.exists():
        return {}
    out: Dict[str, str] = {}
    with runnable_csv.open("r", encoding="utf-8", newline="") as f:
        for row in csv.DictReader(f):
            program = (row.get("program") or "").strip()
            rel = (row.get("relative_path") or "").strip()
            if program and rel:
                out[program] = str((bench_root / rel).as_posix())
    return out


def extract_features(args: argparse.Namespace) -> List[Dict[str, object]]:
    build_dir = Path(args.build_dir)
    bench_root = Path(args.bench_root)
    source_map = load_runnable_sources(Path(args.runnable_csv), bench_root)
    rows: List[Dict[str, object]] = []

    for ir_path in sorted(build_dir.glob("*.ll")):
        row = parse_ir_features(ir_path, source_map.get(ir_path.stem, ""))
        loop_count, max_loop_depth, opt_ok, opt_note = opt_loop_features(ir_path, args.opt_bin)
        row.update(
            {
                "loop_count": loop_count,
                "max_loop_depth": max_loop_depth,
                "opt_loop_ok": int(opt_ok),
                "opt_loop_note": opt_note,
            }
        )
        rows.append(row)
    return rows


def parse_perf_value(value: str) -> Optional[float]:
    v = (value or "").strip().replace(",", "")
    if not v or v.startswith("<") or v.lower() in {"not", "nan"}:
        return None
    try:
        return float(v)
    except ValueError:
        return None


def median_perf_rows(perf_csv: Path) -> List[Dict[str, object]]:
    grouped: Dict[Tuple[str, str, str], List[float]] = defaultdict(list)
    if not perf_csv.exists():
        return []

    with perf_csv.open("r", encoding="utf-8", newline="") as f:
        for row in csv.DictReader(f):
            if (row.get("status") or "") != "ok":
                continue
            value = parse_perf_value(row.get("value", ""))
            if value is None:
                continue
            program = (row.get("program") or "").strip()
            mode = (row.get("mode") or "").strip()
            event = (row.get("event") or "").strip()
            if program and mode and event:
                grouped[(program, mode, event)].append(value)

    rows: List[Dict[str, object]] = []
    for (program, mode, event), values in sorted(grouped.items()):
        alias = EVENT_ALIASES.get(event, event.replace("-", "_"))
        rows.append(
            {
                "program": program,
                "mode": mode,
                "event": event,
                "event_alias": alias,
                "repeat_count": len(values),
                "median_value": statistics.median(values),
            }
        )
    return rows


def build_static_perf_join(
    feature_rows: List[Dict[str, object]],
    perf_rows: List[Dict[str, object]],
) -> List[Dict[str, object]]:
    features_by_program = {str(r["program"]): r for r in feature_rows}
    perf: Dict[Tuple[str, str, str], float] = {}
    modes_by_program: Dict[str, set] = defaultdict(set)
    events = set()

    for row in perf_rows:
        program = str(row["program"])
        mode = str(row["mode"])
        event_alias = str(row["event_alias"])
        value = float(row["median_value"])
        perf[(program, mode, event_alias)] = value
        modes_by_program[program].add(mode)
        events.add(event_alias)

    joined: List[Dict[str, object]] = []
    for program, features in sorted(features_by_program.items()):
        native_events = {
            event: perf.get((program, "native", event))
            for event in events
            if perf.get((program, "native", event)) is not None
        }
        for mode in sorted(modes_by_program.get(program, set())):
            if mode == "native":
                continue
            out = dict(features)
            out["mode"] = mode
            for event in sorted(events):
                val = perf.get((program, mode, event))
                native_val = native_events.get(event)
                out[f"perf_{event}_median"] = val if val is not None else ""
                out[f"native_perf_{event}_median"] = native_val if native_val is not None else ""
                out[f"ratio_{event}_over_native"] = (
                    val / native_val if val is not None and native_val not in (None, 0) else ""
                )
            joined.append(out)
    return joined


def write_csv(path: Path, rows: List[Dict[str, object]], preferred_fields: Iterable[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    preferred = list(preferred_fields)
    extras = sorted({k for row in rows for k in row.keys()} - set(preferred))
    fields = preferred + extras
    with path.open("w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--build-dir", default=str(REPO_ROOT / "data/build/llvm_direct"))
    ap.add_argument("--bench-root", default=str(REPO_ROOT / "data/llvm-test-suite/SingleSource/Benchmarks"))
    ap.add_argument("--runnable-csv", default=str(REPO_ROOT / "data/results/llvm_direct_runnable.csv"))
    ap.add_argument("--perf-csv", default=str(REPO_ROOT / "data/results/perf_llvm/perf_raw_events_llvm.csv"))
    ap.add_argument("--out-dir", default=str(SCRIPT_DIR))
    ap.add_argument("--opt-bin", default="opt")
    args = ap.parse_args()

    out_dir = Path(args.out_dir)
    feature_rows = extract_features(args)
    feature_fields = [
        "program",
        "source_path",
        "ir_path",
        "ir_instruction_count",
        "basic_block_count",
        "avg_bb_size",
        "cfg_edge_count",
        "avg_bb_out_degree",
        "loop_count",
        "max_loop_depth",
        "branch_instr_count",
        "branch_density",
        "compute_instr_count",
        "compute_density",
        "load_count",
        "store_count",
        "memory_instr_count",
        "memory_access_density",
        "compute_to_memory_ratio",
        "load_store_ratio",
        "call_instr_count",
        "call_to_bb_ratio",
        "hostcall_count",
        "hostcall_density",
        "alloc_call_count",
        "function_count",
        "opt_loop_ok",
        "opt_loop_note",
    ]
    write_csv(out_dir / "static_features_llvm_direct.csv", feature_rows, feature_fields)

    perf_rows = median_perf_rows(Path(args.perf_csv))
    if perf_rows:
        perf_fields = ["program", "mode", "event", "event_alias", "repeat_count", "median_value"]
        write_csv(out_dir / "perf_medians_llvm_direct.csv", perf_rows, perf_fields)
        joined = build_static_perf_join(feature_rows, perf_rows)
        join_fields = ["program", "mode"] + [f for f in feature_fields if f != "program"]
        write_csv(out_dir / "static_perf_join_llvm_direct.csv", joined, join_fields)

    print(f"features: {out_dir / 'static_features_llvm_direct.csv'} ({len(feature_rows)} rows)")
    if perf_rows:
        print(f"perf medians: {out_dir / 'perf_medians_llvm_direct.csv'} ({len(perf_rows)} rows)")
        print(f"joined: {out_dir / 'static_perf_join_llvm_direct.csv'}")


if __name__ == "__main__":
    main()
