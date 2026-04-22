#!/usr/bin/env bash
set -euo pipefail

# Collect perf stat metrics for runnable llvm direct-run benchmarks.
# Metrics are from assets/perf指标集设计V2.md:
#   all-loads-retired, all-stores-retired, branches-retired, conditional-branches,
#   instructions-retired, cpu-cycles, L1-icache-load-misses, branch-misses
#
# Modes:
#   - native
#   - wasm-jit
#   - wasm-aot
#
# Output:
#   data/results/perf_llvm/perf_raw_events_llvm.csv
#
# Example:
#   bash scripts/collect_perf_metrics_llvm.sh --repeats 5 --warmup 1

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${ROOT_DIR}/data/build/llvm_direct"
RUNNABLE_CSV="${ROOT_DIR}/data/results/llvm_direct_runnable.csv"
OUT_DIR="${ROOT_DIR}/data/results/perf_llvm"
OUT_CSV="${OUT_DIR}/perf_raw_events_llvm.csv"

WASMTIME_BIN="${WASMTIME_BIN:-wasmtime}"
PYTHON_BIN="${PYTHON_BIN:-python3}"

REPEATS=5
WARMUP=1
PROGRAMS=""   # comma separated optional subset

PERF_EVENTS="all-loads-retired,all-stores-retired,branches-retired,conditional-branches,instructions-retired,cpu-cycles,L1-icache-load-misses,branch-misses"

usage() {
  cat <<'EOF'
Usage: collect_perf_metrics_llvm.sh [options]

Options:
  --repeats N         Measured repeats per mode (default: 5)
  --warmup N          Warmup repeats per mode (default: 1)
  --programs CSV      Optional subset programs (comma-separated)
  --build-dir PATH    Build dir containing *.native/*.wasm
  --runnable-csv PATH Runnable table CSV
  --help              Show help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repeats) REPEATS="$2"; shift 2 ;;
    --warmup) WARMUP="$2"; shift 2 ;;
    --programs) PROGRAMS="$2"; shift 2 ;;
    --build-dir) BUILD_DIR="$2"; shift 2 ;;
    --runnable-csv) RUNNABLE_CSV="$2"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

mkdir -p "${OUT_DIR}" "${BUILD_DIR}/aot_cache"
command -v perf >/dev/null || { echo "perf not found"; exit 1; }
command -v "${WASMTIME_BIN}" >/dev/null || { echo "wasmtime not found"; exit 1; }
command -v "${PYTHON_BIN}" >/dev/null || { echo "python not found: ${PYTHON_BIN}"; exit 1; }
[[ -f "${RUNNABLE_CSV}" ]] || { echo "missing runnable csv: ${RUNNABLE_CSV}" >&2; exit 1; }

timestamp_now() { date +"%Y-%m-%dT%H:%M:%S%z"; }

name_in_csv_list() {
  local name="$1"
  local csv="$2"
  [[ -z "${csv}" ]] && return 0
  IFS=',' read -r -a arr <<< "${csv}"
  for x in "${arr[@]}"; do
    [[ "${name}" == "${x}" ]] && return 0
  done
  return 1
}

append_perf_rows() {
  local program="$1"
  local mode="$2"
  local run_idx="$3"
  local perf_file="$4"
  local status="$5"
  local note="$6"

  awk -F',' -v ts="$(timestamp_now)" -v p="${program}" -v m="${mode}" -v r="${run_idx}" -v st="${status}" -v nt="${note}" '
    BEGIN { OFS="," }
    NF >= 3 {
      value=$1; event=$3
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      gsub(/^[ \t]+|[ \t]+$/, "", event)
      if (event == "" || event ~ /^#/) next
      gsub(/,/, ";", nt)
      gsub(/,/, ";", value)
      print ts, p, m, r, event, value, st, nt
    }
  ' "${perf_file}" >> "${OUT_CSV}"
}

run_perf_once() {
  local program="$1"
  local mode="$2"
  local run_idx="$3"
  shift 3
  local -a cmd=( "$@" )

  local perf_tmp
  perf_tmp="$(mktemp)"
  local st="ok"
  local nt=""

  if ! perf stat --no-big-num -x, -e "${PERF_EVENTS}" -- "${cmd[@]}" 1>/dev/null 2>"${perf_tmp}"; then
    st="run_failed"
    nt="command_failed"
  fi
  append_perf_rows "${program}" "${mode}" "${run_idx}" "${perf_tmp}" "${st}" "${nt}"
  rm -f "${perf_tmp}"
}

echo "timestamp,program,mode,run_index,event,value,status,stderr_note" > "${OUT_CSV}"

mapfile -t PROGRAM_LIST < <("${PYTHON_BIN}" - <<PY
import csv
from pathlib import Path
p = Path(r"${RUNNABLE_CSV}")
rows = list(csv.DictReader(p.open("r", encoding="utf-8", newline="")))
for r in rows:
    name = (r.get("program") or "").strip()
    if name:
        print(name)
PY
)

echo "[info] runnable count: ${#PROGRAM_LIST[@]}"
echo "[info] output: ${OUT_CSV}"

for prog in "${PROGRAM_LIST[@]}"; do
  if ! name_in_csv_list "${prog}" "${PROGRAMS}"; then
    continue
  fi
  native_bin="${BUILD_DIR}/${prog}.native"
  wasm_file="${BUILD_DIR}/${prog}.wasm"
  aot_file="${BUILD_DIR}/aot_cache/${prog}.cwasm"
  [[ -f "${native_bin}" ]] || continue
  [[ -f "${wasm_file}" ]] || continue

  if [[ ! -f "${aot_file}" ]]; then
    "${WASMTIME_BIN}" compile "${wasm_file}" -o "${aot_file}" || true
  fi
  [[ -f "${aot_file}" ]] || continue

  echo "[perf] ${prog}"

  for ((i=1; i<=WARMUP; i++)); do
    "${native_bin}" >/dev/null 2>&1 || true
    "${WASMTIME_BIN}" run --dir=. "${wasm_file}" >/dev/null 2>&1 || true
    "${WASMTIME_BIN}" run --allow-precompiled --dir=. "${aot_file}" >/dev/null 2>&1 || true
  done

  for ((i=1; i<=REPEATS; i++)); do
    run_perf_once "${prog}" "native" "${i}" "${native_bin}"
    run_perf_once "${prog}" "wasm-jit" "${i}" "${WASMTIME_BIN}" run --dir=. "${wasm_file}"
    run_perf_once "${prog}" "wasm-aot" "${i}" "${WASMTIME_BIN}" run --allow-precompiled --dir=. "${aot_file}"
  done
done

echo "[done] ${OUT_CSV}"

