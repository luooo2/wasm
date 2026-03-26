# V1 结果分析

## Phase 1

- [x] Phase1 补强测量可靠性

  


**数据分析结果**：

  

1. 大多数样本是 native-better

2. 纯计算类更接近 similar

3. `memory_stride_write` 也接近 similar

4. `host_getcwd_loop` 出现了 `wasm-better`

  

> 说明计算密集型任务 wasm的优化做的比较好可以接近 native

> 同时，在某些规则化访存模式下，wasm也能接近native

> 甚至，在host_getcwd_loop中wasm能超越wasm（原因可能是wasm会缓存第一次getcwd的结果进行优化）

> 而大多数情况下wasm性能都劣于native，可能来自一些结构性消耗（结构敏感特征）

>

> - wasi系统调用固定消耗

> - 频繁内存分配（wasm内存管理优化不足）

> - 函数调用（wasm函数调用要先查询函数表等消耗）

> - 分支结构（边界检查消耗）


## Phase 2A


- [x] 微基准扩充到 34 个样本

- [x] 完成 34 样本 × 30 次首轮测量

- [x] 修复 4 个 failed 样本并重跑

- [x] 对 5 个近阈值样本完成 200 次 focused rerun

- [x] 提取 `features_34.csv`

- [x] 合并生成 `dataset_labeled_34.csv`

  

**数据分析结果**：
1. 大多数样本仍为 native-better
> 主流趋势没有变化，`native-better` 仍占绝大多数，主要集中在：
>- allocation 类
>- 大多数 memory 类
>- 多数 branch / call 类
>- 大多数 host 调用类
这说明 wasm 在如下结构性维度上仍存在明显额外开销：
>- 内存分配与释放
>- 高频访存
>- 调用链与间接调用
>- 宿主调用 / WASI 边界切换

2. wasm-better 样本仍较少，但有研究价值
>最终 `wasm-better` 的 3 个样本为：
>- `branch_switch_dense` ratio = 0.878786
>- `branch_switch_sparse` ratio = 0.742882
>- `host_getcwd_loop` ratio = 0.164882
说明：
>- 某些 switch / 分发结构对 wasm 代码生成较友好
>- `host_getcwd_loop` 仍显著 wasm 更优，值得后续单独验证其是否受缓存、宿主实现差异、运行时路径优化等因素影响

3. 特征区分度初步观察
按最终标签分组，对 `features_34.csv` 做简单均值对比：
native-better（27 个）

- `compute_density`: 0.266394

- `memory_access_density`: 0.079421

- `branch_density`: 0.086944

- `call_density`: 0.013136

- `hostcall_count`: 1.592593

- `alloc_call_count`: 1.037037

  

similar（4 个）

- `compute_density`: 0.454115

- `memory_access_density`: 0.064602

- `branch_density`: 0.060576

- `call_density`: 0.0

- `hostcall_count`: 1.0

- `alloc_call_count`: 0.5

  

wasm-better（3 个）

- `compute_density`: 0.231032

- `memory_access_density`: 0.056266

- `branch_density`: 0.136402

- `call_density`: 0.039216

- `hostcall_count`: 1.333333

- `alloc_call_count`: 0.0


初步解释

  

1. `similar` 组的 `compute_density` 明显更高，说明高计算密度、低宿主依赖的程序更容易接近 native。

2. `similar` 组的 `branch_density`、`memory_access_density`、`call_density` 相对更低，说明控制流越简单、调用越少，wasm 越容易稳定接近 native。

3. `native-better` 组的 `hostcall_count` 和 `alloc_call_count` 偏高，支持“宿主交互 / 分配行为更容易放大 wasm 开销”的判断。

4. `wasm-better` 组的 `branch_density` 与 `call_density` 反而偏高，说明某些特定控制流模式可能是 wasm 的优势区间，但当前样本数仍偏少，不能过度推广。

  

**结果文件**:

本轮关键输出文件：

- 首轮结果：`data/results/labels_34_30.csv`

- failed 修复重跑：`data/results/labels_failed4_rerun.csv`

- focused rerun：`data/results/labels_focus_34_200.csv`

- 最终标签：`data/results/labels_34_final.csv`

- 特征表：`data/results/features_34.csv`

- 合并数据集：`data/results/dataset_labeled_34.csv`
