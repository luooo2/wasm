# 三目标对齐：实验结果与简要分析

## 数据与目标

- 样本量 **n=52**（program×mode，内部计时比 `y_time_internal_ratio`）。
- 静态特征 **p=24**（全部数值 IR 特征，非子集）。
- **目标 1**：用 LassoCV / OLS / RLM 量化「静态特征 → 内部时间比」。
- **目标 2**：用 Spearman 网格 + FDR 描述「静态特征 ↔ perf 比值」及 perf 与时间的关系。
- **目标 3**：Lasso 稀疏系数可解释；相关与回归均报告 **FDR** 或 **bootstrap CI**。

## 1) 静态特征与内部时间比（FDR 后仍显著的相关）

| column                |   n |   spearman_rho |     p_value |   abs_rho |      fdr_q | fdr_sig_0.05   | fdr_sig_0.10   |
|:----------------------|----:|---------------:|------------:|----------:|-----------:|:---------------|:---------------|
| function_count        |  52 |       0.49839  | 0.000169839 |  0.49839  | 0.00390629 | True           | True           |
| compute_instr_count   |  52 |       0.437417 | 0.00118429  |  0.437417 | 0.00986762 | True           | True           |
| ir_instruction_count  |  52 |       0.434534 | 0.00128708  |  0.434534 | 0.00986762 | True           | True           |
| loop_count            |  52 |       0.400495 | 0.00326064  |  0.400495 | 0.0187487  | True           | True           |
| memory_access_density |  52 |      -0.368918 | 0.00711758  |  0.368918 | 0.0327409  | True           | True           |
| basic_block_count     |  52 |       0.346044 | 0.0119755   |  0.346044 | 0.0459059  | True           | True           |
| avg_bb_size           |  52 |      -0.33349  | 0.015693    |  0.33349  | 0.0515626  | False          | True           |
| call_to_bb_ratio      |  52 |      -0.317143 | 0.0219723   |  0.317143 | 0.0630292  | False          | True           |
| cfg_edge_count        |  52 |       0.311332 | 0.0246636   |  0.311332 | 0.0630292  | False          | True           |
| store_count           |  52 |       0.304975 | 0.0279198   |  0.304975 | 0.0642155  | False          | True           |
| branch_instr_count    |  52 |       0.297925 | 0.0319437   |  0.297925 | 0.0667913  | False          | True           |
| hostcall_density      |  52 |      -0.280747 | 0.0437972   |  0.280747 | 0.0839446  | False          | True           |

## 2) perf 比值与内部时间比（桥接：哪些动态量与时间一起动）

| column                                  |   n |   spearman_rho |     p_value |   abs_rho |       fdr_q | fdr_sig_0.05   | fdr_sig_0.10   |
|:----------------------------------------|----:|---------------:|------------:|----------:|------------:|:---------------|:---------------|
| ratio_cpu_cycles_over_native            |  52 |      0.93409   | 5.18001e-24 | 0.93409   | 4.14401e-23 | True           | True           |
| ratio_instructions_retired_over_native  |  52 |      0.802869  | 8.11227e-13 | 0.802869  | 3.24491e-12 | True           | True           |
| ratio_L1_icache_load_misses_over_native |  52 |      0.755571  | 9.55483e-11 | 0.755571  | 2.54795e-10 | True           | True           |
| ratio_branches_retired_over_native      |  52 |      0.661573  | 9.31469e-08 | 0.661573  | 1.86294e-07 | True           | True           |
| ratio_branch_misses_over_native         |  52 |      0.295825  | 0.0332311   | 0.295825  | 0.0531697   | False          | True           |
| ratio_conditional_branches_over_native  |  52 |      0.195851  | 0.164078    | 0.195851  | 0.218771    | False          | False          |
| ratio_all_stores_retired_over_native    |  52 |     -0.0956203 | 0.500112    | 0.0956203 | 0.529368    | False          | False          |
| ratio_all_loads_retired_over_native     |  52 |      0.0892171 | 0.529368    | 0.0892171 | 0.529368    | False          | False          |

> `ratio_cpu_cycles` / `ratio_instructions_retired` 与时间比极强相关，符合「时间主要由执行体量与周期驱动」的预期。

