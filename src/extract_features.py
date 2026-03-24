#!/usr/bin/env python3
import argparse
import csv
import json
import os
import re
from pathlib import Path
from typing import Dict, List, Tuple

COMPUTE_OPS = {
    'add', 'sub', 'mul', 'udiv', 'sdiv', 'urem', 'srem',
    'fadd', 'fsub', 'fmul', 'fdiv', 'frem',
    'and', 'or', 'xor', 'shl', 'lshr', 'ashr'
}

MEMORY_OPS = {'load', 'store', 'atomicrmw', 'cmpxchg'}
BRANCH_OPS = {'br', 'switch', 'indirectbr'}
CALL_OPS = {'call', 'invoke', 'callbr'}
HOST_IO_NAMES = {
    'printf', 'fprintf', 'puts', 'putchar', 'fputs',
    'read', 'write', 'fread', 'fwrite', 'open', 'close', 'fopen', 'fclose'
}
HOST_TIME_NAMES = {'time', 'gettimeofday', 'clock_gettime', 'clock'}
HOST_FS_NAMES = {'getcwd', 'chdir', 'stat', 'lstat', 'fstat', 'opendir', 'readdir'}
ALLOC_NAMES = {'malloc', 'calloc', 'realloc', 'free', 'aligned_alloc'}

FUNC_DEF_RE = re.compile(r'^define\s+')
LABEL_RE = re.compile(r'^[A-Za-z0-9_.-]+:\s*(;.*)?$')
INST_RE = re.compile(r'^\s*(?:[%@][A-Za-z0-9_.-]+\s*=\s*)?([A-Za-z_][A-Za-z0-9_.]*)\b')
CALL_TARGET_RE = re.compile(r'@(\w+)')
LOOP_HINT_RE = re.compile(r'(llvm\.loop|\.lr\.ph|\.preheader|\.backedge)', re.IGNORECASE)
WASM_IMPORT_RE = re.compile(r'\(import\s+"')
WASM_EXPORT_RE = re.compile(r'\(export\s+"')
WASM_DATA_RE = re.compile(r'\(data\b')
WASM_MEMORY_RE = re.compile(r'\(memory\b')


def safe_div(a: float, b: float) -> float:
    return a / b if b else 0.0


def extract_source_symbol_features(source_text: str) -> Dict[str, int]:
    symbols = re.findall(r'\b([A-Za-z_][A-Za-z0-9_]*)\s*\(', source_text)
    io_count = sum(1 for s in symbols if s in HOST_IO_NAMES)
    time_count = sum(1 for s in symbols if s in HOST_TIME_NAMES)
    fs_count = sum(1 for s in symbols if s in HOST_FS_NAMES)
    alloc_count = sum(1 for s in symbols if s in ALLOC_NAMES)
    hostcall_count = io_count + time_count + fs_count
    return {
        'hostcall_count': hostcall_count,
        'io_call_count': io_count,
        'time_call_count': time_count,
        'filesystem_call_count': fs_count,
        'alloc_call_count': alloc_count,
    }


def extract_ir_features(ir_text: str) -> Dict[str, float]:
    function_count = 0
    basic_block_count = 0
    total_inst = 0
    compute_count = 0
    memory_count = 0
    load_count = 0
    store_count = 0
    branch_count = 0
    call_count = 0
    indirect_call_count = 0
    loop_hints = 0
    edge_approx = 0

    for raw_line in ir_text.splitlines():
        line = raw_line.strip()
        if not line or line.startswith(';'):
            continue
        if FUNC_DEF_RE.match(line):
            function_count += 1
            continue
        if LABEL_RE.match(line):
            basic_block_count += 1
            if LOOP_HINT_RE.search(line):
                loop_hints += 1
            continue

        m = INST_RE.match(line)
        if not m:
            continue
        op = m.group(1)
        total_inst += 1

        if op in COMPUTE_OPS:
            compute_count += 1
        if op in MEMORY_OPS:
            memory_count += 1
        if op == 'load':
            load_count += 1
        if op == 'store':
            store_count += 1
        if op in BRANCH_OPS or op == 'select':
            branch_count += 1
            if op == 'switch':
                edge_approx += 2
            else:
                edge_approx += 1
        if op in CALL_OPS:
            call_count += 1
            if 'call ' in line and '*' in line:
                indirect_call_count += 1
            elif 'call' in line and ' ptr ' in line and '@' not in line:
                indirect_call_count += 1

    if basic_block_count == 0 and total_inst > 0:
        basic_block_count = 1

    cyclomatic_complexity = max(1, edge_approx - basic_block_count + 2 * max(function_count, 1))
    avg_bb_size = safe_div(total_inst, basic_block_count)

    return {
        'ir_instruction_count': total_inst,
        'function_count': function_count,
        'basic_block_count': basic_block_count,
        'avg_bb_size': round(avg_bb_size, 6),
        'compute_instr_count': compute_count,
        'compute_density': round(safe_div(compute_count, total_inst), 6),
        'memory_instr_count': memory_count,
        'memory_access_density': round(safe_div(memory_count, total_inst), 6),
        'load_count': load_count,
        'store_count': store_count,
        'branch_instr_count': branch_count,
        'branch_density': round(safe_div(branch_count, total_inst), 6),
        'call_instr_count': call_count,
        'call_density': round(safe_div(call_count, total_inst), 6),
        'indirect_call_count': indirect_call_count,
        'loop_count': loop_hints,
        'max_loop_depth': 0,
        'cyclomatic_complexity': cyclomatic_complexity,
    }


