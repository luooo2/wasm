#!/usr/bin/env python3
"""Shared helpers for the LLM-guided wasm-opt pass-selection PoC (O0 baseline).

This module mirrors the original PoC helpers but is adapted for the -O0
baseline experiment:
  - BUILD_DIR points to the O0 build directory inside this project;
  - PERF_CSV points to the perf data collected on O0 wasm;
  - All other measurement, validation, and statistics utilities are unchanged.

Benchmark methodology:
  native : run the -O0 ELF binary directly;
  wasm   : `wasmer compile --cranelift x.wasm -o x.wasmu` once, then
           `wasmer run x.wasmu` (AOT steady-state execution).

Each benchmark emits `TIME_NS:<ns>` from an internal timer; we use that as
the primary signal and wall-clock as a sanity check.
"""

from __future__ import annotations

import os
import re
import shutil
import statistics
import subprocess
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional, Sequence, Tuple

# --------------------------------------------------------------------------- #
# Paths
# --------------------------------------------------------------------------- #
PROJECT_ROOT = Path(__file__).resolve().parent.parent          # .../PoC-O0-project
REPO_ROOT = PROJECT_ROOT.parents[2]                            # .../wasm

# O0 binaries live in PoC-O0-project/build/ (created by s01_build_o0.py)
BUILD_DIR = PROJECT_ROOT / "build"

CONFIG_DIR = PROJECT_ROOT / "config"
WORK_DIR = PROJECT_ROOT / "work"
PROMPT_DIR = WORK_DIR / "prompts"
LLM_RESP_DIR = WORK_DIR / "llm_responses"
CAND_DIR = PROJECT_ROOT / "candidates"
RESULTS_DIR = PROJECT_ROOT / "results"
FIG_DIR = RESULTS_DIR / "figures"

# Perf data collected on O0 wasm (created by perf/collect_perf_o0.sh)
PERF_CSV = PROJECT_ROOT / "perf" / "perf_raw_events_o0_wasmer_cranelift.csv"

for _d in (BUILD_DIR, WORK_DIR, PROMPT_DIR, LLM_RESP_DIR, CAND_DIR, RESULTS_DIR, FIG_DIR):
    _d.mkdir(parents=True, exist_ok=True)

# Tools (overridable via env)
WASMER = os.environ.get("WASMER_BIN", "wasmer")
WASM_OPT = os.environ.get("WASM_OPT_BIN", "wasm-opt")
WASM_VALIDATE = os.environ.get("WASM_VALIDATE_BIN", "wasm-validate")
WASMER_COMPILER = os.environ.get("WASMER_COMPILER", "cranelift")

RE_TIME_NS = re.compile(r"TIME_NS\s*:\s*([0-9]+)")
_NOISE_PREFIXES = (
    "warning:",
    "warning :",
    "Compiling",
    "Finished",
)


# --------------------------------------------------------------------------- #
# Program registry
# --------------------------------------------------------------------------- #
@dataclass
class Program:
    name: str
    category: str
    note: str = ""
    wasmer_aot_ratio: float = 0.0
    wasmer_aot_wasm_ms: float = 0.0

    @property
    def native_bin(self) -> Path:
        return BUILD_DIR / f"{self.name}.native"

    @property
    def raw_wasm(self) -> Path:
        return BUILD_DIR / f"{self.name}.wasm"

    @property
    def ll_file(self) -> Path:
        return BUILD_DIR / f"{self.name}.ll"