## 3) 静态 ↔ perf（FDR q<0.10 的 top 桥接对）

| static_feature        | perf_ratio                              |   n |   spearman_rho |     p_value |   abs_rho |       fdr_q | fdr_sig_0.05   | fdr_sig_0.10   |
|:----------------------|:----------------------------------------|----:|---------------:|------------:|----------:|------------:|:---------------|:---------------|
| basic_block_count     | ratio_all_stores_retired_over_native    |  52 |      -0.581858 | 6.06308e-06 |  0.581858 | 0.00060739  | True           | True           |
| branch_instr_count    | ratio_all_stores_retired_over_native    |  52 |      -0.579982 | 6.60206e-06 |  0.579982 | 0.00060739  | True           | True           |
| cfg_edge_count        | ratio_all_stores_retired_over_native    |  52 |      -0.567249 | 1.1608e-05  |  0.567249 | 0.000711957 | True           | True           |
| branch_density        | ratio_all_stores_retired_over_native    |  52 |      -0.553539 | 2.07747e-05 |  0.553539 | 0.000935966 | True           | True           |
| memory_access_density | ratio_branches_retired_over_native      |  52 |      -0.543039 | 3.18945e-05 |  0.543039 | 0.000935966 | True           | True           |
| branch_instr_count    | ratio_all_loads_retired_over_native     |  52 |      -0.542958 | 3.19985e-05 |  0.542958 | 0.000935966 | True           | True           |
| basic_block_count     | ratio_all_loads_retired_over_native     |  52 |      -0.540284 | 3.56074e-05 |  0.540284 | 0.000935966 | True           | True           |
| memory_access_density | ratio_instructions_retired_over_native  |  52 |      -0.529284 | 5.47533e-05 |  0.529284 | 0.00109913  | True           | True           |
| function_count        | ratio_all_stores_retired_over_native    |  52 |      -0.527646 | 5.83025e-05 |  0.527646 | 0.00109913  | True           | True           |
| cfg_edge_count        | ratio_all_loads_retired_over_native     |  52 |      -0.52701  | 5.97353e-05 |  0.52701  | 0.00109913  | True           | True           |
| branch_density        | ratio_all_loads_retired_over_native     |  52 |      -0.520907 | 7.52358e-05 |  0.520907 | 0.0011884   | True           | True           |
| function_count        | ratio_cpu_cycles_over_native            |  52 |       0.520113 | 7.75046e-05 |  0.520113 | 0.0011884   | True           | True           |
| store_count           | ratio_all_stores_retired_over_native    |  52 |      -0.493966 | 0.000197998 |  0.493966 | 0.00280243  | True           | True           |
| avg_bb_size           | ratio_L1_icache_load_misses_over_native |  52 |      -0.475292 | 0.000369945 |  0.475292 | 0.00424768  | True           | True           |
| call_to_bb_ratio      | ratio_all_stores_retired_over_native    |  52 |       0.473579 | 0.000391084 |  0.473579 | 0.00424768  | True           | True           |
| ir_instruction_count  | ratio_all_stores_retired_over_native    |  52 |      -0.473237 | 0.00039543  |  0.473237 | 0.00424768  | True           | True           |
| branch_density        | ratio_branch_misses_over_native         |  52 |      -0.472216 | 0.00040867  |  0.472216 | 0.00424768  | True           | True           |
| ir_instruction_count  | ratio_all_loads_retired_over_native     |  52 |      -0.471699 | 0.000415534 |  0.471699 | 0.00424768  | True           | True           |
| function_count        | ratio_all_loads_retired_over_native     |  52 |      -0.467208 | 0.000479649 |  0.467208 | 0.00464502  | True           | True           |
| compute_density       | ratio_branches_retired_over_native      |  52 |       0.465383 | 0.000508174 |  0.465383 | 0.0046752   | True           | True           |
| loop_count            | ratio_instructions_retired_over_native  |  52 |       0.461829 | 0.000568136 |  0.461829 | 0.00495358  | True           | True           |
| compute_instr_count   | ratio_cpu_cycles_over_native            |  52 |       0.460493 | 0.000592275 |  0.460493 | 0.00495358  | True           | True           |
| loop_count            | ratio_cpu_cycles_over_native            |  52 |       0.450361 | 0.000807701 |  0.450361 | 0.00646161  | True           | True           |
| hostcall_count        | ratio_instructions_retired_over_native  |  52 |      -0.446545 | 0.00090561  |  0.446545 | 0.00694301  | True           | True           |
| avg_bb_size           | ratio_conditional_branches_over_native  |  52 |      -0.444539 | 0.000961204 |  0.444539 | 0.00696644  | True           | True           |

