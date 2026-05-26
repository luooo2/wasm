# 最小静态特征表 Schema 与 Perf Join 设计

## 目标

第一轮关联分析只保留 15 个可解释、可稳定提取的静态特征。静态特征表以 benchmark program 为粒度，perf 原始表以 `program + mode + run_index + event` 为粒度；分析前需要先把 perf 聚合为中位数，再与静态特征按 `program` 关联。

## 静态特征表粒度

- 表：`static_features_llvm_direct.csv`
- 粒度：每个 `program` 一行
- 主键：`program`
- 来源：`data/build/llvm_direct/*.ll`，循环信息优先来自 `opt -passes='print<loops>'`

## 建议进入第一轮模型/关联分析的 15 个特征

| feature | 定义 | 来源 | 用途 |
| --- | --- | --- | --- |
| `ir_instruction_count` | LLVM IR 指令总数 | Python 解析 `.ll` | 程序静态规模 |
| `basic_block_count` | 基本块总数，含隐式 entry block | Python 解析 `.ll` | CFG 规模 |
| `avg_bb_size` | `ir_instruction_count / basic_block_count` | 派生 | 控制流碎片化程度 |
| `avg_bb_out_degree` | CFG 边数 / 基本块数 | Python 解析 terminator | 平均控制流分叉程度 |
| `max_loop_depth` | 最大循环嵌套深度 | `opt print<loops>` | 循环结构复杂度 |
| `branch_instr_count` | `br/switch/indirectbr/select` 数量 | Python 解析 `.ll` | 静态分支位点 |
| `branch_density` | `branch_instr_count / ir_instruction_count` | 派生 | 控制流密度 |
| `compute_instr_count` | 算术、逻辑、比较、类型转换等计算类指令数 | Python 解析 `.ll` | 静态计算规模 |
| `compute_density` | `compute_instr_count / ir_instruction_count` | 派生 | 计算密集度 |
| `memory_instr_count` | `load + store + atomicrmw + cmpxchg` | Python 解析 `.ll` | 静态访存规模 |
| `memory_access_density` | `memory_instr_count / ir_instruction_count` | 派生 | 访存密集度 |
| `compute_to_memory_ratio` | `compute_density / max(memory_access_density, 1e-6)` | 派生 | 近似计算/访存强度 |
| `load_store_ratio` | `load_count / max(store_count, 1)` | 派生 | 读写偏向 |
| `call_instr_count` | `call/invoke/callbr` 数量 | Python 解析 `.ll` | 函数/库调用频度 |
| `hostcall_density` | `hostcall_count / ir_instruction_count` | 派生 | WASI/宿主交互密度 |

脚本还会输出若干辅助列，如 `source_path`、`ir_path`、`load_count`、`store_count`、`hostcall_count`、`alloc_call_count`、`loop_count`、`opt_loop_ok`。这些列用于审计和后续扩展，第一轮不建议全部放入模型。

## Perf Join 键设计

### 原始 perf 表

- 表：`data/results/perf_llvm/perf_raw_events_llvm.csv`
- 粒度：`program + mode + run_index + event`
- 主键候选：`program, mode, run_index, event`
- 现有事件：
  - `r81d0` = `all-loads-retired`
  - `r82d0` = `all-stores-retired`
  - `r00c4` = `branches-retired`
  - `r01c4` = `conditional-branches`
  - `r1c0` = `instructions-retired`
  - `cpu-cycles`
  - `L1-icache-load-misses`
  - `branch-misses`

### 中间聚合表

- 表：`perf_medians_llvm_direct.csv`
- 粒度：`program + mode + event`
- 聚合方式：对同一 `program/mode/event` 的多次 `run_index` 取 median
- 主键：`program, mode, event`

### 最终关联表

- 表：`static_perf_join_llvm_direct.csv`
- 粒度：`program + mode`
- 行范围：默认只保留 `wasm-jit` 与 `wasm-aot`
- Join：
  - `static_features.program = perf_medians.program`
  - wasm 模式的 perf 指标与同一 `program` 的 native perf 中位数相除，得到 `ratio_<event>_over_native`

最终关联分析建议优先使用：

- X：15 个静态特征
- Y：`ratio_instructions_retired_over_native`、`ratio_branches_retired_over_native`、`ratio_conditional_branches_over_native`、`ratio_all_loads_retired_over_native`、`ratio_all_stores_retired_over_native`、`ratio_cpu_cycles_over_native`、`ratio_L1_icache_load_misses_over_native`、`ratio_branch_misses_over_native`
- 分组键：`mode`

## 关于“静态 branches vs perf branches”是否冗余

不冗余。`branch_instr_count` 是静态结构特征，表示程序中有多少潜在分支位点；`branches-retired` 是动态执行结果，表示某次输入和运行时路径实际执行了多少分支。它们之间的关联正好回答“静态结构是否会被放大为动态微架构事件”。真正需要避免的是把多个高度线性相关的静态特征同时塞进小样本模型，因此第一轮建议先做 Spearman 相关、分箱散点图和 VIF/相关矩阵筛选。