def load_programs(csv_path: Optional[Path] = None) -> List[Program]:
    import csv

    csv_path = csv_path or (CONFIG_DIR / "programs.csv")
    out: List[Program] = []
    with csv_path.open(newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            out.append(
                Program(
                    name=r["program"].strip(),
                    category=r.get("category", "").strip(),
                    note=r.get("note", "").strip(),
                    wasmer_aot_ratio=float(r.get("wasmer_aot_ratio") or 0.0),
                    wasmer_aot_wasm_ms=float(r.get("wasmer_aot_wasm_ms") or 0.0),
                )
            )
    return out


def load_allowed_passes(path: Optional[Path] = None) -> List[str]:
    path = path or (CONFIG_DIR / "allowed_passes.txt")
    passes: List[str] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        s = line.strip()
        if not s or s.startswith("#"):
            continue
        passes.append(s)
    return passes


# --------------------------------------------------------------------------- #
# Statistics
# --------------------------------------------------------------------------- #
def stats(vals: Sequence[float]) -> Dict[str, float]:
    if not vals:
        return {"mean": 0.0, "median": 0.0, "std": 0.0, "min": 0.0, "max": 0.0, "n": 0}
    return {
        "mean": statistics.mean(vals),
        "median": statistics.median(vals),
        "std": statistics.stdev(vals) if len(vals) >= 2 else 0.0,
        "min": min(vals),
        "max": max(vals),
        "n": len(vals),
    }


# --------------------------------------------------------------------------- #
# Output normalisation for differential testing
# --------------------------------------------------------------------------- #
def normalize_output(raw: str) -> str:
    """Strip the timer line and runtime noise so two runs can be compared."""
    lines = []
    for ln in (raw or "").splitlines():
        s = ln.rstrip("\r")
        if RE_TIME_NS.search(s):
            continue
        st = s.strip()
        if not st:
            continue
        if any(st.startswith(p) for p in _NOISE_PREFIXES):
            continue
        lines.append(s)
    return "\n".join(lines)


# --------------------------------------------------------------------------- #
# Process execution
# --------------------------------------------------------------------------- #
@dataclass
class RunResult:
    ok: bool
    internal_ms: Optional[float]
    external_ms: float
    stdout: str
    error: str = ""


def _run_once(cmd: Sequence[str], timeout_sec: int) -> RunResult:
    t0 = time.perf_counter()
    try:
        p = subprocess.run(list(cmd), capture_output=True, text=True, timeout=timeout_sec)
    except subprocess.TimeoutExpired:
        return RunResult(False, None, (time.perf_counter() - t0) * 1000.0, "", f"timeout>{timeout_sec}s")
    ext_ms = (time.perf_counter() - t0) * 1000.0
    combined = f"{p.stdout or ''}\n{p.stderr or ''}"
    if p.returncode != 0:
        err = (p.stderr or p.stdout or "").strip() or f"exit {p.returncode}"
        return RunResult(False, None, ext_ms, p.stdout or "", err)
    m = RE_TIME_NS.search(combined)
    internal = (int(m.group(1)) / 1_000_000.0) if m else None
    return RunResult(True, internal, ext_ms, p.stdout or "", "" if m else "no TIME_NS")


# --------------------------------------------------------------------------- #
# wasm-opt / wasm-validate
# --------------------------------------------------------------------------- #
def wasm_opt(in_wasm: Path, out_wasm: Path, args: Sequence[str]) -> Tuple[bool, str]:
    out_wasm.parent.mkdir(parents=True, exist_ok=True)
    cmd = [WASM_OPT, str(in_wasm), "-o", str(out_wasm), *args]
    p = subprocess.run(cmd, capture_output=True, text=True)
    if p.returncode != 0:
        return False, (p.stderr or p.stdout or "").strip()
    return True, ""


def wasm_validate(wasm: Path) -> Tuple[bool, str]:
    p = subprocess.run([WASM_VALIDATE, str(wasm)], capture_output=True, text=True)
    if p.returncode != 0:
        return False, (p.stderr or p.stdout or "").strip()
    return True, ""


def wasmer_compile(wasm: Path, wasmu: Path) -> Tuple[bool, str]:
    wasmu.parent.mkdir(parents=True, exist_ok=True)
    cmd = [WASMER, "compile", f"--{WASMER_COMPILER}", str(wasm), "-o", str(wasmu)]
    p = subprocess.run(cmd, capture_output=True, text=True)
    if p.returncode != 0:
        return False, (p.stderr or p.stdout or "").strip()
    return True, ""


# --------------------------------------------------------------------------- #
# Benchmark drivers
# --------------------------------------------------------------------------- #
@dataclass
class BenchResult:
    ok: bool
    internal: Dict[str, float] = field(default_factory=dict)
    external: Dict[str, float] = field(default_factory=dict)
    sample_output: str = ""
    error: str = ""
    raw_internal_ms: List[float] = field(default_factory=list)


def bench_native(prog: Program, repeats: int, warmup: int, timeout: int) -> BenchResult:
    cmd = [str(prog.native_bin)]
    return _bench_cmd(cmd, repeats, warmup, timeout)


def bench_wasm_aot(
    wasm: Path, wasmu: Path, repeats: int, warmup: int, timeout: int
) -> BenchResult:
    ok, err = wasmer_compile(wasm, wasmu)
    if not ok:
        return BenchResult(False, error=f"wasmer compile failed: {err}")
    cmd = [WASMER, "run", str(wasmu)]
    return _bench_cmd(cmd, repeats, warmup, timeout)


def _bench_cmd(cmd: Sequence[str], repeats: int, warmup: int, timeout: int) -> BenchResult:
    for _ in range(max(warmup, 0)):
        _run_once(cmd, timeout)
    ins: List[float] = []
    exs: List[float] = []
    sample = ""
    for i in range(repeats):
        r = _run_once(cmd, timeout)
        if not r.ok or r.internal_ms is None:
            return BenchResult(False, error=r.error or "run failed")
        if i == 0:
            sample = r.stdout
        ins.append(r.internal_ms)
        exs.append(r.external_ms)
    return BenchResult(
        True,
        internal=stats(ins),
        external=stats(exs),
        sample_output=sample,
        raw_internal_ms=ins,
    )


def get_reference_output(prog: Program, timeout: int = 180) -> Optional[str]:
    """Canonical output from the native binary, normalised."""
    r = _run_once([str(prog.native_bin)], timeout)
    if not r.ok:
        return None
    return normalize_output(r.stdout)


def check_tools() -> List[str]:
    missing = []
    for tool in (WASMER, WASM_OPT, WASM_VALIDATE):
        if shutil.which(tool) is None:
            missing.append(tool)
    return missing
