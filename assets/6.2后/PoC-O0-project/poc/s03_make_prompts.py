#!/usr/bin/env python3
"""Build LLM prompts for wasm-opt pass selection on O0 baseline wasm.

Two ablation variants per program:
  static       - static structural features only (no perf feedback)
  static_perf  - static features + wasm/native perf ratios from O0 execution

Key difference from the O2 PoC: the baseline wasm here is compiled with -O0,
meaning the module contains substantial low-hanging fruit that is absent in -O2
baselines:
  - Redundant local.get/local.set sequences (no mem2reg / register allocation)
  - Unmerged basic blocks and trivial unreachable branches
  - No dead-code elimination (dead assignments, unreachable stores)
  - No inlining of small hot callees (every call site is a real function call)
  - No constant folding or common-subexpression elimination across statements
  - No coalescing of local variables (O0 allocates one local per SSA value)

The prompt emphasises these O0-specific patterns so the LLM can target the
most impactful reduction passes first.

Outputs:
  work/prompts/<program>.<variant>.txt
  work/prompts/index.json
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Dict, List

from common import LLM_RESP_DIR, PROMPT_DIR, WORK_DIR, load_allowed_passes

VARIANTS = ["static", "static_perf"]

SYSTEM_PREAMBLE = """\
You are a WebAssembly backend-optimization expert. Your task is to select a
short sequence of Binaryen `wasm-opt` passes that maximally reduce the runtime
of a wasm module compiled with **-O0** (no optimizations) when executed via
the wasmer/cranelift AOT runtime.

CRITICAL CONTEXT — the baseline is -O0 compiled wasm:
Unlike -O2 baselines, an -O0 wasm module is full of redundant structure that
wasm-opt can eliminate cheaply and with high impact:
  1. LOCAL BLOAT: the compiler emits one local per SSA value, giving thousands
     of redundant local.get/local.set pairs. Passes: simplify-locals,
     coalesce-locals, merge-locals, local-cse.
  2. NO INLINING: every call is a true function call, even trivial 1-3 line
     helpers. Inlining them eliminates call overhead and enables follow-on
     peephole opts. Passes: inlining, inlining-optimizing.
  3. DEAD CODE: no DCE was run; dead stores and unreachable blocks survive.
     Passes: dce, vacuum, remove-unused-names.
  4. UNMERGED CONTROL FLOW: trivial fall-through blocks are not merged; branch
     chains are not simplified. Passes: remove-unused-brs, merge-blocks.
  5. NO CONSTANT FOLDING / PEEPHOLE: arithmetic on constants, identity
     operations, and strength-reduction opportunities are untouched.
     Passes: precompute, optimize-instructions.
  6. UNOPTIMIZED SSA FORM: the SSA structure is not normalised; ssa pass +
     follow-on simplification can unlock further redundancy.
     Passes: ssa (then simplify-locals / local-cse).

Pass-ordering matters. Recommended ordering principles:
  a. Inlining first (exposes more opportunities to later passes).
  b. DCE / vacuum early (eliminates dead code before expensive analyses).
  c. Local simplification (simplify-locals, coalesce-locals) after inlining.
  d. Instruction-level peephole (optimize-instructions, precompute) near end.
  e. Final vacuum to clean up any newly-created dead code.

Prior analysis of this benchmark family shows wasm/native slowdown is dominated
by instruction count expansion and I-cache pressure — both directly addressable
by inlining + local cleanup + control-flow simplification on O0 code.

