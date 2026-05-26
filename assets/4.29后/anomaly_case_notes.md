# 异常样本个案说明（结论加固用）

## 分层 Spearman 的说明

对同一批程序，`wasm-jit` 与 `wasm-aot` 在 `stratified_spearman.csv` 中 Spearman 数值完全一致，是因为每个程序在两种模式下的 `ratio_instructions_retired_over_native` **排序一致**（单调相关）；并非脚本错误。分层回归系数仍会随模式不同而变化（见 `stratified_regression_coefficients.csv`）。

以下程序在 `anomaly_report.csv` 中多次出现，或比值极端；写作论文时建议**单独讨论**或归入「微基准 / 扩展集」，避免与常规 kernel 混为一谈。

## llvmss_shootout_hello（Shootout/hello.c）

- **为何极端**：IR 极小（约 2 条指令量级），native 侧 retired 事件与周期数本身就很低；Wasm 仍要付运行时与线性内存等固定成本，导致 `ratio_*` 分母过小、比值被放大到 10～20 倍量级。
- **建议**：归入**非代表性微基准**，主结论中可脚注说明；或从主回归剔除，仅在「固定开销敏感性」小节展示。

## llvmss_misc_flops-4 / flops-7 / flops-8（Misc/flops-*.c）

- **为何极端**：`ratio_all_loads_retired_over_native` 或 `ratio_all_stores_retired_over_native` 可达数百倍；程序体小、大量浮点循环 + 频繁 `printf` 类宿主调用，Wasm 路径下 load/store 与宿主交互被显著放大，而 native 基线事件数相对较小。
- **建议**：归入**扩展集**或按 `adaptation_level=minimal` 标注；分析 hostcall / IO 效应时保留，做「全样本 vs 剔除微基准」对照表。

## llvmss_misc_mandel-2（Misc/mandel-2.c）

- **为何极端**：与 flops 类似，`all_loads` / `all_stores` 比值约 250+；计算核小、边界检查与访存展开在 Wasm 侧占主导，perf 比值对「静态 IR 规模」极不敏感。
- **建议**：与 flops 同类处理；若讨论「访存放大」可保留为 case study。

## llvmss_stanford_intmm / realmm / floatmm（Stanford 矩阵类）

- **为何极端**：`ratio_all_stores_retired` 或 `ratio_L1_icache_load_misses` 偏高；矩阵访存密集，Wasm 线性内存与代码布局使 icache / store 事件相对 native 抬升明显，属于**结构真实差异**而非纯噪声。
- **建议**：**保留在主样本**，但在文中说明「数值核 + 密集访存」子类。

## llvmss_stanford_oscar / queens / perm / bubblesort / towers 等

- **为何极端**：多出现在 `ratio_L1_icache_load_misses_over_native` 高分位；控制流与代码体积与 Wasm 运行时组合易导致 I-cache 行为与 native 差异大。
- **建议**：保留为主样本；与 `avg_bb_size`、分支类特征联动解读。

## llvmss_misc_salsa20

- **为何极端**：`ratio_branch_misses_over_native` 极高（约 25～26）；密码学式密集位运算与分支模式使分支预测差异被放大。
- **建议**：保留为 **branch-miss 敏感** 代表；讨论分支相关结论时单独点出。

---

**汇总**：`hello` 与部分极小 `flops`/`mandel` 更宜视为**比值失真型微基准**；Stanford 矩阵与 salsa20 更宜视为**真实结构差异型**极端值。后续鲁棒回归与 winsorize 主要削弱前一类对全局斜率的影响。
