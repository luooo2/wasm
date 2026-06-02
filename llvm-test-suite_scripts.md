0. 构建 llvm direct-run（生成 .native/.wasm/.ll）
python3 src/build_llvm.py \
  --bench-root data/llvm-test-suite/SingleSource/Benchmarks \
  --direct-list data/results/llvm_direct_run_list.txt \
  --out-dir data/build/llvm_direct \
  --strategy-csv data/results/llvm_direct_build_strategy.csv

1. 批量跑 runnable
python3 src/run_llvm_from_runnable.py \
  --build-dir data/build/llvm_direct \
  --runnable-csv data/results/llvm_direct_runnable.csv \
  --wasm-mode both \
  --repeats 10 \
  --warmup 1 \
  --out-csv data/results/labels_llvm_direct_from_runnable.csv \
  --raw-csv data/results/labels_raw_llvm_direct_from_runnable.csv

2. 采集 perf（llvm runnable）
bash scripts/collect_perf_metrics_llvm.sh \
  --repeats 5 \
  --warmup 2
