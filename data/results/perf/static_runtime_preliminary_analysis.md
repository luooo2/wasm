# 静态 LLVM 特征与 PMU 运行时差距：初步分析

**数据来源**

- `static_runtime_joint.csv`：每个程序一行，合并 `dataset_microbench.csv` / `dataset_polybench_kernel.csv` 与 `data_perf.csv` 在 `run_index` 上的聚合（均值、标准差）及派生指标。
- `static_runtime_correlations.csv`：在 **micro**（n=34）与 **poly**（n=30）内分别计算 **Spearman ρ**（静态数值特征 × 运行时「差距」目标）。

**指标含义（摘要）**

| 派生列 | 含义 |
|--------|------|
| `cycles_ratio_*_over_native` | Wasm 与 Native 的 **cycles 比**；无墙钟时间时用 cycles 作执行时间代理。 |
| `instructions_ratio_*_over_native` | **指令膨胀**：退役指令数 Wasm / Native。 |
| `delta_*_jit` / `delta_*_aot` | Wasm 与 Native 在分支 miss rate、L1/LLC load miss rate、IPC 上的 **差值**（Wasm − Native）。 |

---

## 1. 样本与数据范围

- 程序数：**64**（micro **34**，poly **30**）。
- 联合表列数：**102**（静态特征 + PMU 分 mode 的 mean/std + `perf_run_count_*` + 派生差距）。
- 相关性条目：**432**（18 个静态数值特征 × 12 个目标 × 2 个 suite）。

**重要限制（阅读下文结论时请一并考虑）**

1. **样本量小**：Spearman 仅适合作 **探索性** 排序，不宜单独强调显著性检验；micro 与 poly 应 **分开解读**。
2. **相关≠因果**：静态特征与 PMU 差距可能共同受第三类因素驱动（例如程序族、优化路径、输入规模固定为各基准自带规模等）。
3. **PolyBench 静态特征来自 kernel IR**：与「整程序」PMU 是否逐条对齐取决于提取范围；解释时建议称为「kernel 结构 proxy」。
4. **Micro 中 host/syscall 类程序**：`syscall_count` 等在微基准里离散且数值小，与 **host 调用密集型** 程序高度重合，容易在秩相关上放大。

---

## 2. Cycles 比：两套基准的量级完全不同

### 2.1 Micro

| 指标 | min | median | max | mean ± std |
|------|-----|--------|-----|------------|
| `cycles_ratio_jit_over_native` | 0.792 | 1.653 | 19.502 | 4.179 ± 4.830 |
| `cycles_ratio_aot_over_native` | 0.791 | 1.648 | 16.871 | 3.827 ± 4.214 |

**解读**：中位数约 **1.65×**，但 **长尾极重**（最大约 **19.5×**），说明少数微基准在 PMU 视角下与 Native 差距极大，会拉高均值与方差。这与微基准刻意放大某类行为（分配、host 查询等）一致。

### 2.2 Poly（kernel）

| 指标 | min | median | max | mean ± std |
|------|-----|--------|-----|------------|
| `cycles_ratio_jit_over_native` | 0.911 | 1.070 | 2.696 | 1.291 ± 0.431 |
| `cycles_ratio_aot_over_native` | 0.915 | 1.067 | 2.694 | 1.284 ± 0.428 |

**解读**：整体 **紧得多**：中位数约 **1.07×**，多数 kernel 在 wasmtime 下与 Native 处于同一数量级。这与文档中「PolyBench 作为 Wasm 表现较好 baseline」的叙述一致。

**对比结论**：在 **当前数据与输入规模** 下，**「结构—性能差距」的主矛盾在 micro 上更尖锐、在 poly 上更温和**；跨 suite 直接比较绝对 cycles 比意义有限，应分 suite 写结论。

---

## 3. 指令膨胀（instructions 比）

### Micro

| 指标 | min | median | max |
|------|-----|--------|-----|
| `instructions_ratio_jit_over_native` | 0.906 | 2.150 | 20.684 |
| `instructions_ratio_aot_over_native` | 0.899 | 2.133 | 17.751 |

### Poly

| 指标 | min | median | max |
|------|-----|--------|-----|
| `instructions_ratio_jit_over_native` | 1.422 | 2.182 | 4.811 |
| `instructions_ratio_aot_over_native` | 1.422 | 2.182 | 4.749 |

**解读**