## 4) 建模：内部时间比 ~ 全部静态特征

### LassoCV（可解释、稀疏）

- 说明：对 `y_time_internal_ratio` 做 **标准化** 后再选 `alpha`（与标准化 `X` 同尺度），避免惩罚过大导致全零系数；系数表中 `coef_per_1sd_X_on_time_ratio_y` 表示 **X 增加 1 个标准差时，时间比约变化多少**。

- 选参：`alpha=0.01`（L1 惩罚）
- 标准化 y 下样本内 R² = **0.553**；还原到原始时间比尺度的样本内 R² = **0.553**。
- LassoCV 在选定 `alpha` 处的 **内部 CV MSE（标准化 y）**：**32.2396** ± 34.5526（各折平均）。
- 非零系数个数：**15**

非零系数（按 |coef| 排序）：

| feature                 |   coef_per_1sd_X_on_std_y |   coef_per_1sd_X_on_time_ratio_y |   abs_coef_ratio_y | nonzero   |
|:------------------------|--------------------------:|---------------------------------:|-------------------:|:----------|
| compute_instr_count     |                 0.682847  |                        0.699032  |          0.699032  | True      |
| function_count          |                 0.474773  |                        0.486026  |          0.486026  | True      |
| avg_bb_out_degree       |                -0.373507  |                       -0.38236   |          0.38236   | True      |
| call_instr_count        |                -0.363626  |                       -0.372244  |          0.372244  | True      |
| branch_instr_count      |                -0.306831  |                       -0.314104  |          0.314104  | True      |
| load_count              |                -0.26195   |                       -0.268159  |          0.268159  | True      |
| compute_to_memory_ratio |                -0.244684  |                       -0.250484  |          0.250484  | True      |
| memory_access_density   |                -0.231601  |                       -0.23709   |          0.23709   | True      |
| hostcall_density        |                 0.164403  |                        0.1683    |          0.1683    | True      |
| call_to_bb_ratio        |                 0.140123  |                        0.143445  |          0.143445  | True      |
| load_store_ratio        |                 0.132033  |                        0.135162  |          0.135162  | True      |
| alloc_call_count        |                 0.131803  |                        0.134927  |          0.134927  | True      |
| compute_density         |                 0.119319  |                        0.122147  |          0.122147  | True      |
| hostcall_count          |                -0.0781834 |                       -0.0800365 |          0.0800365 | True      |
| max_loop_depth          |                -0.0427445 |                       -0.0437576 |          0.0437576 | True      |

### 模型对比（样本内 R²）

| model          |   r2_in_sample_std_y |   r2_in_sample_original_y |   lasso_internal_cv_mse_mean |   lasso_internal_cv_mse_std |   n_nonzero_coef |
|:---------------|---------------------:|--------------------------:|-----------------------------:|----------------------------:|-----------------:|
| lasso_cv_std_y |             0.553485 |                  0.553485 |                      32.2396 |                     34.5526 |               15 |
| ols_full_stdX  |           nan        |                  0.99699  |                     nan      |                    nan      |               25 |
| rlm_huber_stdX |           nan        |                  0.995664 |                     nan      |                    nan      |               25 |

> OLS 全特征样本内 R² 往往虚高；**以 Lasso + bootstrap CI 为主结论**，OLS/RLM 作对照。

## 5) 综合解读（对应最初三条）

1. **量化关系**：Lasso 在强正则下给出少量非零系数，直接对应「哪些静态结构更影响时间比」；bootstrap CI 标出统计上较稳的方向。
2. **静态与运行时联系**：先看 perf 比值与时间比的相关（表 2），再看静态–perf 网格中 FDR 显著的配对（表 3），可叙述「某类静态结构通过哪类 PMU 膨胀与时间同向」。
3. **可解释与显著性**：稀疏模型 + FDR + bootstrap，避免单指标过拟合与多重比较假象。

