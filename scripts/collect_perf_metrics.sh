#!/usr/bin/env bash
set -euo pipefail

# Collect perf stat metrics for:
#   1) data/microbenchmarks
#   2) data/webassembly-polybench-c-master (via src/build_polybench.py)
#
# Runtime modes:
#   - native
#   - wasm-jit  (wasmtime run <file.wasm>)
#   - wasm-aot  (wasmtime run --allow-precompiled <file.cwasm>)
#
# Output:
#   data/results/perf/perf_raw_events.csv
#
# Usage example:
#   bash scripts/collect_perf_metrics.sh --repeats 10 --warmup 2
#
# Optional subset:
#   bash scripts/collect_perf_metrics.sh --suite micro --micro-list compute_int_add,memory_seq_read
#   bash scripts/collect_perf_metrics.sh --suite poly --poly-list gemm,atax

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

MICRO_SRC_DIR="${ROOT_DIR}/data/microbenchmarks"
MICRO_BUILD_DIR="${ROOT_DIR}/data/microbench_build_perf"

POLY_ROOT="${ROOT_DIR}/data/webassembly-polybench-c-master"
POLY_BUILD_DIR="${ROOT_DIR}/data/polybench_build_perf"

OUT_DIR="${ROOT_DIR}/data/results/perf"
OUT_CSV="${OUT_DIR}/perf_raw_events.csv"

NATIVE_CC="${NATIVE_CC:-clang}"
WASI_CC="${WASI_CC:-$HOME/wasi-sdk/bin/clang}"
WASMTIME_BIN="${WASMTIME_BIN:-wasmtime}"
PYTHON_BIN="${PYTHON_BIN:-python3}"

OPT_FLAG="${OPT_FLAG:--O2}"
WASI_TARGET="${WASI_TARGET:-wasm32-wasip1}"

REPEATS=5
WARMUP=1
SUITE="all"             # all|micro|poly
MICRO_LIST=""           # comma-separated names
POLY_LIST=""            # comma-separated names

# perf events from assets/perf指标集设计V1.md
PERF_EVENTS="cycles,instructions,branches,branch-misses,L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses"

usage() {
  cat <<'EOF'
Usage: collect_perf_metrics.sh [options]

Options:
  --repeats N          Measured repeats per mode (default: 5)
  --warmup N           Warmup runs per mode (default: 1)
  --suite NAME         all|micro|poly (default: all)
  --micro-list CSV     Comma-separated microbench program names (without .c)
  --poly-list CSV      Comma-separated polybench program names
  --opt FLAG           Compile optimization flag (default: -O2)
  --help               Show this help

Environment override:
  NATIVE_CC, WASI_CC, WASMTIME_BIN, PYTHON_BIN, WASI_TARGET
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repeats) REPEATS="$2"; shift 2 ;;
    --warmup) WARMUP="$2"; shift 2 ;;
    --suite) SUITE="$2"; shift 2 ;;
    --micro-list) MICRO_LIST="$2"; shift 2 ;;
    --poly-list) POLY_LIST="$2"; shift 2 ;;
    --opt) OPT_FLAG="$2"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

mkdir -p "${OUT_DIR}" "${MICRO_BUILD_DIR}" "${POLY_BUILD_DIR}"

command -v "${NATIVE_CC}" >/dev/null || { echo "native compiler not found: ${NATIVE_CC}" >&2; exit 1; }
command -v "${WASMTIME_BIN}" >/dev/null || { echo "wasmtime not found: ${WASMTIME_BIN}" >&2; exit 1; }
command -v perf >/dev/null || { echo "perf not found" >&2; exit 1; }
command -v "${PYTHON_BIN}" >/dev/null || { echo "python not found: ${PYTHON_BIN}" >&2; exit 1; }

if [[ ! -x "${WASI_CC}" ]]; then
  echo "WASI compiler not executable: ${WASI_CC}" >&2
  exit 1
fi

if [[ ! -d "${MICRO_SRC_DIR}" ]]; then
  echo "Missing microbench dir: ${MICRO_SRC_DIR}" >&2
  exit 1
