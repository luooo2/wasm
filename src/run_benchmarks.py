#!/usr/bin/env python3
import argparse
import csv
import shlex
import statistics
import subprocess
import time
from dataclasses import dataclass
from pathlib import Path
from typing import List, Optional


@dataclass
class RunOutcome:
    ok: bool
    elapsed_ms: float
    stdout: str
    stderr: str


def run_once(cmd: List[str], timeout_sec: int) -> RunOutcome:
    t0 = time.perf_counter()
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout_sec)
        t1 = time.perf_counter()
        return RunOutcome(
            ok=p.returncode == 0,
            elapsed_ms=(t1 - t0) * 1000.0,
            stdout=p.stdout or '',
            stderr=p.stderr or '',
        )
    except subprocess.TimeoutExpired as e:
        t1 = time.perf_counter()
        return RunOutcome(
            ok=False,
            elapsed_ms=(t1 - t0) * 1000.0,
            stdout=(e.stdout or '') if isinstance(e.stdout, str) else '',
            stderr=f'timeout after {timeout_sec}s',
        )


def median_ms(values: List[float]) -> float:
    return statistics.median(values) if values else 0.0


def judge_label(ratio: float, threshold: float) -> str:
    upper = 1.0 + threshold
    lower = 1.0 - threshold
    if ratio > upper:
        return 'native-better'
    if ratio < lower:
        return 'wasm-better'
    return 'similar'


def run_program_pair(native_exe: Path, wasm_file: Path, wasmtime_cmd: str, repeats: int, timeout_sec: int, verbose: bool) -> dict:
    native_times: List[float] = []
    wasm_times: List[float] = []
    native_ok = True
    wasm_ok = True
    native_err = ''
    wasm_err = ''

    for i in range(repeats):
        n_cmd = [str(native_exe)]
        if verbose:
            print('$', ' '.join(shlex.quote(c) for c in n_cmd))
        n = run_once(n_cmd, timeout_sec)
        if n.ok:
            native_times.append(n.elapsed_ms)
        else:
            native_ok = False
            native_err = n.stderr.strip() or 'native run failed'
            break

        w_cmd = [wasmtime_cmd, str(wasm_file)]
        if verbose:
            print('$', ' '.join(shlex.quote(c) for c in w_cmd))
        w = run_once(w_cmd, timeout_sec)
        if w.ok:
            wasm_times.append(w.elapsed_ms)
        else:
            wasm_ok = False
            wasm_err = w.stderr.strip() or 'wasm run failed'
            break

    native_median = median_ms(native_times)
    wasm_median = median_ms(wasm_times)
    ratio = (wasm_median / native_median) if native_median > 0 else 0.0

    return {
        'native_ok': native_ok,
        'wasm_ok': wasm_ok,
        'native_median_ms': round(native_median, 6),
        'wasm_median_ms': round(wasm_median, 6),
        'ratio_wasm_over_native': round(ratio, 6),
        'native_error': native_err,
        'wasm_error': wasm_err,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description='Batch run native/wasm benchmarks and assign labels.')
    parser.add_argument('--build-dir', required=True, help='Directory containing *.native.exe and *.wasm')
    parser.add_argument('--output', required=True, help='Output CSV for timing + labels')
    parser.add_argument('--repeats', type=int, default=5, help='Repeat count per program')
    parser.add_argument('--timeout-sec', type=int, default=60, help='Timeout seconds per single run')
    parser.add_argument('--threshold', type=float, default=0.10, help='Similarity threshold, default 0.10 (10%)')
    parser.add_argument('--wasmtime', default='wasmtime', help='wasmtime command path/name')
    parser.add_argument('--verbose', action='store_true', help='Print run commands')
    args = parser.parse_args()

    build_dir = Path(args.build_dir)
    output = Path(args.output)

    native_exes = sorted(build_dir.glob('*.native.exe'))
    rows = []
    for native_exe in native_exes:
        stem = native_exe.name.replace('.native.exe', '')
        wasm_file = build_dir / f'{stem}.wasm'
        if not wasm_file.exists():
            rows.append({
                'program': stem,
                'native_ok': 0,
                'wasm_ok': 0,
                'native_median_ms': 0,
                'wasm_median_ms': 0,
                'ratio_wasm_over_native': 0,
                'label': 'missing-artifact',
                'native_error': 'missing executable or not run',
                'wasm_error': 'missing wasm artifact',
            })
            continue

        print(f'\n=== Running {stem} ===')
        res = run_program_pair(
            native_exe=native_exe,
            wasm_file=wasm_file,
            wasmtime_cmd=args.wasmtime,
            repeats=args.repeats,
            timeout_sec=args.timeout_sec,
            verbose=args.verbose,
        )

        label = 'run-failed'
        if res['native_ok'] and res['wasm_ok']:
            label = judge_label(res['ratio_wasm_over_native'], args.threshold)

        rows.append({
            'program': stem,
            'native_ok': int(res['native_ok']),
            'wasm_ok': int(res['wasm_ok']),
            'native_median_ms': res['native_median_ms'],
            'wasm_median_ms': res['wasm_median_ms'],
            'ratio_wasm_over_native': res['ratio_wasm_over_native'],
            'label': label,
            'native_error': res['native_error'],
            'wasm_error': res['wasm_error'],
        })

    output.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = [
        'program', 'native_ok', 'wasm_ok',
        'native_median_ms', 'wasm_median_ms', 'ratio_wasm_over_native',
        'label', 'native_error', 'wasm_error'
    ]
    with output.open('w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)

    print('\n=== Label Summary ===')
    summary = {}
    for r in rows:
        summary[r['label']] = summary.get(r['label'], 0) + 1
    for k, v in sorted(summary.items()):
        print(f'{k}: {v}')
    print(f'output: {output}')


if __name__ == '__main__':
    main()