def extract_wat_features(wat_text: str, wasm_path: Path = None) -> Dict[str, float]:
    imported_function_count = len(WASM_IMPORT_RE.findall(wat_text))
    exported_function_count = len(WASM_EXPORT_RE.findall(wat_text))
    data_section_count = len(WASM_DATA_RE.findall(wat_text))
    memory_segment_init_total_size = 0
    data_section_size = 0
    for line in wat_text.splitlines():
        if '(data' in line:
            payload = re.findall(r'"([^"]*)"', line)
            if payload:
                sz = sum(len(p.encode('utf-8').decode('unicode_escape').encode('latin1', 'ignore')) for p in payload)
                data_section_size += sz
                memory_segment_init_total_size += sz
    wasm_binary_size = wasm_path.stat().st_size if wasm_path and wasm_path.exists() else 0
    return {
        'imported_function_count': imported_function_count,
        'exported_function_count': exported_function_count,
        'data_section_count': data_section_count,
        'data_section_size': data_section_size,
        'memory_segment_init_total_size': memory_segment_init_total_size,
        'wasm_binary_size': wasm_binary_size,
    }


def merge_feature_dicts(*dicts: Dict[str, float]) -> Dict[str, float]:
    merged: Dict[str, float] = {}
    for d in dicts:
        merged.update(d)
    if 'hostcall_count' in merged and 'call_instr_count' in merged:
        merged['hostcall_density'] = round(safe_div(merged['hostcall_count'], max(merged['call_instr_count'], 1)), 6)
    return merged


def discover_file_set(input_dir: Path) -> List[Tuple[Path, Path, Path]]:
    c_files = sorted(input_dir.glob('*.c'))
    result = []
    for c_file in c_files:
        stem = c_file.stem
        ll = input_dir / f'{stem}.ll'
        wat = input_dir / f'{stem}.wat'
        result.append((c_file, ll, wat))
    return result


def process_one(c_path: Path, ll_path: Path, wat_path: Path) -> Dict[str, float]:
    source_text = c_path.read_text(encoding='utf-8')
    source_features = extract_source_symbol_features(source_text)
    ir_features = {}
    if ll_path.exists():
        ir_text = ll_path.read_text(encoding='utf-8', errors='ignore')
        ir_features = extract_ir_features(ir_text)
    wat_features = {}
    if wat_path.exists():
        wat_text = wat_path.read_text(encoding='utf-8', errors='ignore')
        wat_features = extract_wat_features(wat_text)
    row = merge_feature_dicts(source_features, ir_features, wat_features)
    row['program'] = c_path.stem
    row['source_file'] = str(c_path)
    row['ir_file'] = str(ll_path) if ll_path.exists() else ''
    row['wat_file'] = str(wat_path) if wat_path.exists() else ''
    return row


def write_csv(rows: List[Dict[str, float]], output_path: Path) -> None:
    all_keys = []
    seen = set()
    for row in rows:
        for key in row.keys():
            if key not in seen:
                seen.add(key)
                all_keys.append(key)
    with output_path.open('w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=all_keys)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def main() -> None:
    parser = argparse.ArgumentParser(description='Extract static features from C source, LLVM IR (.ll), and optional WAT (.wat).')
    parser.add_argument('--input-dir', required=True, help='Directory containing .c files and optional .ll/.wat files with same stem.')
    parser.add_argument('--output', required=True, help='Output CSV path.')
    parser.add_argument('--pretty-json', help='Optional JSON output path for inspection.')
    args = parser.parse_args()

    input_dir = Path(args.input_dir)
    output = Path(args.output)
    file_set = discover_file_set(input_dir)
    rows = [process_one(c_path, ll_path, wat_path) for c_path, ll_path, wat_path in file_set]
    write_csv(rows, output)

    if args.pretty_json:
        Path(args.pretty_json).write_text(json.dumps(rows, ensure_ascii=False, indent=2), encoding='utf-8')

    print(f'Processed {len(rows)} programs -> {output}')


if __name__ == '__main__':
    main()
