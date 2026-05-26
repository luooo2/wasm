# Wasmer migration (cranelift backend only)

This folder contains the Wasmer counterparts of two wasmtime-based scripts.
Goal: re-run the LLVM-test-suite direct-run benchmark experiment on the Wasmer
runtime (cranelift backend) to check whether prior wasmtime conclusions
generalise across runtimes.

Everything else (wasi-sdk build artifacts, runnable list, native binaries,
feature tables, downstream analysis) is reused as-is.

## Scripts

- `run_llvm_from_runnable_wasmer.py`  - clone of `src/run_llvm_from_runnable.py`
  using `wasmer run --cranelift` for JIT and `wasmer compile --cranelift` +
  `wasmer run <prog>.wasmu` for AOT. Outputs to `data/results/wasmer/`.
- `collect_perf_metrics_llvm_wasmer.sh` - clone of
  `scripts/collect_perf_metrics_llvm.sh` that runs `perf stat` with the same
  raw event set over native / wasm-jit / wasm-aot using wasmer. Outputs to
  `data/results/wasmer/perf_llvm/`.

Both scripts add two extra CSV columns (`runtime_engine`, `compiler`) so the
wasmer rows can be unioned with wasmtime rows downstream.

## Typical invocation

```bash
# Make sure wasmer is on PATH (installer drops a sourcing hook into ~/.bashrc):
source ~/.wasmer/wasmer.sh

# 1) Timing (internal TIME_NS + external wall) - mirrors the wasmtime run.
python3 wasmer_migration/run_llvm_from_runnable_wasmer.py \
  --repeats 10 --warmup 1

# 2) perf counters - mirrors collect_perf_metrics_llvm.sh.
bash wasmer_migration/collect_perf_metrics_llvm_wasmer.sh \
  --repeats 5 --warmup 1
```

## Outputs

- `data/results/wasmer/labels_llvm_direct_from_runnable_wasmer_cranelift.csv`
- `data/results/wasmer/labels_raw_llvm_direct_from_runnable_wasmer_cranelift.csv`
- `data/results/wasmer/perf_llvm/perf_raw_events_llvm_wasmer_cranelift.csv`
- AOT artifacts: `data/build/llvm_direct/aot_cache_wasmer/cranelift/*.wasmu`