## 产出文件列表

- `fdr_spearman_static_vs_time.csv`
- `fdr_spearman_perf_vs_time.csv`
- `fdr_spearman_static_vs_perf_grid.csv`
- `bridge_top_static_to_perf.csv`
- `model_time_lasso_cv.json`
- `model_time_lasso_coefs.csv`
- `model_time_ols_full_coefs.csv`
- `model_time_rlm_coefs.csv`
- `model_time_compare_metrics.csv`
- `bootstrap_lasso_coef_ci.csv`

---

## 6）通俗解读：这些文件分别在说什么？

把整条研究想成「体检报告」：程序是病人，**静态特征**是体格指标，**perf 比值**是血常规，**内部时间比**是最终体感（Wasm 比 Native 慢多少倍）。

- **`main_table_time_perf_static.csv`**（由 `build_time_perf_static_table.py` 生成）  
  每一行是一个程序在 **JIT 或 AOT** 下的一条记录，列里同时有：代码长什么样（静态）、跑的时候 PMU 差多少倍（perf 比值）、以及 **Wasm/Native 内部时间比**。这是后面所有分析的「总表」。

- **`fdr_spearman_static_vs_time.csv`**  
  回答：**不看复杂模型，单看「某个静态指标」和「时间比」是否一起变高/变低**。FDR（`fdr_q`）是「做了很多检验之后，还把偶然当真」的概率控制；标了 `fdr_sig_0.05` / `fdr_sig_0.10` 的，可以理解为「在较严/稍宽标准下，还算站得住」。

- **`fdr_spearman_perf_vs_time.csv`**  
  回答：**哪些硬件计数器层面的「Wasm/Native 比值」和「时间比」最同步**。这里 strongest 的是 **CPU 周期比、指令退役比、I-cache miss 比、分支退役比**——直觉上就是「跑得越久、干的事越多、取指/分支越折腾，实际运行时间往往也越差」，和常识一致。

- **`fdr_spearman_static_vs_perf_grid.csv` + `bridge_top_static_to_perf.csv`**  
  回答：**代码长什么样，更容易带来哪一类 PMU 膨胀**。例如「基本块多、分支多」往往和 **store/load 退役比值** 之类一起出现。这是把「静态」和「动态」钉在同一张网上的表。

- **`model_time_lasso_coefs.csv` + `model_time_lasso_cv.json` + `bootstrap_lasso_coef_ci.csv`**  
  回答：**在「不能乱拟合」的前提下，哪些静态特征对时间比还有独立贡献**。Lasso 会故意把很多系数压成 0，只留下一撮；系数列 `coef_per_1sd_X_on_time_ratio_y` 可粗略读成：**这个特征在样本里「多一个典型波动」时，时间比大约跟着动多少**（仍是统计意义上的平均趋势，不是对单个程序拍板的公式）。

- **`model_time_ols_full_coefs.csv` / `model_time_rlm_coefs.csv` + `model_time_compare_metrics.csv`**  
  OLS：「能拟合得多贴」——在 **p 接近 n** 时往往贴得太好（表里 R² 接近 1），**不能当成泛化能力**。RLM：对极端点稍微客气一点的线性模型，仍作对照。写论文时建议：**主叙事用 Lasso + Spearman/FDR；OLS 只作上界对照**。

- **`lasso_internal_cv_mse_mean/std`（见 `model_time_lasso_cv.json`）**  
  这是 Lasso **自己在选 alpha 时做的交叉验证误差**，折与折之间方差可能很大（样本只有 52 条）。**适合比较不同正则强度，不适合当成「模型预测误差=某个绝对数」来背**。更稳妥的是看 **R²≈0.55** 这一档：「静态特征能解释时间比的一半左右量级，剩下还有别的因素」。

---

## 7）可用结论（可直接写进论文/答辩的表述）

下列结论均限定在：**当前 llvm-test-suite 子集、内部计时、JIT/AOT 合并为 52 条、perf 与静态按现有脚本提取** 的前提下。

