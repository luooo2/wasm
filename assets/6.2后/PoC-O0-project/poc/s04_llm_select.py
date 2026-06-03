#!/usr/bin/env python3
"""Obtain wasm-opt pass selections from the LLM for every (program, variant).

Three providers (same interface as the O2 PoC):

  manual     read pre-authored JSON from work/llm_responses/<prog>.<variant>.json.
             Use this when an LLM agent has filled in responses to the prompts.

  openai     call an OpenAI-compatible chat API. Reads OPENAI_API_KEY,
             OPENAI_BASE_URL (optional), OPENAI_MODEL (optional) from env.

  heuristic  rule-based selector adapted for O0 wasm patterns:
             targets local-bloat and call-density first (O0 priorities),
             then control-flow and compute redundancies.

All providers validate passes against the allowed list (<=5, deduplicated,
normalised to `--pass` form) and write work/selections.json.
"""

from __future__ import annotations

import argparse
import json
import os
import re
from pathlib import Path
from typing import Dict, List, Optional

from common import LLM_RESP_DIR, PROMPT_DIR, WORK_DIR, load_allowed_passes

MAX_PASSES = 5


def normalize_passes(passes: List[str], allowed: List[str]) -> List[str]:
    allowed_set = {a.lstrip("-") for a in allowed}
    seen = set()
    out: List[str] = []
    for p in passes:
        name = str(p).strip().lstrip("-")
        if not name or name not in allowed_set or name in seen:
            continue
        seen.add(name)
        out.append(f"--{name}")
        if len(out) >= MAX_PASSES:
            break
    return out


def _extract_json(text: str) -> Optional[dict]:
    text = text.strip()
    fence = re.search(r"```(?:json)?\s*(\{.*?\})\s*```", text, re.S)
    if fence:
        text = fence.group(1)
    start = text.find("{")
    end = text.rfind("}")
    if start == -1 or end == -1 or end <= start:
        return None
    try:
        return json.loads(text[start : end + 1])
    except json.JSONDecodeError:
        return None


def provider_manual(program: str, variant: str) -> Optional[dict]:
    fn = LLM_RESP_DIR / f"{program}.{variant}.json"
    if not fn.exists():
        return None
    try:
        return json.loads(fn.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return _extract_json(fn.read_text(encoding="utf-8"))


def provider_openai(program: str, variant: str) -> Optional[dict]:
    api_key = os.environ.get("OPENAI_API_KEY")
    if not api_key:
        raise SystemExit("OPENAI_API_KEY not set; cannot use --provider openai")
    base_url = os.environ.get("OPENAI_BASE_URL", "https://api.openai.com/v1")
    model = os.environ.get("OPENAI_MODEL", "gpt-4o-mini")
    prompt = (PROMPT_DIR / f"{program}.{variant}.txt").read_text(encoding="utf-8")

    try:
        from openai import OpenAI  # type: ignore
    except ImportError as e:
        raise SystemExit("openai package not installed (pip install openai)") from e

    client = OpenAI(api_key=api_key, base_url=base_url)
    resp = client.chat.completions.create(
        model=model,
        messages=[{"role": "user", "content": prompt}],
        temperature=0.2,
    )
    content = resp.choices[0].message.content or ""
    obj = _extract_json(content)
    if obj is not None:
        (LLM_RESP_DIR / f"{program}.{variant}.json").write_text(
            json.dumps(obj, indent=2), encoding="utf-8"
        )
    return obj


def provider_heuristic(program: str, variant: str) -> dict:
    """O0-adapted heuristic: prioritises local-bloat and inlining."""
    feats = json.loads((WORK_DIR / "features.json").read_text(encoding="utf-8"))
    feat = feats[program]
    b = feat["static_bucket"]
    passes: List[str] = []

    # O0 always has local bloat → simplify-locals first
    passes.append("--simplify-locals")

    # high call density → inline small callees (O0 has no inlining at all)
    if b.get("call_density") == "high" or feat["category"] == "call_dense":
        passes += ["--inlining-optimizing", "--dce"]
    else:
        passes.append("--dce")

    # high local bloat → CSE + coalescing after simplification
    if b.get("local_bloat") in ("high", "medium"):
        passes.append("--local-cse")
        passes.append("--coalesce-locals")

    # control-flow heavy → merge blocks + remove dead branches
    if b.get("branch_density") == "high" or feat["category"] == "control_flow":
        if "--dce" not in passes:
            passes.append("--dce")
        if len(passes) < MAX_PASSES:
            passes.append("--remove-unused-brs")
        if len(passes) < MAX_PASSES:
            passes.append("--merge-blocks")

    # peephole opts if budget remains
    if len(passes) < MAX_PASSES:
        passes.append("--optimize-instructions")

    # final vacuum
    if "--vacuum" not in passes and len(passes) < MAX_PASSES:
        passes.append("--vacuum")

    passes = list(dict.fromkeys(passes))[:MAX_PASSES]
    return {
        "diagnosis": (
            f"O0 baseline for category={feat['category']}: "
            f"local_bloat={b.get('local_bloat','?')}, "
            f"call_density={b.get('call_density','?')}"
        ),
        "passes": passes,
        "expected_effect": (
            "Reduce retired instructions via local simplification, inlining, "
            "and control-flow cleanup targeting O0-generated redundancies"
        ),
    }


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--provider", choices=["manual", "openai", "heuristic"], default="manual")
    ap.add_argument("--variants", default="static,static_perf")
    ap.add_argument("--out", default=str(WORK_DIR / "selections.json"))
    ap.add_argument(
        "--allow-missing",
        action="store_true",
        help="manual: skip (program,variant) pairs with no response file",
    )
    args = ap.parse_args()

    allowed = load_allowed_passes()
    index = json.loads((PROMPT_DIR / "index.json").read_text(encoding="utf-8"))
    variants = [v.strip() for v in args.variants.split(",") if v.strip()]

    selections: Dict[str, dict] = {}
    missing: List[str] = []
    for program in index:
        for variant in variants:
            key = f"{program}::{variant}"
            if args.provider == "manual":
                obj = provider_manual(program, variant)
            elif args.provider == "openai":
                obj = provider_openai(program, variant)
            else:
                obj = provider_heuristic(program, variant)

            if obj is None:
                missing.append(key)
                continue
            passes = normalize_passes(obj.get("passes", []), allowed)
            selections[key] = {
                "program": program,
                "variant": variant,
                "provider": args.provider,
                "diagnosis": obj.get("diagnosis", ""),
                "expected_effect": obj.get("expected_effect", ""),
                "passes_raw": obj.get("passes", []),
                "passes": passes,
            }

    if missing and not args.allow_missing and args.provider == "manual":
        print("[error] missing manual responses for:")
        for k in missing:
            print(f"  - {k}  (expected {LLM_RESP_DIR}/{k.replace('::', '.')}.json)")
        raise SystemExit(1)
    if missing:
        print(f"[warn] {len(missing)} (program,variant) had no response; skipped")

    Path(args.out).write_text(json.dumps(selections, indent=2), encoding="utf-8")
    print(f"[ok] wrote {len(selections)} selections to {args.out} (provider={args.provider})")


if __name__ == "__main__":
    main()
