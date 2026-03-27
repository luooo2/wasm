
## Phase 2B 引入 PolyBench/C 子集

1. 选取合适的8-12个kernel
2. 改造 polybench 代码使其能适应本项目
3. 在 build_benchmarks.py 里加专门处理 polybench 程序的代码/重写 build_polybench_benchmarks.py 对 polybench 程序进行处理
4. 运行改造后的选取的 polybench 子集得到实验结果（labels_polybench.csv）

【注意】可以先快速测试 1-2 个kernel，确认流程能跑通，再批量引入
【注意】每一步留有相应的操作说明（如选取 kernel 列表及原因、polybench 改造说明等）