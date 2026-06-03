#!/usr/bin/env python3
"""Strategy definitions for the O0 baseline PoC.

Strategies compared in this experiment:
  raw               O0 baseline wasm, no wasm-opt applied (copied as-is);
  O3                wasm-opt -O3 applied to the O0 raw wasm (strong upper bound);
  random            reproducible random pass list from the allowed set;
  llm_static        LLM pass list chosen from static features of the O0 wasm;
  llm_static_perf   LLM pass list chosen from static features + O0 perf data.

Note: the O2 strategy from the original PoC is dropped here because the
interesting comparison is O0-raw vs O0+wasm-opt-O3 vs O0+LLM-passes.
If needed, an O2 strategy can be added back by inserting ("-O2", ["-O2"]).

`build_candidate` produces the optimised wasm under candidates/ and returns
the pass list for logging. Imported by s06_evaluate.
"""

from __future__ import annotations

import hashlib
import random
import shutil
from pathlib import Path
from typing import Dict, List, Optional, Tuple

from common import CAND_DIR, Program, load_allowed_passes, wasm_opt

STRATEGIES = ["raw", "O3", "random", "llm_static", "llm_static_perf"]


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
    if strategy == "O3":
        return ["-O3"], ["-O3"]
    if strategy == "random":
        passes = random_passes(program, allowed, global_seed)
        return passes, passes
    if strategy == "llm_static":
        sel = selections.get(f"{program}::static")
    elif strategy == "llm_static_perf":
        sel = selections.get(f"{program}::static_perf")
    else:
        raise ValueError(f"unknown strategy: {strategy!r}")
    passes = (sel or {}).get("passes", [])
    return list(passes), list(passes)


def build_candidate(
    prog: Program,
    strategy: str,
    selections: Dict[str, dict],
    allowed: Optional[List[str]] = None,
    global_seed: int = 42,
) -> Tuple[Optional[Path], List[str], str]:
    """Produce candidate wasm. Returns (path, passes, error_string)."""
    allowed = allowed or load_allowed_passes()
    args, passes = resolve_passes(prog.name, strategy, selections, allowed, global_seed)
    out = CAND_DIR / f"{prog.name}.{strategy}.wasm"

    if strategy == "raw" or not args:
        shutil.copy2(prog.raw_wasm, out)
        return out, passes, ""

    ok, err = wasm_opt(prog.raw_wasm, out, args)
    if not ok:
        return None, passes, err
    return out, passes, ""
