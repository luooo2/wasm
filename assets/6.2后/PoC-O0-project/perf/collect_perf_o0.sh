#!/usr/bin/env bash
# Collect perf stat metrics for the PoC-O0 cohort on -O0 compiled wasm.
#
# This is an adapted copy of wasmer_migration/collect_perf_metrics_llvm_wasmer.sh
# restricted to the 12 PoC programs and pointing to the O0 build directory.
#
# Perf events measured (same set as O2 pipeline for direct comparability):
#   r81d0  -> all-loads-retired
#   r82d0  -> all-stores-retired
#   r00c4  -> branches-retired
#   r01c4  -> conditional-branches
#   r1c0   -> instructions-retired
#   cpu-cycles, L1-icache-load-misses, branch-misses
#
# Modes:
#   native    ./prog.native  (O0 native binary)
#   wasm-aot  wasmer run prog.wasmu  (AOT compiled from O0 wasm)
#
# Output:
#   perf/perf_raw_events_o0_wasmer_cranelift.csv
#
# Usage:
#   bash perf/collect_perf_o0.sh                    # from project root
#   bash perf/collect_perf_o0.sh --repeats 7 --warmup 2
#   bash perf/collect_perf_o0.sh --programs llvmss_stanford_perm,llvmss_misc_evalloop

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "${SCRIPT_DIR}")"

BUILD_DIR="${PROJECT_ROOT}/build"
AOT_DIR="${BUILD_DIR}/aot_cache_wasmer"
OUT_CSV="${SCRIPT_DIR}/perf_raw_events_o0_wasmer_cranelift.csv"

# Programs list comes from config/programs.csv
PROGRAMS_CSV="${PROJECT_ROOT}/config/programs.csv"

WASMER_BIN="${WASMER_BIN:-wasmer}"
PYTHON_BIN="${PYTHON_BIN:-python3}"
WASMER_COMPILER="cranelift"

REPEATS=5
WARMUP=1
PROGRAMS=""   # optional comma-separated subset (empty = all)

PERF_EVENTS="r81d0,r82d0,r00c4,r01c4,r1c0,cpu-cycles,L1-icache-load-misses,branch-misses"

usage() {
  cat <<'EOF'
Usage: collect_perf_o0.sh [options]

Options:
  --repeats N        Measured repeats per mode (default: 5)
  --warmup N         Warmup repeats per mode (default: 1)
  --programs CSV     Optional subset programs (comma-separated)
  --help             Show help

This script must be run from within PoC-O0-project/ or its poc/ subdirectory.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repeats) REPEATS="$2"; shift 2 ;;
    --warmup) WARMUP="$2"; shift 2 ;;
    --programs) PROGRAMS="$2"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 1 ;;
  esac
done

# ── Tool checks ────────────────────────────────────────────────────────────
command -v perf >/dev/null || { echo "[error] perf not found on PATH" >&2; exit 1; }
if ! command -v "${WASMER_BIN}" >/dev/null 2>&1; then
  if [[ -f "${HOME}/.wasmer/wasmer.sh" ]]; then
    # shellcheck disable=SC1091
    source "${HOME}/.wasmer/wasmer.sh"
  fi
fi
command -v "${WASMER_BIN}" >/dev/null || { echo "[error] wasmer not found on PATH" >&2; exit 1; }
command -v "${PYTHON_BIN}" >/dev/null || { echo "[error] python3 not found" >&2; exit 1; }

mkdir -p "${AOT_DIR}"

# ── Helpers ────────────────────────────────────────────────────────────────
timestamp_now() { date +"%Y-%m-%dT%H:%M:%S%z"; }

name_in_csv_list() {
  local name="$1"
  local csv="$2"
  [[ -z "${csv}" ]] && return 0    # empty list = all
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
  local eng="wasmer"
  local cmp="${WASMER_COMPILER}"

  awk -F',' -v ts="$(timestamp_now)" -v p="${program}" -v m="${mode}" \
      -v r="${run_idx}" -v st="${status}" -v nt="${note}" \
      -v eng="${eng}" -v cmp="${cmp}" '
    BEGIN { OFS="," }
    NF >= 3 {
      value=$1; event=$3
      gsub(/^[ \t]+|[ \t]+$/, "", value)
      gsub(/^[ \t]+|[ \t]+$/, "", event)
      if (event == "" || event ~ /^#/) next
      gsub(/,/, ";", nt)
      gsub(/,/, ";", value)
      print ts, p, m, r, event, value, st, nt, eng, cmp
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

# ── Load program list from config/programs.csv ────────────────────────────
mapfile -t PROGRAM_LIST < <("${PYTHON_BIN}" - <<PY
import csv
from pathlib import Path
p = Path(r"${PROGRAMS_CSV}")
rows = list(csv.DictReader(p.open("r", encoding="utf-8", newline="")))
for r in rows:
    name = (r.get("program") or "").strip()
    if name:
        print(name)
PY
)

echo "[info] programs in cohort: ${#PROGRAM_LIST[@]}"
echo "[info] wasmer=${WASMER_BIN}  compiler=${WASMER_COMPILER}"
echo "[info] build_dir=${BUILD_DIR}"
echo "[info] output=${OUT_CSV}"

# ── Write CSV header ───────────────────────────────────────────────────────
echo "timestamp,program,mode,run_index,event,value,status,stderr_note,runtime_engine,compiler" > "${OUT_CSV}"

# ── Per-program measurement loop ──────────────────────────────────────────
for prog in "${PROGRAM_LIST[@]}"; do
  if ! name_in_csv_list "${prog}" "${PROGRAMS}"; then
    continue
  fi

  native_bin="${BUILD_DIR}/${prog}.native"
  wasm_file="${BUILD_DIR}/${prog}.wasm"
  aot_file="${AOT_DIR}/${prog}.wasmu"

  [[ -f "${native_bin}" ]] || { echo "[skip] ${prog}: missing native binary"; continue; }
  [[ -f "${wasm_file}" ]]  || { echo "[skip] ${prog}: missing wasm file";     continue; }

  # Pre-compile wasm to wasmer AOT format (once per program)
  if [[ ! -f "${aot_file}" ]]; then
    echo "[aot]  compiling ${prog} ..."
    "${WASMER_BIN}" compile "--${WASMER_COMPILER}" "${wasm_file}" -o "${aot_file}" || {
      echo "[warn] AOT compile failed for ${prog}; skipping"
      continue
    }
  fi

  echo "[perf] ${prog}"

  # Warmup
  for ((i=1; i<=WARMUP; i++)); do
    "${native_bin}" >/dev/null 2>&1 || true
    "${WASMER_BIN}" run "${aot_file}" >/dev/null 2>&1 || true
  done

  # Measured repeats
  for ((i=1; i<=REPEATS; i++)); do
    run_perf_once "${prog}" "native"   "${i}" "${native_bin}"
    run_perf_once "${prog}" "wasm-aot" "${i}" "${WASMER_BIN}" run "${aot_file}"
  done
done

echo "[done] ${OUT_CSV}"
