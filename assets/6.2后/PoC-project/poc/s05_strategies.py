#!/usr/bin/env python3
"""Strategy definitions: map a (program, strategy) to a wasm-opt invocation.

Strategies compared in the PoC:
  raw               baseline wasm, no wasm-opt (copied as-is);
  O2 / O3           fixed strong wasm-opt optimisation levels;
  random            a reproducible random pass list from the allowed set;
  llm_static        LLM pass list chosen from static features only;
  llm_static_perf   LLM pass list chosen from static features + perf feedback.

`build_candidate` produces the optimised wasm under candidates/ and returns the
pass list actually used (for logging). This module is imported by s06_evaluate.
"""

from __future__ import annotations

import hashlib
import random
import shutil
from pathlib import Path
from typing import Dict, List, Optional, Tuple

from common import CAND_DIR, Program, load_allowed_passes, wasm_opt

STRATEGIES = ["raw", "O2", "O3", "random", "llm_static", "llm_static_perf"]


def _seed_for(program: str, global_seed: int) -> int:
    h = hashlib.sha256(f"{program}:{global_seed}".encode()).hexdigest()
    return int(h[:8], 16)


def random_passes(program: str, allowed: List[str], global_seed: int = 42) -> List[str]:
    rng = random.Random(_seed_for(program, global_seed))
    k = rng.randint(3, 5)
    chosen = rng.sample(allowed, k)
    return [f"--{p.lstrip('-')}" for p in chosen]


def resolve_passes(
    program: str,
    strategy: str,
    selections: Dict[str, dict],
    allowed: List[str],
    global_seed: int = 42,
) -> Tuple[List[str], List[str]]:
    """Return (wasm_opt_args, pass_list_for_logging)."""
    if strategy == "raw":
        return [], []
    if strategy in ("O2", "O3"):
        return [f"-{strategy}"], [f"-{strategy}"]
    if strategy == "random":
        passes = random_passes(program, allowed, global_seed)
        return passes, passes
    if strategy == "llm_static":
        sel = selections.get(f"{program}::static")
    elif strategy == "llm_static_perf":
        sel = selections.get(f"{program}::static_perf")
    else:
        raise ValueError(f"unknown strategy {strategy}")
    passes = (sel or {}).get("passes", [])
    return list(passes), list(passes)


def build_candidate(
    prog: Program,
    strategy: str,
    selections: Dict[str, dict],
    allowed: Optional[List[str]] = None,
    global_seed: int = 42,
) -> Tuple[Optional[Path], List[str], str]:
    """Produce candidate wasm. Returns (path, passes, error)."""
    allowed = allowed or load_allowed_passes()
    args, passes = resolve_passes(prog.name, strategy, selections, allowed, global_seed)
    out = CAND_DIR / f"{prog.name}.{strategy}.wasm"

    if strategy == "raw" or not args:
        # raw, or an llm/random selection that produced no passes -> copy baseline
        shutil.copy2(prog.raw_wasm, out)
        return out, passes, ""

    ok, err = wasm_opt(prog.raw_wasm, out, args)
    if not ok:
        return None, passes, err
    return out, passes, ""
