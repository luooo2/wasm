- 编译
  python3 src/build_benchmarks.py --src-dir data/microbenchmarks --out-dir data/build/microbench_internal

- 运行 JIT
  python3 src/run_benchmarks.py \
  --build-dir data/build/microbench_internal \
  --out-csv data/results/labels_microbench_internal.csv \
  --raw-csv data/results/labels_microbench_internal_raw.csv \
  --wasmtime wasmtime \
  --wasm-mode jit \
  --repeats 30 \
  --warmup 2 \
  --timeout 180 \
  --threshold 0.10

- 运行 AOT
  python3 src/run_benchmarks.py \
  --build-dir data/build/microbench_internal \
  --out-csv data/results/labels_microbench_internal.csv \
  --raw-csv data/results/labels_microbench_internal_raw.csv \
  --wasmtime wasmtime \
  --wasm-mode aot \
  --aot-cache-dir data/build/microbench_internal/aot_cache \
  --repeats 30 \
  --warmup 2

- both
  python3 src/run_benchmarks.py \
  --build-dir data/build/microbench_internal \
  --out-csv data/results/labels_microbench_internal.csv \
  --raw-csv data/results/labels_microbench_internal_raw.csv \
  --wasm-mode both

- 特征提取
  python3 src/extract_microbench_features.py \
  --src-dir data/microbenchmarks \
  --ir-dir data/build/microbench_internal \
  --labels-csv data/results/labels_microbench_internal.csv \
  --out-csv data/results/dataset_microbench.csv