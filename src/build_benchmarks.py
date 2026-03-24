#!/usr/bin/env python3
import argparse
import os
import shlex
import shutil
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import List


def run_cmd(cmd: List[str], cwd: Path = None, verbose: bool = True) -> subprocess.CompletedProcess:
    if verbose:
        print('$', ' '.join(shlex.quote(c) for c in cmd))
    return subprocess.run(cmd, cwd=str(cwd) if cwd else None, capture_output=True, text=True)


@dataclass
class BuildResult:
    program: str
    native_ok: bool
    ir_ok: bool
    wasm_ok: bool
    wat_ok: bool
    native_out: str
    ir_out: str
    wasm_out: str
    wat_out: str


def detect_tool(explicit: str, env_name: str, fallback: str) -> str:
    if explicit:
        return explicit
    env_v = os.environ.get(env_name, '').strip()
    if env_v:
        return env_v
    return fallback


def compile_one(
    c_file: Path,
    out_dir: Path,
    native_cc: str,
    wasi_cc: str,
    wasm_target: str,
    sysroot: str,
    opt_level: str,
    emit_wat: bool,
    verbose: bool,
) -> BuildResult:
    stem = c_file.stem
    native_exe = out_dir / f'{stem}.native.exe'
    ir_file = out_dir / f'{stem}.ll'
    wasm_file = out_dir / f'{stem}.wasm'
    wat_file = out_dir / f'{stem}.wat'

    native_ok = ir_ok = wasm_ok = wat_ok = False
    native_out = ir_out = wasm_out = wat_out = ''

    native_cmd = [native_cc, opt_level, str(c_file), '-o', str(native_exe)]
    p = run_cmd(native_cmd, verbose=verbose)
    native_out = (p.stdout or '') + (p.stderr or '')
    native_ok = p.returncode == 0

    ir_cmd = [native_cc, opt_level, '-S', '-emit-llvm', str(c_file), '-o', str(ir_file)]
    p = run_cmd(ir_cmd, verbose=verbose)
    ir_out = (p.stdout or '') + (p.stderr or '')
    ir_ok = p.returncode == 0

    wasm_cmd = [wasi_cc, opt_level, '--target', wasm_target, str(c_file), '-o', str(wasm_file)]
    if sysroot:
        wasm_cmd.extend(['--sysroot', sysroot])
    p = run_cmd(wasm_cmd, verbose=verbose)
    wasm_out = (p.stdout or '') + (p.stderr or '')
    wasm_ok = p.returncode == 0

    if emit_wat and wasm_ok:
        wasm2wat = shutil.which('wasm2wat')
        if wasm2wat:
            wat_cmd = [wasm2wat, str(wasm_file), '-o', str(wat_file)]
            p = run_cmd(wat_cmd, verbose=verbose)
            wat_out = (p.stdout or '') + (p.stderr or '')
            wat_ok = p.returncode == 0
        else:
            wat_out = 'wasm2wat not found, skipped.'

    return BuildResult(
        program=stem,
        native_ok=native_ok,
        ir_ok=ir_ok,
        wasm_ok=wasm_ok,
        wat_ok=wat_ok,
        native_out=native_out,
        ir_out=ir_out,
        wasm_out=wasm_out,
        wat_out=wat_out,
    )


def main() -> None:
    parser = argparse.ArgumentParser(description='Build C benchmarks to native exe, LLVM IR, and WASM.')
    parser.add_argument('--src-dir', required=True, help='Directory containing .c files.')
    parser.add_argument('--out-dir', required=True, help='Output directory for .exe/.ll/.wasm/.wat')
    parser.add_argument('--native-cc', default='', help='Native C compiler path/name. Default: env NATIVE_CC or clang')
    parser.add_argument('--wasi-cc', default='', help='WASI C compiler path/name. Default: env WASI_CC or wasi-sdk clang path guess')
    parser.add_argument('--wasm-target', default='wasm32-wasi', help='WASM target triple, default wasm32-wasi')
    parser.add_argument('--sysroot', default='', help='Optional WASI sysroot path')
    parser.add_argument('--opt-level', default='-O2', help='Optimization level, default -O2')
    parser.add_argument('--emit-wat', action='store_true', help='Try emit .wat using wasm2wat if available')
    parser.add_argument('--verbose', action='store_true', help='Print commands and detailed logs')
    args = parser.parse_args()

    src_dir = Path(args.src_dir)
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    native_cc = detect_tool(args.native_cc, 'NATIVE_CC', 'clang')
    wasi_cc_default = r'C:\wasi-sdk\bin\clang.exe' if os.name == 'nt' else 'clang'
    wasi_cc = detect_tool(args.wasi_cc, 'WASI_CC', wasi_cc_default)

    c_files = sorted(src_dir.glob('*.c'))
    if not c_files:
        print(f'No .c files found in {src_dir}')
        return

    print(f'Found {len(c_files)} benchmarks.')
    print(f'Native compiler: {native_cc}')
    print(f'WASI compiler:   {wasi_cc}')

    results: List[BuildResult] = []
    for c_file in c_files:
        print(f'\n=== Building {c_file.name} ===')
        r = compile_one(
            c_file=c_file,
            out_dir=out_dir,
            native_cc=native_cc,
            wasi_cc=wasi_cc,
            wasm_target=args.wasm_target,
            sysroot=args.sysroot,
            opt_level=args.opt_level,
            emit_wat=args.emit_wat,
            verbose=args.verbose,
        )
        results.append(r)

    report = out_dir / 'build_report.tsv'
    with report.open('w', encoding='utf-8') as f:
        f.write('program\tnative_ok\tir_ok\twasm_ok\twat_ok\n')
        for r in results:
            f.write(f'{r.program}\t{int(r.native_ok)}\t{int(r.ir_ok)}\t{int(r.wasm_ok)}\t{int(r.wat_ok)}\n')

    print('\n=== Build Summary ===')
    ok_native = sum(1 for r in results if r.native_ok)
    ok_ir = sum(1 for r in results if r.ir_ok)
    ok_wasm = sum(1 for r in results if r.wasm_ok)
    ok_wat = sum(1 for r in results if r.wat_ok)
    print(f'native ok: {ok_native}/{len(results)}')
    print(f'ir ok:     {ok_ir}/{len(results)}')
    print(f'wasm ok:   {ok_wasm}/{len(results)}')
    print(f'wat ok:    {ok_wat}/{len(results)}')
    print(f'report:    {report}')

    failed = [r for r in results if not (r.native_ok and r.ir_ok and r.wasm_ok)]
    if failed:
        print('\nSome targets failed. Showing short diagnostics:')
        for r in failed[:5]:
            print(f'\n[{r.program}]')
            if not r.native_ok:
                print('  native compile failed')
                print('  ', (r.native_out or '').splitlines()[-1] if r.native_out else 'no output')
            if not r.ir_ok:
                print('  ir emit failed')
                print('  ', (r.ir_out or '').splitlines()[-1] if r.ir_out else 'no output')
            if not r.wasm_ok:
                print('  wasm compile failed')
                print('  ', (r.wasm_out or '').splitlines()[-1] if r.wasm_out else 'no output')


if __name__ == '__main__':
    main()