Do NOT rewrite the program. Only choose from the allowed pass list.
A toolchain will apply the passes, validate the module, run differential
correctness tests, and benchmark the result; only correct and faster candidates
are accepted.
"""

ALLOWED_BLOCK_HDR = (
    "You may ONLY choose from the allowed pass list below (choose at most 5, "
    "ordered as they should be applied):"
)

TASK_BLOCK = """\
Task:
Select up to 5 wasm-opt passes from the allowed list above, ordered for
maximum effect on this -O0 compiled module.
Goal: reduce wasm runtime on wasmer/cranelift without changing program semantics.
Return ONLY a JSON object in exactly this schema (no prose outside the JSON):
{
  "diagnosis": "<1-2 sentences: which O0-specific redundancy dominates this program>",
  "passes": ["--pass-a", "--pass-b", "..."],
  "expected_effect": "<which perf signal you expect to drop and why>"
}
"""


def fmt_static(feat: dict) -> str:
    b = feat["static_bucket"]
    raw = feat["static_raw"]
    lines = [
        "Static features of the -O0 wasm (qualitative bucket [raw value]):",
        f"- function_count: {b.get('function_count','?')} [{int(raw['function_count'])}]",
        f"- loop_count: {b.get('loop_count','?')} [{int(raw['loop_count'])}]",
        f"- basic_block_count: {b.get('basic_block_count','?')} [{int(raw['basic_block_count'])}]",
        f"- branch_density: {b.get('branch_density','?')} [{raw['branch_density']:.3f}]",
        f"- call_density: {b.get('call_density','?')} [{raw['call_density']:.3f}]",
        f"- memory_access_density: {b.get('memory_access_density','?')} [{raw['memory_access_density']:.3f}]",
        f"- compute_density: {b.get('compute_density','?')} [{raw['compute_density']:.3f}]",
        f"- avg_func_size: {b.get('avg_func_size','?')} [{raw['avg_func_size']:.1f} expr/func]",
        f"- local_bloat (O0): {b.get('local_bloat','?')} [{raw.get('local_bloat',0):.3f}]  "
        f"  ← fraction of exprs that are local.get/set",
        f"- block_density (O0): {b.get('block_density','?')} [{raw.get('block_density',0):.3f}]"
        f"  ← unmerged basic block density",
    ]
    return "\n".join(lines)


def fmt_perf(feat: dict) -> str:
    pr = feat.get("perf_ratios", {})
    if not pr:
        return "Perf feedback: (not available — run perf/collect_perf_o0.sh first)"
    order = [
        ("ratio_instructions_retired", "instructions_retired"),
        ("ratio_cpu_cycles", "cpu_cycles"),
        ("ratio_l1_icache_load_misses", "L1_icache_load_misses"),
        ("ratio_branches_retired", "branches_retired"),
        ("ratio_branch_misses", "branch_misses"),
        ("ratio_all_loads_retired", "all_loads_retired"),
        ("ratio_all_stores_retired", "all_stores_retired"),
    ]
    lines = [
        "Perf feedback on -O0 wasm (wasm/native ratio on wasmer-cranelift; >1 = wasm worse):",
    ]
    for key, label in order:
        if key in pr:
            lines.append(f"- {label}: {pr[key]:.2f}x")
    return "\n".join(lines)


def build_prompt(feat: dict, variant: str, allowed: List[str]) -> str:
    ratio_str = (
        f"{feat['wasmer_aot_ratio']:.2f}x"
        if feat["wasmer_aot_ratio"] > 0
        else "(not yet measured — run s01_build_o0.py)"
    )
    wasm_ms_str = (
        f"{feat['wasmer_aot_wasm_ms']:.1f} ms"
        if feat["wasmer_aot_wasm_ms"] > 0
        else "(not yet measured)"
    )
    parts = [SYSTEM_PREAMBLE.strip(), ""]
    parts.append(f"Program: {feat['program']}")
    parts.append(f"Category: {feat['category']} ({feat['note']})")
    parts.append("")
    parts.append(
        f"O0 Baseline:\n"
        f"- wasm/native runtime ratio (wasmer AOT, -O0 wasm): {ratio_str}\n"
        f"- O0 raw wasm median runtime: {wasm_ms_str}"
    )
    parts.append("")
    parts.append(fmt_static(feat))
    parts.append("")
    if variant == "static_perf":
        parts.append(fmt_perf(feat))
        parts.append("")
    parts.append(ALLOWED_BLOCK_HDR)
    parts.append("\n".join(f"  {p}" for p in allowed))
    parts.append("")
    parts.append(TASK_BLOCK.strip())
    return "\n".join(parts) + "\n"


def main() -> None:
    feats = json.loads((WORK_DIR / "features.json").read_text(encoding="utf-8"))
    allowed = load_allowed_passes()

    index: Dict[str, Dict[str, str]] = {}
    n = 0
    for name, feat in feats.items():
        index[name] = {}
        for variant in VARIANTS:
            text = build_prompt(feat, variant, allowed)
            fn = PROMPT_DIR / f"{name}.{variant}.txt"
            fn.write_text(text, encoding="utf-8")
            index[name][variant] = str(fn.relative_to(PROMPT_DIR.parent.parent))
            n += 1

    (PROMPT_DIR / "index.json").write_text(json.dumps(index, indent=2), encoding="utf-8")
    print(f"[ok] wrote {n} prompts to {PROMPT_DIR}")
    print(f"[ok] response files expected under {LLM_RESP_DIR} as <program>.<variant>.json")


if __name__ == "__main__":
    main()
