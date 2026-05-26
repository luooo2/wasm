#!/usr/bin/env bash
set -euo pipefail

# Re-run the wasmtime analysis pipeline (assets/4.29后 + assets/4.29后/5.11)
# against the wasmer (cranelift) measurements, writing every intermediate
# file into this directory (assets/5.13/).
#
# Reused scripts (unchanged source code, just different --perf-csv/--labels-csv/--out-dir):
#   assets/4.29后/extract_static_features.py
#   assets/4.29后/5.11/build_time_perf_static_table.py
#   assets/4.29后/5.11/analyze_three_goals.py
#
# Wasmer inputs (already produced by wasmer_migration/):
#   data/results/wasmer/perf_llvm/perf_raw_events_llvm_wasmer_cranelift.csv
#   data/results/wasmer/labels_llvm_direct_from_runnable_wasmer_cranelift.csv
#
# The wasm IR (.ll files in data/build/llvm_direct/) is identical for both runtimes.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PY="${PYTHON_BIN:-python3}"

EXTRACT_SRC="${ROOT_DIR}/assets/4.29后/extract_static_features.py"
BUILD_TABLE_SRC="${ROOT_DIR}/assets/4.29后/5.11/build_time_perf_static_table.py"
ANALYZE_SRC="${ROOT_DIR}/assets/4.29后/5.11/analyze_three_goals.py"

WASMER_PERF_CSV="${ROOT_DIR}/data/results/wasmer/perf_llvm/perf_raw_events_llvm_wasmer_cranelift.csv"
WASMER_LABELS_CSV="${ROOT_DIR}/data/results/wasmer/labels_llvm_direct_from_runnable_wasmer_cranelift.csv"

for f in "${EXTRACT_SRC}" "${BUILD_TABLE_SRC}" "${ANALYZE_SRC}" "${WASMER_PERF_CSV}" "${WASMER_LABELS_CSV}"; do
  [[ -f "${f}" ]] || { echo "missing input: ${f}" >&2; exit 1; }
done

echo "[1/3] extract_static_features.py (perf=wasmer)"
"${PY}" "${EXTRACT_SRC}" \
  --perf-csv "${WASMER_PERF_CSV}" \
  --out-dir  "${HERE}"
# Outputs:
#   static_features_llvm_direct.csv
#   perf_medians_llvm_direct.csv
#   static_perf_join_llvm_direct.csv

echo "[2/3] build_time_perf_static_table.py (labels=wasmer)"
"${PY}" "${BUILD_TABLE_SRC}" \
  --join-csv   "${HERE}/static_perf_join_llvm_direct.csv" \
  --labels-csv "${WASMER_LABELS_CSV}" \
  --out-dir    "${HERE}"
# Outputs:
#   main_table_time_perf_static.csv
#   column_groups.json
#   spearman_static_vs_y_time_internal.csv
#   spearman_perf_ratio_vs_y_time_internal.csv
#   spearman_static_vs_y_time_by_mode.csv
#   README.md  (overwritten; we re-write our own afterwards)

echo "[3/3] analyze_three_goals.py"
"${PY}" "${ANALYZE_SRC}" \
  --main-csv    "${HERE}/main_table_time_perf_static.csv" \
  --groups-json "${HERE}/column_groups.json" \
  --out-dir     "${HERE}"
# Outputs (analysis_three_goals.md + fdr_* + model_* + bootstrap_*)

echo "[done] pipeline outputs in ${HERE}"
