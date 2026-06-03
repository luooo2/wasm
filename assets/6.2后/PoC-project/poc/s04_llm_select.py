#!/usr/bin/env python3
"""Obtain wasm-opt pass selections from the 'LLM' for every (program, variant).

Three providers are supported so the closed loop can run in different settings:

  manual     read a pre-authored JSON response from
             work/llm_responses/<program>.<variant>.json. This is the path used
             when a human-or-agent LLM fills in responses to the generated
             prompts (fully reproducible, no network).

  openai     call an OpenAI-compatible chat API. Reads OPENAI_API_KEY,
             OPENAI_BASE_URL (optional) and OPENAI_MODEL (optional) from the
             environment, sends the prompt, parses the JSON reply, and caches it
             into work/llm_responses/. Use this to reproduce with a live model.

  heuristic  a transparent rule-based selector over the static/perf features.
             Not an LLM; provided as a deterministic fallback and as an extra
             ablation point so the pipeline always runs end-to-end.

All providers funnel through pass validation (allowed-list only, <=5, dedup,
normalised to the `--pass` form) and the result is written to
work/selections.json keyed by "<program>::<variant>".
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


# --------------------------------------------------------------------------- #
# pass normalisation
# --------------------------------------------------------------------------- #
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
    # strip markdown fences if present
    fence = re.search(r"```(?:json)?\s*(\{.*?\})\s*```", text, re.S)
    if fence:
        text = fence.group(1)
    # find first balanced-looking object
    start = text.find("{")
    end = text.rfind("}")
    if start == -1 or end == -1 or end <= start:
        return None
    try:
        return json.loads(text[start : end + 1])
    except json.JSONDecodeError:
        return None


# --------------------------------------------------------------------------- #
# providers
# --------------------------------------------------------------------------- #
def provider_manual(program: str, variant: str) -> Optional[dict]:
    fn = LLM_RESP_DIR / f"{program}.{variant}.json"
    if not fn.exists():
        return None
    try:
        return json.loads(fn.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        # tolerate a model dump with surrounding prose
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
    feats = json.loads((WORK_DIR / "features.json").read_text(encoding="utf-8"))
    feat = feats[program]
    b = feat["static_bucket"]
    passes: List[str] = []
    # call-dense / many small functions -> inline then clean up
    if b.get("call_density") == "high" or feat["category"] == "call_dense":
        passes += ["--inlining-optimizing", "--dce"]
    # control-flow heavy -> simplify branches/blocks
    if b.get("branch_density") == "high" or feat["category"] == "control_flow":
        passes += ["--remove-unused-brs", "--merge-blocks"]
    # compute/loop heavy -> peephole + local cleanup + const fold
    if feat["category"] == "loop_compute" or b.get("compute_density") == "high":
        passes += ["--optimize-instructions", "--simplify-locals", "--precompute"]
    # always-useful tail cleanup
    passes += ["--vacuum"]
    return {
        "diagnosis": f"heuristic rule selection for category={feat['category']}",
        "passes": passes,
        "expected_effect": "reduce retired instructions / branches via inlining, "
        "cfg simplification and peephole opts",
    }


# --------------------------------------------------------------------------- #
def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--provider", choices=["manual", "openai", "heuristic"], default="manual")
    ap.add_argument("--variants", default="static,static_perf")
    ap.add_argument("--out", default=str(WORK_DIR / "selections.json"))
    ap.add_argument(
        "--allow-missing",
        action="store_true",
        help="manual: skip (program,variant) with no response file instead of erroring",
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
