# wasmtime vs wasmer (cranelift) - LLVM direct-run subset

- Common programs: **28**

## JIT mode

**Aggregate** (over programs ok in both runtimes):

- `n_pairs` = 28.0
- `wasmtime_median_ratio` = 1.2396
- `wasmer_median_ratio` = 1.2817
- `median_abs_delta` = 0.0787
- `median_rel_delta` = 0.0734
- `frac_label_changed` = 0.0714

**Confusion matrix (jit_label, rows=wasmtime, cols=wasmer):**

| wasmtime\\wasmer | wasm-better | similar | native-better | run-failed | total |
|---|---|---|---|---|---|
| wasm-better | 0 | 1 | 0 | 0 | 1 |
| similar | 0 | 9 | 1 | 0 | 10 |
| native-better | 0 | 0 | 17 | 0 | 17 |
| run-failed | 0 | 0 | 0 | 0 | 0 |
| total | 0 | 10 | 18 | 0 | 28 |

## AOT mode

**Aggregate** (over programs ok in both runtimes):

- `n_pairs` = 28.0
- `wasmtime_median_ratio` = 1.251
- `wasmer_median_ratio` = 1.2812
- `median_abs_delta` = 0.1107
- `median_rel_delta` = 0.1117
- `frac_label_changed` = 0.0714

**Confusion matrix (aot_label, rows=wasmtime, cols=wasmer):**

| wasmtime\\wasmer | wasm-better | similar | native-better | run-failed | total |
|---|---|---|---|---|---|
| wasm-better | 0 | 1 | 0 | 0 | 1 |
| similar | 0 | 9 | 1 | 0 | 10 |
| native-better | 0 | 0 | 17 | 0 | 17 |
| run-failed | 0 | 0 | 0 | 0 | 0 |
| total | 0 | 10 | 18 | 0 | 28 |

## Per-program detail

See `data/results/wasmer/runtime_comparison_summary.csv`.
