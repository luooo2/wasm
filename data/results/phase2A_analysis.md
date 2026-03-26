# Phase 2A 初步结果分析

  

- [x] 微基准扩充到 34 个样本

- [x] 完成 34 样本 × 30 次测量

- [x] 对 4 个 failed 样本修复后重跑并合并回主结果

  

## 1. 当前标签分布

  

基于合并后的 `data/results/labels_34_30.csv`：

  

- `native-better`: 26

- `wasm-better`: 3

- `similar`: 5

- `run-failed`: 0

  

说明目前 34 个样本已经全部获得有效标签，可以继续进入下一步特征合并与 focused rerun。

  

## 2. 总体观察

  

### 2.1 主体结论仍然是 native-better

大多数样本仍然表现为 `native-better`，尤其集中在：

  

- allocation 类

- 大多数 memory 类

- 多数 branch / call 类

- 大多数 host 调用类

  

这说明 wasm 在结构性开销上仍然明显存在劣势，特别是：

  

- 分配与释放

- 高密度访存

- 复杂调用链

- 宿主调用 / WASI 边界切换

  

### 2.2 pure compute 更容易接近 similar

当前 `similar` 的 5 个样本为：

  

- `compute_fp_muladd`  ratio = 1.089899

- `compute_int_add`    ratio = 0.982413

- `compute_int_divmod` ratio = 1.002685

- `compute_int_mul`    ratio = 1.008223

- `memory_stride_write` ratio = 1.014826

  

这些样本普遍说明：

  

- 纯计算密集型任务中，wasm 可以非常接近 native

- 某些规则化内存写模式（如 `memory_stride_write`）也接近 native

  

这与前一阶段观察一致：计算越集中、宿主交互越少、控制流越稳定，wasm 越容易逼近 native。

  

### 2.3 wasm-better 的样本仍值得单独关注

当前 `wasm-better` 共 3 个：

  

- `branch_switch_dense` ratio = 0.878786

- `branch_switch_sparse` ratio = 0.742882

- `host_getcwd_loop` ratio = 0.164882

  

初步解释：

  

- `branch_switch_dense` / `branch_switch_sparse` 说明在特定 switch 分发模式下，wasm JIT/AOT 可能生成了对本机更有利的执行路径

- `host_getcwd_loop` 继续显著优于 native，说明该类调用很可能存在运行时缓存、宿主实现差异或测量路径偏差，需要后续单独复核

  

## 3. 4 个 failed 样本修复后的结果

  

修复对象：

  

- `host_open_close_loop`

- `host_read_small`

- `host_stat_loop`

- `host_write_small`

  

修复动作：

  

1. 给 `run_benchmarks.py` 的 wasmtime 增加目录权限：`--dir=.`

2. 将 `host_write_small.c` 的 `N` 继续下调到 5000

3. 重编译后仅重跑这 4 个样本

  

修复后结果：

  

- `host_open_close_loop` → `native-better`，ratio = 1.220674

- `host_read_small` → `native-better`，ratio = 1.195911

- `host_stat_loop` → `native-better`，ratio = 2.103992

- `host_write_small` → `native-better`，ratio = 1.101231

  

说明前面的 `run-failed` 主要来自：

  

- wasm 文件系统访问权限不足

- `host_write_small` 工作量过大导致 native 超时

  

这些问题已经被消除。

  

## 4. focused rerun 候选（近阈值样本）

  

按照近阈值区间 `0.9 <= ratio <= 1.1`，当前候选为：

  

- `compute_fp_muladd`

- `compute_int_add`

- `compute_int_divmod`

- `compute_int_mul`

- `memory_stride_write`

  

这 5 个样本最适合进入下一步 100~200 次 focused rerun，用于提升边界样本标签稳定性。

  

# Phase 2A 结果分析（34 样本）

  

- [x] 微基准扩充到 34 个样本

- [x] 完成 34 样本 × 30 次首轮测量

- [x] 修复 4 个 failed 样本并重跑

- [x] 对 5 个近阈值样本完成 200 次 focused rerun

- [x] 提取 `features_34.csv`

- [x] 合并生成 `dataset_labeled_34.csv`

  

## 1. 最终标签分布

  

以 `data/results/labels_34_final.csv` 为准：

  

- `native-better`: 27

- `wasm-better`: 3

- `similar`: 4