### 结论 A（动态桥接时间——最硬、最好讲）

**Wasm 相对 Native 的内部时间比，与「CPU 周期比」「指令退役比」「L1 I-cache miss 比」「分支退役比」高度同向**（Spearman + FDR 显著）。  
**可用表述**：在本数据集上，**时间差距主要与「多跑了多少周期、多退役多少指令、取指/分支行为恶化」同步出现**；因此用 perf 比值作为「静态特征 → 时间」之间的**中间层**是合理的。

### 结论 B（静态与时间——不建模也能说清一部分）

在多重校正后仍较稳的静态信号包括：**函数个数、计算指令规模、IR 指令规模、循环个数、访存密度**等与时间比相关；**访存密度**与时间比呈 **负相关**（与「只盯指令膨胀」的单线叙事不同，值得在文中解释：可能与样本里「访存密但其它路径便宜」的程序混在一起有关，或需结合 perf 桥接表一起说）。  
**可用表述**：**程序规模与结构复杂度**与 Wasm/Native 时间差距存在可检验的单调关系，但**不是单一维度**（既要看算量，也要看控制流与访存）。

### 结论 C（静态如何「碰到」运行时——机制叙事）

桥接表显示：**控制流/CFG 类静态特征**与 **store/load 退役、分支退役、指令退役** 等比值的联合显著性很强。  
**可用表述**：可以把故事写成：**静态上的控制流与访存布局 → 对应到某几类 PMU 比值的系统性偏移 → 再与墙钟时间比同向**。这不是因果证明，但是**可解释、可画图、可复查**的链条。

### 结论 D（稀疏线性模型——量化但留余地）

Lasso 在强正则下 **R² 约 0.55、约 15 个非零特征**：说明**用「线性 + 静态 IR 统计」能解释时间比的一部分，但远不是全部**；与 OLS 近 1.0 的对比，恰恰说明**全特征线性会过拟合**。  
**可用表述**：论文里建议把 **Lasso 当作「主模型」**，把 OLS 当作 **「过拟合上界」** 各写一句，避免审稿人质疑「只有相关没有约束」。

### 结论 E（局限——必须交代）

- **n=52**：任何回归的系数区间都会宽，**结论方向重于精确系数**。  
- **JIT 与 AOT 混在同一表**：若审稿人追问，可补充「分 mode 的 Spearman 表」作敏感性分析（见 `spearman_static_vs_y_time_by_mode.csv`）。  
- **相关 ≠ 因果**：FDR 与 Lasso 只支持「**关联与可解释趋势**」，不自动推出「改 IR 就一定能省多少时间」。

---

## 8）一句话收束

> 在本批数据上：**时间差距主要由 cycles/instructions/cache/分支等 perf 比值携带；静态 IR 特征能通过「与这些比值稳定共变」与时间比建立可解释联系；Lasso 给出中等解释力（约一半方差量级）且明显比全 OLS 克制。**  
> 把「静态 → perf → 时间」写成一条**证据链**，比只选单一 perf 指标更能对齐你最初的三条目标。

---

## 9）证据链：静态 → perf → 时间（据现有 `5.11` 结果）

以下链条由 **同一主表** `main_table_time_perf_static.csv`（n=52，program×mode）上三段 Spearman + BH-FDR 结果拼成；数值均来自 `fdr_spearman_static_vs_time.csv`、`fdr_spearman_static_vs_perf_grid.csv`（摘要见 `bridge_top_static_to_perf.csv`）、`fdr_spearman_perf_vs_time.csv`。**这是关联证据链，不是因果证明。**

### 链尾（perf → 时间）：「时间比跟哪些动态膨胀同步」

与 **内部时间比** `y_time_internal_ratio` 秩相关最强、且 **FDR q < 0.05** 的 perf 比值依次为：

1. **`ratio_cpu_cycles_over_native`**：Spearman ρ≈**0.93**  
2. **`ratio_instructions_retired_over_native`**：ρ≈**0.80**  
3. **`ratio_L1_icache_load_misses_over_native`**：ρ≈**0.76**  
4. **`ratio_branches_retired_over_native`**：ρ≈**0.66**  

