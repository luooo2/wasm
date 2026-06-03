#!/usr/bin/env bash
# End-to-end driver for the LLM-guided wasm-opt pass-selection PoC (O0 baseline).
#
# This script runs the full pipeline from compilation to result summary.
# Adjust the PROVIDER and benchmark repetition settings as needed.
#
# Pipeline stages:
#   [0] Build O0 wasm/native binaries and measure baseline timing
#   [1] Extract static features from O0 wasm + LLVM IR
#  ([P]) Optional: collect perf data (requires perf on PATH)
#   [2] Build LLM prompts
#   [3] Obtain pass selections (provider = manual | openai | heuristic)
#   [4] Run experiment benchmark
#   [5] Summarise results
#
# Usage:
#   bash run_poc_o0.sh                         # full pipeline, manual LLM responses
#   PROVIDER=openai bash run_poc_o0.sh         # use OpenAI API
#   PROVIDER=heuristic bash run_poc_o0.sh      # use rule-based heuristic
#   SKIP_BUILD=1 bash run_poc_o0.sh            # skip recompilation
#   WITH_PERF=1 bash run_poc_o0.sh             # also collect perf data
#   REPEATS=10 WARMUP=3 bash run_poc_o0.sh
#
# Prerequisites on PATH: wasmer, wasm-opt, wasm-validate, clang,
#   /opt/wasi-sdk/bin/clang (or WASI_CC env), python3.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

PROVIDER="${PROVIDER:-manual}"
REPEATS="${REPEATS:-8}"
WARMUP="${WARMUP:-2}"
TIMEOUT="${TIMEOUT:-300}"
SKIP_BUILD="${SKIP_BUILD:-0}"
WITH_PERF="${WITH_PERF:-0}"
WASI_CC="${WASI_CC:-/opt/wasi-sdk/bin/clang}"

# ── make wasmer visible in non-interactive shells ──────────────────────────
if ! command -v wasmer >/dev/null 2>&1 && [[ -f "${HOME}/.wasmer/wasmer.sh" ]]; then
  # shellcheck disable=SC1091
  source "${HOME}/.wasmer/wasmer.sh"
fi

echo "============================================================"
echo " PoC-O0  |  provider=${PROVIDER}  repeats=${REPEATS}  warmup=${WARMUP}"
echo "============================================================"

# [0] Build O0 binaries
if [[ "${SKIP_BUILD}" == "0" ]]; then
  echo ""
  echo "[0/5] building O0 wasm/native binaries and measuring baseline timing"
  python3 poc/s01_build_o0.py --wasi-cc "${WASI_CC}"
else
  echo "[0/5] skipping build (SKIP_BUILD=1)"
fi

# [1] Static features
echo ""
echo "[1/5] extracting static features from O0 wasm"
python3 poc/s02_extract_features.py

# [P] Perf data (optional)
if [[ "${WITH_PERF}" == "1" ]]; then
  echo ""
  echo "[P]   collecting perf data on O0 wasm (this may take several minutes)"
  bash perf/collect_perf_o0.sh --repeats 5 --warmup 1
  echo "[P]   re-extracting features with perf data"
  python3 poc/s02_extract_features.py
fi

# [2] Prompts
echo ""
echo "[2/5] building LLM prompts (O0-aware)"
python3 poc/s03_make_prompts.py

# [3] Pass selections
echo ""
echo "[3/5] obtaining pass selections (provider=${PROVIDER})"
python3 poc/s04_llm_select.py --provider "${PROVIDER}" --allow-missing

# [4] Experiment
echo ""
echo "[4/5] running experiment (repeats=${REPEATS}, warmup=${WARMUP})"
python3 poc/s07_run_all.py \
  --repeats "${REPEATS}" \
  --warmup "${WARMUP}" \
  --timeout "${TIMEOUT}"

# [5] Summary
echo ""
echo "[5/5] summarising results"
python3 poc/s08_summarize.py

echo ""
echo "[done] see results/summary.md and results/figures/"