- **Poly**：JIT/AOT 的指令数相对 Native 普遍 **>1**（最小约 **1.42×**），符合「Wasm 栈机 + 边界检查等带来额外动态指令」的预期；cycles 比仍常接近 1，说明 **IPC / 微架构行为** 在补偿部分指令膨胀。
- **Micro**：中位数约 **2.15×**，且上界更大，与 **host/分配/系统路径** 等微基准中「动态路径差异」叠加一致。

---

## 4. 极端程序（`cycles_ratio_jit_over_native`，便于 case study）

### 4.1 Micro — Wasm 最慢（JIT cycles 比最高）

| program | cycles_ratio_jit | label | ls_ratio | br_density | syscall_count |
|---------|-----------------|-------|----------|--------------|-----------------|
| host_env_query | 19.50 | native-better | 0.164 | 0.134 | 3 |
| host_time_loop | 17.35 | native-better | 0.222 | 0.056 | 4 |
| alloc_small_objects | 11.30 | native-better | 0.122 | 0.041 | 3 |

**解读**：前三名均带 **强 host / 环境 / 时间** 或 **小对象分配** 语义，与「系统调用 / 运行时 API 实现主导差距」的假设一致；静态表里的 `syscall_count` 等虽数值不大，但与 **程序族标签** 高度对齐，适合作为 **定性 case**，而不是单靠 `syscall_count` 线性外推。

### 4.2 Micro — 最接近 Native（JIT cycles 比最低）

| program | cycles_ratio_jit | label | ls_ratio | br_density | syscall_count |
|---------|-----------------|-------|----------|--------------|-----------------|
| compute_fp_muladd | 1.04 | similar | 0.138 | 0.046 | 3 |
| compute_int_mul | 0.97 | similar | 0.130 | 0.043 | 3 |
| branch_switch_sparse | 0.79 | wasm-better | 0.120 | 0.120 | 3 |

**解读**：**计算密集、控制流相对规整** 的程序 cycles 比接近 1 或低于 1，与总结文档中「计算密集 + 热点规模可控时 Wasm 机器码质量可接近 Native」一致。

### 4.3 Poly — Wasm 最慢

| program | cycles_ratio_jit | label | ls_ratio | br_density | syscall_count |
|---------|-----------------|-------|----------|--------------|-----------------|
| gemm | 2.70 | native-better | 0.378 | 0.126 | 0 |
| jacobi-1d | 2.26 | native-better | 0.364 | 0.102 | 0 |
| durbin | 2.21 | native-better | 0.429 | 0.098 | 0 |

**解读**：高 **ls_ratio**、数值 kernel 特征明显；无 syscall 仍慢，提示差距主要来自 **计算与访存路径在 Wasm 下的代码生成与执行效率**，而非 host 调用。

### 4.4 Poly — 最接近 Native

| program | cycles_ratio_jit | label | ls_ratio | br_density | syscall_count |
|---------|-----------------|-------|----------|--------------|-----------------|
| gramschmidt | 0.95 | wasm-better | 0.418 | 0.103 | 0 |
| cholesky | 0.93 | similar | 0.392 | 0.096 | 0 |
| lu | 0.91 | similar | 0.394 | 0.125 | 0 |

**解读**：与既有 **label**（wasm-better / similar）一致，可作为「Wasm 接近 Native」边界的 **正面样本**，后续可结合 roofline / 分块大小做更深入分解。

---

## 5. Spearman：与 JIT cycles 比相关最强的静态特征

### 5.1 Micro（|ρ| 前 8）

| feature | spearman_rho | n |
|---------|--------------|---|
| compute_density | -0.543 | 34 |
| compute_mem_ratio | -0.434 | 34 |
| syscall_count | +0.420 | 34 |
| call_instr_count | +0.379 | 34 |
| mem_instr_count | +0.286 | 34 |
| avg_bb_size | -0.242 | 34 |
| compute_instr_count | -0.238 | 34 |
| io_call_count | +0.198 | 34 |

**解读（假设性）**

- **compute_density / compute_mem_ratio 为负**：静态上「更偏计算、算存比更高」的微基准，JIT cycles 比 **更低**（相对不那么慢），与「纯算内核在 Wasm 上尚可」一致。
- **syscall_count、call_instr_count、io_call_count 为正**：与 **4.15 总结** 中「系统调用与运行时实现强相关、难以一概而论」相呼应；在本数据里它们与 **更差的 cycles 比** 同向，说明 **至少在当前微基准集合与 wasmtime 路径下**，host/调用密集与 **更大 slowdown** 常共存。

### 5.2 Poly（|ρ| 前 8）