fi

if [[ ! -d "${POLY_ROOT}" ]]; then
  echo "Missing polybench root: ${POLY_ROOT}" >&2
  exit 1
fi

echo "timestamp,suite,program,mode,run_index,event,value,status,stderr_note" > "${OUT_CSV}"

timestamp_now() {
  date +"%Y-%m-%dT%H:%M:%S%z"
}

append_perf_rows() {
  local suite="$1"
  local program="$2"
  local mode="$3"
  local run_idx="$4"
  local perf_stderr_file="$5"
  local status="$6"
  local note="$7"

  # perf -x, format commonly: value,unit,event,....
  # We use --no-big-num to keep value parsable.
  awk -F',' -v ts="$(timestamp_now)" -v s="${suite}" -v p="${program}" -v m="${mode}" -v r="${run_idx}" -v st="${status}" -v nt="${note}" '
    BEGIN { OFS="," }
    NF >= 3 {
      value=$1
      unit=$2
      event=$3
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      gsub(/^[ \t]+|[ \t]+$/, "", event)
      # skip empty rows and comments
      if (event == "" || event ~ /^#/) next
      # sanitize commas in note (replace with semicolon)
      gsub(/,/, ";", nt)
      gsub(/,/, ";", value)
      print ts, s, p, m, r, event, value, st, nt
    }
  ' "${perf_stderr_file}" >> "${OUT_CSV}"
}

run_perf_once() {
  local suite="$1"
  local program="$2"
  local mode="$3"
  local run_idx="$4"
  shift 4
  local -a cmd=( "$@" )

  local perf_tmp
  perf_tmp="$(mktemp)"
  local run_status="ok"
  local run_note=""

  if ! perf stat --no-big-num -x, -e "${PERF_EVENTS}" -- "${cmd[@]}" 1>/dev/null 2>"${perf_tmp}"; then
    run_status="run_failed"
    run_note="command_failed"
  fi

  append_perf_rows "${suite}" "${program}" "${mode}" "${run_idx}" "${perf_tmp}" "${run_status}" "${run_note}"
  rm -f "${perf_tmp}"
}

name_in_csv_list() {
  local name="$1"
  local csv="$2"
  [[ -z "${csv}" ]] && return 0
  IFS=',' read -r -a arr <<< "${csv}"
  for item in "${arr[@]}"; do
    [[ "${name}" == "${item}" ]] && return 0
  done
  return 1
}

build_microbench() {
  echo "[build] microbench native/wasm ..."
  shopt -s nullglob
  for cfile in "${MICRO_SRC_DIR}"/*.c; do
    local name
    name="$(basename "${cfile}" .c)"
    if ! name_in_csv_list "${name}" "${MICRO_LIST}"; then
      continue
    fi
    local native_bin="${MICRO_BUILD_DIR}/${name}.native"
    local wasm_file="${MICRO_BUILD_DIR}/${name}.wasm"
    local aot_file="${MICRO_BUILD_DIR}/${name}.cwasm"

    "${NATIVE_CC}" "${OPT_FLAG}" "${cfile}" -o "${native_bin}"
    "${WASI_CC}" "${OPT_FLAG}" -target "${WASI_TARGET}" "${cfile}" -o "${wasm_file}"
    "${WASMTIME_BIN}" compile "${wasm_file}" -o "${aot_file}"
  done
}

collect_microbench() {
  echo "[perf] microbench ..."
  shopt -s nullglob
  for native_bin in "${MICRO_BUILD_DIR}"/*.native; do
    local name
    name="$(basename "${native_bin}" .native)"
    local wasm_file="${MICRO_BUILD_DIR}/${name}.wasm"
    local aot_file="${MICRO_BUILD_DIR}/${name}.cwasm"

    [[ -f "${wasm_file}" ]] || continue
    [[ -f "${aot_file}" ]] || continue
    if ! name_in_csv_list "${name}" "${MICRO_LIST}"; then
      continue
    fi

    local i
    for ((i=1; i<=WARMUP; i++)); do
      "${native_bin}" >/dev/null 2>&1 || true
      "${WASMTIME_BIN}" run --dir=. "${wasm_file}" >/dev/null 2>&1 || true
      "${WASMTIME_BIN}" run --allow-precompiled --dir=. "${aot_file}" >/dev/null 2>&1 || true
    done

    for ((i=1; i<=REPEATS; i++)); do
      run_perf_once "micro" "${name}" "native" "${i}" "${native_bin}"
      run_perf_once "micro" "${name}" "wasm-jit" "${i}" "${WASMTIME_BIN}" run --dir=. "${wasm_file}"
      run_perf_once "micro" "${name}" "wasm-aot" "${i}" "${WASMTIME_BIN}" run --allow-precompiled --dir=. "${aot_file}"
    done
  done
}

build_polybench() {
  echo "[build] polybench native/wasm via src/build_polybench.py ..."
  "${PYTHON_BIN}" "${ROOT_DIR}/src/build_polybench.py" \
    --polybench-root "${POLY_ROOT}" \
    --out-dir "${POLY_BUILD_DIR}" \
    --native-cc "${NATIVE_CC}" \
    --wasi-cc "${WASI_CC}" \
    --opt "${OPT_FLAG}" \
    --wasi-target "${WASI_TARGET}" \
    --report "${OUT_DIR}/build_report_polybench_perf.csv"

  shopt -s nullglob
  for wasm_file in "${POLY_BUILD_DIR}"/*.wasm; do
    local name
    name="$(basename "${wasm_file}" .wasm)"
    if ! name_in_csv_list "${name}" "${POLY_LIST}"; then
      continue
    fi
    "${WASMTIME_BIN}" compile "${wasm_file}" -o "${POLY_BUILD_DIR}/${name}.cwasm"
  done
}

collect_polybench() {
  echo "[perf] polybench ..."
  shopt -s nullglob
  for native_bin in "${POLY_BUILD_DIR}"/*.native; do
    local name
    name="$(basename "${native_bin}" .native)"
    local wasm_file="${POLY_BUILD_DIR}/${name}.wasm"
    local aot_file="${POLY_BUILD_DIR}/${name}.cwasm"
    [[ -f "${wasm_file}" ]] || continue
    [[ -f "${aot_file}" ]] || continue
    if ! name_in_csv_list "${name}" "${POLY_LIST}"; then
      continue
    fi

    local i
    for ((i=1; i<=WARMUP; i++)); do
      "${native_bin}" >/dev/null 2>&1 || true
      "${WASMTIME_BIN}" run --dir=. "${wasm_file}" >/dev/null 2>&1 || true
      "${WASMTIME_BIN}" run --allow-precompiled --dir=. "${aot_file}" >/dev/null 2>&1 || true
    done

    for ((i=1; i<=REPEATS; i++)); do
      run_perf_once "poly" "${name}" "native" "${i}" "${native_bin}"
      run_perf_once "poly" "${name}" "wasm-jit" "${i}" "${WASMTIME_BIN}" run --dir=. "${wasm_file}"
      run_perf_once "poly" "${name}" "wasm-aot" "${i}" "${WASMTIME_BIN}" run --allow-precompiled --dir=. "${aot_file}"
    done
  done
}

echo "[info] ROOT_DIR=${ROOT_DIR}"
echo "[info] PERF_EVENTS=${PERF_EVENTS}"
echo "[info] REPEATS=${REPEATS}, WARMUP=${WARMUP}, SUITE=${SUITE}"
echo "[info] output=${OUT_CSV}"

case "${SUITE}" in
  all)
    build_microbench
    collect_microbench
    build_polybench
    collect_polybench
    ;;
  micro)
    build_microbench
    collect_microbench
    ;;
  poly)
    build_polybench
    collect_polybench
    ;;
  *)
    echo "Invalid --suite: ${SUITE}, expected all|micro|poly" >&2
    exit 1
    ;;
esac

echo "[done] perf raw events written to: ${OUT_CSV}"
echo "[tip] you can post-process to median/IQR and wasm/native ratios by (suite,program,event,mode)"
