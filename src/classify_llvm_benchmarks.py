#!/usr/bin/env python3
"""
Classify llvm-test-suite SingleSource/Benchmarks C programs into:
- direct-run: no args, no file/interactive IO requirement
- arg-run: requires argv/argc or getopt-like CLI parsing
- file-run: uses file/stdin style IO APIs
"""

import argparse
import csv
import re
from pathlib import Path
from typing import List, Tuple

RE_MAIN_ARGC_ARGV = re.compile(
    r"\bint\s+main\s*\(\s*(?:int\s+\w+\s*,\s*char\s*\*\s*\*|\s*int\s+\w+\s*,\s*char\s*\*\s*\[\])",
    re.MULTILINE,
)
RE_ARG_HINT = re.compile(r"\b(argc|argv|getopt|getopt_long)\b")
RE_FILE_IO_HINT = re.compile(
    r"\b(fopen|freopen|fclose|fread|fwrite|fseek|open\s*\(|read\s*\(|write\s*\(|scanf|fscanf|getchar|stdin|stdout)\b"
)


def classify_one(text: str) -> Tuple[str, str]:
    # File/interactive IO has highest priority because many arg-run programs also do IO.
    if RE_FILE_IO_HINT.search(text):
        return "file-run", "file/io api detected"
    if RE_MAIN_ARGC_ARGV.search(text) or RE_ARG_HINT.search(text):
        return "arg-run", "argc/argv or getopt detected"
    return "direct-run", "no arg/file io hint"


def to_program_name(c_path: Path, bench_root: Path) -> str:
    rel = c_path.relative_to(bench_root)
    stem = str(rel.with_suffix("")).replace("\\", "_").replace("/", "_")
    return f"llvmss_{stem.lower()}"


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--bench-root", default="data/llvm-test-suite/SingleSource/Benchmarks")
    ap.add_argument("--out-csv", default="data/results/llvm_c_catalog.csv")
    ap.add_argument("--out-direct", default="data/results/llvm_direct_run_list.txt")
    ap.add_argument("--out-arg", default="data/results/llvm_arg_run_list.txt")
    ap.add_argument("--out-file", default="data/results/llvm_file_run_list.txt")
    ap.add_argument("--exclude-polybench", action="store_true", default=True)
    args = ap.parse_args()

    bench_root = Path(args.bench_root)
    out_csv = Path(args.out_csv)
    out_direct = Path(args.out_direct)
    out_arg = Path(args.out_arg)
    out_file = Path(args.out_file)
    out_csv.parent.mkdir(parents=True, exist_ok=True)

    c_files = sorted(bench_root.rglob("*.c"))
    rows: List[dict] = []
    direct_names: List[str] = []
    arg_names: List[str] = []
    file_names: List[str] = []

    for c in c_files:
        rel = c.relative_to(bench_root)
        rel_posix = rel.as_posix()
        if args.exclude_polybench and rel_posix.startswith("Polybench/"):
            continue
        if rel_posix.startswith("Polybench/utilities/"):
            continue
        if c.name == "polybench.c":
            continue

        text = c.read_text(encoding="utf-8", errors="ignore")
        cls, reason = classify_one(text)
        program = to_program_name(c, bench_root)
        row = {
            "program": program,
            "class": cls,
            "reason": reason,
            "source_path": str(c).replace("\\", "/"),
            "relative_path": rel_posix,
        }
        rows.append(row)
        if cls == "direct-run":
            direct_names.append(program)
        elif cls == "arg-run":
            arg_names.append(program)
        else:
            file_names.append(program)

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(
            f,
            fieldnames=["program", "class", "reason", "source_path", "relative_path"],
        )
        w.writeheader()
        w.writerows(rows)

    out_direct.write_text("\n".join(direct_names) + ("\n" if direct_names else ""), encoding="utf-8")
    out_arg.write_text("\n".join(arg_names) + ("\n" if arg_names else ""), encoding="utf-8")
    out_file.write_text("\n".join(file_names) + ("\n" if file_names else ""), encoding="utf-8")

    print(f"classified total: {len(rows)}")
    print(f"direct-run: {len(direct_names)}")
    print(f"arg-run:    {len(arg_names)}")
    print(f"file-run:   {len(file_names)}")
    print(f"catalog:    {out_csv}")


if __name__ == "__main__":
    main()

