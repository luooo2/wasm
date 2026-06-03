#!/usr/bin/env python3
"""Build LLM prompts for wasm-opt pass selection.

Two ablation variants are produced per program:
  static       - static structural features only (no perf feedback);
  static_perf  - static features + wasm/native perf ratios.

Each prompt asks the model to return a strict JSON object with a diagnosis, a
pass list (subset of the allowed passes), and an expected-effect note. Prompts
are written to work/prompts/<program>.<variant>.txt and a combined index to
work/prompts/index.json so the selector / API caller can iterate over them.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Dict, List

from common import LLM_RESP_DIR, PROMPT_DIR, WORK_DIR, load_allowed_passes

VARIANTS = ["static", "static_perf"]

SYSTEM_PREAMBLE = """\
You are a WebAssembly backend-optimization assistant. Your job is NOT to rewrite
code; it is to choose a short list of Binaryen `wasm-opt` passes that are most
likely to reduce the runtime of a wasm program executed on the wasmer
(cranelift) runtime, WITHOUT changing its observable behaviour. A separate
toolchain will apply the passes, validate the module, run differential tests,
and benchmark the result; only correct and genuinely-faster candidates are kept.

Prior analysis shows wasm/native slowdown on this benchmark family is dominated
by execution-path expansion: retired instructions, CPU cycles, I-cache misses,
and branch counts -- not raw load/store volume. Prefer passes that shrink the
hot execution path (inlining of small hot calls, control-flow simplification,
redundant-local / common-subexpression elimination, constant folding, dead-code
removal, peephole instruction selection).
"""

ALLOWED_BLOCK_HDR = (
    "You may ONLY choose from this allowed pass list (choose at most 5, ordered "
    "as they should be applied):"
)

TASK_BLOCK = """\
Task:
Choose up to 5 wasm-opt passes from the allowed list above.
Goal: reduce wasm runtime on wasmer without changing program semantics.
Return JSON ONLY, no prose outside the JSON, in exactly this schema:
{
  "diagnosis": "<one or two sentences: what structural trait likely drives the slowdown>",
  "passes": ["--pass-a", "--pass-b", "..."],
  "expected_effect": "<which perf signal you expect to drop and why>"
}
"""


def fmt_static(feat: dict) -> str:
    b = feat["static_bucket"]
    raw = feat["static_raw"]
    lines = [
        "Static features (qualitative bucket [raw value]):",
        f"- function_count: {b.get('function_count','?')} [{int(raw['function_count'])}]",
        f"- loop_count: {b.get('loop_count','?')} [{int(raw['loop_count'])}]",
        f"- basic_block_count: {b.get('basic_block_count','?')} [{int(raw['basic_block_count'])}]",
        f"- branch_density: {b.get('branch_density','?')} [{raw['branch_density']:.3f}]",
        f"- call_density: {b.get('call_density','?')} [{raw['call_density']:.3f}]",
        f"- memory_access_density: {b.get('memory_access_density','?')} [{raw['memory_access_density']:.3f}]",
        f"- compute_density: {b.get('compute_density','?')} [{raw['compute_density']:.3f}]",
        f"- avg_func_size: {b.get('avg_func_size','?')} [{raw['avg_func_size']:.1f} expr/func]",
    ]
    return "\n".join(lines)


def fmt_perf(feat: dict) -> str:
    pr = feat.get("perf_ratios", {})
    if not pr:
        return "Perf feedback: (none available)"
    order = [
        ("ratio_instructions_retired", "instructions_retired"),
        ("ratio_cpu_cycles", "cpu_cycles"),
        ("ratio_l1_icache_load_misses", "L1_icache_load_misses"),
        ("ratio_branches_retired", "branches_retired"),
        ("ratio_branch_misses", "branch_misses"),
        ("ratio_all_loads_retired", "all_loads_retired"),
        ("ratio_all_stores_retired", "all_stores_retired"),
    ]
    lines = ["Perf feedback (wasm/native ratio on wasmer-cranelift; >1 = wasm worse):"]
    for key, label in order:
        if key in pr:
            lines.append(f"- {label}: {pr[key]:.2f}x")
    return "\n".join(lines)


def build_prompt(feat: dict, variant: str, allowed: List[str]) -> str:
    parts = [SYSTEM_PREAMBLE.strip(), ""]
    parts.append(f"Program: {feat['program']}")
    parts.append(f"Category: {feat['category']} ({feat['note']})")
    parts.append("")
    parts.append(
        "Baseline:\n"
        f"- wasm/native runtime ratio (wasmer aot): {feat['wasmer_aot_ratio']:.2f}x\n"
        f"- baseline wasm median runtime: {feat['wasmer_aot_wasm_ms']:.1f} ms"
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