- `run-failed`: 0

  

说明本轮 34 个样本都已经拿到了稳定可用的标签，没有失败样本残留。

  

## 2. Focused rerun 结果

  

首轮 30 次结果中，近阈值样本为：

  

- `compute_fp_muladd`

- `compute_int_add`

- `compute_int_divmod`

- `compute_int_mul`

- `memory_stride_write`

  

对这 5 个样本进行了 200 次重测后，标签稳定性如下：

  

- `compute_fp_muladd`: `similar (1.089899)` → `native-better (1.106268)`

- `compute_int_add`: `similar (0.982413)` → `similar (0.989963)`

- `compute_int_divmod`: `similar (1.002685)` → `similar (1.005245)`

- `compute_int_mul`: `similar (1.008223)` → `similar (1.021472)`

- `memory_stride_write`: `similar (1.014826)` → `similar (1.022565)`

  

### 结论

  

- 5 个近阈值样本里，4 个在 200 次重测后仍保持 `similar`

- 只有 `compute_fp_muladd` 从边界附近跨过阈值，转为 `native-better`

  

这说明：

  

- 当前阈值定义下，`compute_fp_muladd` 属于“边界型偏 native”样本

- 另外 4 个样本标签相对稳定，可以视为更可靠的 `similar` 样本

  

## 3. 总体性能观察

  

### 3.1 大多数样本仍为 native-better

主流趋势没有变化，`native-better` 仍占绝大多数，主要集中在：

  

- allocation 类

- 大多数 memory 类

- 多数 branch / call 类

- 大多数 host 调用类

  

这说明 wasm 在如下结构性维度上仍存在明显额外开销：

  

- 内存分配与释放

- 高频访存

- 调用链与间接调用

- 宿主调用 / WASI 边界切换

  

### 3.2 wasm-better 样本仍较少，但有研究价值

最终 `wasm-better` 的 3 个样本为：

  

- `branch_switch_dense` ratio = 0.878786

- `branch_switch_sparse` ratio = 0.742882

- `host_getcwd_loop` ratio = 0.164882

  

说明：

  

- 某些 switch / 分发结构对 wasm 代码生成较友好

- `host_getcwd_loop` 仍显著 wasm 更优，值得后续单独验证其是否受缓存、宿主实现差异、运行时路径优化等因素影响

  

## 4. 特征区分度初步观察

  

按最终标签分组，对 `features_34.csv` 做简单均值对比：

  

### native-better（27 个）

- `compute_density`: 0.266394

- `memory_access_density`: 0.079421

- `branch_density`: 0.086944

- `call_density`: 0.013136

- `hostcall_count`: 1.592593

- `alloc_call_count`: 1.037037

  

### similar（4 个）

- `compute_density`: 0.454115

- `memory_access_density`: 0.064602

- `branch_density`: 0.060576

- `call_density`: 0.0

- `hostcall_count`: 1.0

- `alloc_call_count`: 0.5

  

### wasm-better（3 个）

- `compute_density`: 0.231032

- `memory_access_density`: 0.056266

- `branch_density`: 0.136402

- `call_density`: 0.039216

- `hostcall_count`: 1.333333

- `alloc_call_count`: 0.0

  

### 初步解释

  

1. `similar` 组的 `compute_density` 明显更高，说明高计算密度、低宿主依赖的程序更容易接近 native。

2. `similar` 组的 `branch_density`、`memory_access_density`、`call_density` 相对更低，说明控制流越简单、调用越少，wasm 越容易稳定接近 native。

3. `native-better` 组的 `hostcall_count` 和 `alloc_call_count` 偏高，支持“宿主交互 / 分配行为更容易放大 wasm 开销”的判断。

4. `wasm-better` 组的 `branch_density` 与 `call_density` 反而偏高，说明某些特定控制流模式可能是 wasm 的优势区间，但当前样本数仍偏少，不能过度推广。

  

## 5. 结果文件

  

本轮关键输出文件：

  

- 首轮结果：`data/results/labels_34_30.csv`

- failed 修复重跑：`data/results/labels_failed4_rerun.csv`

- focused rerun：`data/results/labels_focus_34_200.csv`

- 最终标签：`data/results/labels_34_final.csv`

- 特征表：`data/results/features_34.csv`

- 合并数据集：`data/results/dataset_labeled_34.csv`