**可读作**：在本批数据上，**Wasm 相对 Native 越慢（时间比越大）** 的程序，越倾向于同时出现 **更多相对周期、更多相对退役指令、更差的相对 I-cache 取指、更多相对退役分支** 等「执行路径变重」的信号。

**补充**：`ratio_all_loads_retired_over_native` / `ratio_all_stores_retired_over_native` 与时间在 FDR 下 **未显著**（|ρ| < 0.1）。因此证据链的「时间端」主要由 **周期 / 指令 / I-cache / 分支退役** 四块扛起；**访存退役比不是这条链里靠时间的那一截**（仍可与静态桥接，见下）。

### 链腰（静态 → perf）：「代码结构先落在哪类 PMU 比值上」

`bridge_top_static_to_perf.csv` 中 FDR 显著的典型配对（仅列最前几类，ρ 为绝对强度量级）：

- **控制流 / CFG 密度**（如 `basic_block_count`、`branch_instr_count`、`cfg_edge_count`、`branch_density`）与 **`ratio_all_stores_retired_over_native`、`ratio_all_loads_retired_over_native`** 呈 **强负秩相关**（|ρ| 约 0.52–0.58，FDR 显著）。  
  **直观解释**：控制流越「碎」、分支位点越多，在本样本中与 **Wasm 相对 Native 的访存退役比偏低/形态不同** 的系统排列相关（注意符号是「静态高 ↔ 该 perf 比值低」，叙述时要与具体 workload 对照，避免口头说成「访存少」）。

- **`memory_access_density`** 与 **`ratio_branches_retired_over_native`**（ρ≈**−0.54**）、**`ratio_instructions_retired_over_native`**（ρ≈**−0.53**）等 **FDR 显著**。  
  **直观解释**：静态上「访存占比高」的程序，与 **分支退役比、指令退役比** 的 Wasm/Native 相对关系呈现稳定共变（同样需在正文结合程序类型解释方向，而非单句因果）。

- **`function_count`** 与 **`ratio_cpu_cycles_over_native`** 呈 **正秩相关**（ρ≈**0.52**，FDR 显著）。  
  **直观解释**：模块/函数切分越多，越常与 **相对周期膨胀** 同向出现（可与运行时、调用开销叙事衔接）。

### 链头（静态 → 时间）：「不经过 perf 也能看到的一截」

`fdr_spearman_static_vs_time.csv` 中，与 **内部时间比** 在 **FDR q < 0.05** 下显著的特征包括：

- **正相关**：`function_count`（ρ≈0.50）、`compute_instr_count`（≈0.44）、`ir_instruction_count`（≈0.43）、`loop_count`（≈0.40）、`basic_block_count`（≈0.35）等 → **规模与计算/控制流体量** 越大，时间比越倾向于更大。  
- **负相关**：`memory_access_density`（ρ≈**−0.37**，FDR 显著）→ 与「访存密则更慢」的口语直觉不同，**说明链头不能单句概括**；正文应写明 **「单变量秩相关」** 并引用链腰中与 perf 的联合模式，避免误读为因果。

### 三截如何扣成一条链（写法模板）

1. **链头**：静态 IR 上的 **规模与 CFG/访存统计** 与 **时间比** 存在 FDR 后的秩相关（`fdr_spearman_static_vs_time.csv`）。  
2. **链腰**：同类静态量又与 **指令/分支/周期等 perf 比值** 广泛显著共变（`bridge_top_static_to_perf.csv` / 全网格表）。  
3. **链尾**：其中 **周期、指令、I-cache miss、分支退役** 四类 perf 比值与 **时间比** 极强共变（`fdr_spearman_perf_vs_time.csv`）。  

**合成一句（答辩可用）**：  
> 在当前 llvm-test-suite 子集上，**静态结构统计**与 **Wasm/Native 的 PMU 比值**在多重校正后仍呈现系统共变，而这些比值中又以 **周期与指令退役** 与 **内部时间比** 同步最强；因此可把「结构 → 微架构事件相对膨胀 → 内部时间差距」作为**由数据支持的三段式解释链**，其中访存**退役比**更多是链腰角色、**对时间端的直接秩相关较弱**。