| feature | spearman_rho | n |
|---------|--------------|---|
| total_instr_count | -0.442 | 30 |
| mem_instr_count | -0.392 | 30 |
| max_loop_depth | -0.369 | 30 |
| br_instr_count | -0.361 | 30 |
| basic_block_count | -0.360 | 30 |
| ls_ratio | -0.272 | 30 |
| call_instr_count | -0.228 | 30 |
| compute_instr_count | -0.164 | 30 |

**解读（假设性）**

- **IR 规模与结构复杂度 proxy**（`total_instr_count`、`basic_block_count`、`br_instr_count`）与 cycles 比 **负相关**：秩上「更大、更复杂的 kernel」反而 **相对不那么慢**。这与「大 kernel 中 Native 全局优化收益 vs Wasm 路径」的多种可能解释都相容，**不能**从秩相关一步推出单一因果；更稳妥的表述是：**在本批 PolyBench kernel 与固定输入下，静态「体量/CFG 复杂度」与 JIT slowdown 不呈简单单调恶化**。
- 与 micro 不同，poly 侧 **未出现 syscall_count 主导**（多为 0），符合两类 workload 的差异。

### 5.3 Micro 与 Poly 的「一致信号」

- micro 的 cycles JIT 比 **|ρ| 前五** 特征：`compute_density`, `compute_mem_ratio`, `syscall_count`, `call_instr_count`, `mem_instr_count`。
- poly 的 **前五**：`total_instr_count`, `mem_instr_count`, `max_loop_depth`, `br_instr_count`, `basic_block_count`。
- **交集**：`mem_instr_count`（符号相反：micro 为正、poly 为负）。

**解读**：**不能**把两套基准合并成一条「mem_instr_count 越大越慢/越快」的规律；应理解为 **suite 异质**：micro 里 mem 常与 **分配/host 路径** 混在一起，poly 里 mem 更接近 **规则数值访存**，与 Native 向量化等优化的交互不同。后续若做联合建模，应 **显式引入 suite 指示变量或分模型**。

---

## 6. L1 load miss rate 差与 IPC 差（补充桥梁）

### 6.1 `delta_l1_load_miss_rate_jit` — |ρ| 最高特征（摘录）

**Micro**：`max_loop_depth`（-0.43）、`io_density` / `syscall_density`（正）、`ls_ratio`（负）等。

**Poly**：`basic_block_count` / `br_instr_count`（约 -0.48）、`max_loop_depth`、`total_instr_count`、`mem_instr_count`（负）等。

**解读**：与 **4.15** 中「用硬件计数器验证访存与缓存行为」一致：poly 上 **CFG / 分支指令体量** 与 **Wasm 相对 Native 的 L1 miss rate 恶化** 在秩上有关联，适合作为 **下一步分层图**（按 `basic_block_count` 分桶看 `delta_l1`）的起点。

### 6.2 `delta_ipc_jit` — |ρ| 最高特征（摘录）

**Micro**：`syscall_count`（-0.34）、`call_instr_count`（-0.29）等——即 **调用/IO 越多**，Wasm 相对 Native 的 IPC **越可能更低**（差距为负表示 Wasm IPC 低于 Native）。

**Poly**：`avg_bb_size`（-0.45）、`br_density`（+0.45）等——存在 **强共线/结构耦合** 可能，解释时宜成对讨论，避免孤立强调单一列。

---

## 7. 小结与建议的后续工作

1. **分 suite 叙述**：micro 突出 **host/调用/分配** 与极端 cycles 尾；poly 突出 **数值 kernel 内** 的温和 slowdown 与 **指令膨胀与 IPC 的补偿关系**。
2. **图表**：散点图 `compute_density`–`cycles_ratio_jit`（micro）、`ls_ratio`–`cycles_ratio_jit`（poly）；或 **partial regression / 控制 suite 后** 再画联合图。
3. **建模**（对齐 4.15 阶段 3）：在各自 suite 内做 **Lasso / 带 suite 交互项的 GLM**，或对 rank 数据用 **稳健方法**；避免把 64 点混在一个黑盒模型里不加分层。
4. **输入规模**：若结论要推广到「哪类代码绝对不适合 Wasm」，需按总结中引用的思路 **扫输入规模**，避免只在单点规模上读静态密度。

---

*生成说明：文中数值表由 `static_runtime_joint.csv` 与 `static_runtime_correlations.csv` 在 2026-04-16 用仓库内脚本逻辑复算摘要得到；若数据文件更新，请重新运行 `scripts/join_static_and_perf_runtime.py` 后酌情更新本报告。*
