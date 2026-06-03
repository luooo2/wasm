#!/usr/bin/env bash
# End-to-end driver for the LLM-guided wasm-opt pass-selection PoC.
#
# Usage:
#   bash run_poc.sh                 # full pipeline, manual LLM responses
#   PROVIDER=heuristic bash run_poc.sh
#   PROVIDER=openai    bash run_poc.sh
#   REPEATS=10 WARMUP=3 bash run_poc.sh
#
# Requires on PATH: wasmer, wasm-opt, wasm-validate, python3, and the prebuilt
# llvm-test-suite artifacts under <repo>/data/build/llvm_direct.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/poc"

PROVIDER="${PROVIDER:-manual}"
REPEATS="${REPEATS:-8}"
WARMUP="${WARMUP:-2}"
TIMEOUT="${TIMEOUT:-300}"

# make wasmer visible in non-interactive shells
if ! command -v wasmer >/dev/null 2>&1 && [[ -f "${HOME}/.wasmer/wasmer.sh" ]]; then
  # shellcheck disable=SC1091
  source "${HOME}/.wasmer/wasmer.sh"
fi

echo "[1/5] extracting static features + perf summary"
python3 s02_extract_features.py

echo "[2/5] building LLM prompts"
python3 s03_make_prompts.py

echo "[3/5] obtaining pass selections (provider=${PROVIDER})"
python3 s04_llm_select.py --provider "${PROVIDER}"

echo "[4/5] running experiment (repeats=${REPEATS}, warmup=${WARMUP})"
python3 s07_run_all.py --repeats "${REPEATS}" --warmup "${WARMUP}" --timeout "${TIMEOUT}"

echo "[5/5] summarising"
python3 s08_summarize.py

echo "[done] see results/summary.md and results/figures/"
