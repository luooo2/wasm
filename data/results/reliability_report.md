# 可靠性报告

## 1. 报告目的

本报告用于评估在补强测量流程之后，当前 Wasm 与 Native 性能标签的可靠性。核心目标包括：

1. 将每个程序的重复运行次数由 5 次提高到 30 次；
2. 记录逐次原始运行时间以及汇总统计量；
3. 对接近阈值的程序以及异常样本 `host_getcwd_loop` 做高重复复核；
4. 判断当前标签是否足够稳定，从而支持后续特征分析与建模。

---

## 2. 测量配置

### 2.1 全量 benchmark 运行

对应文件：`data/results/labels_30.csv`

配置如下：

- 重复次数：30
- 预热次数：2
- 超时：180 秒
- 标签阈值：0.10
- 计时方式：`src/run_benchmarks.py` 中的外部端到端计时
- 原始逐次记录：`data/results/labels_raw_30.csv`

### 2.2 focused reliability rerun

对应文件：`data/results/labels_focus_200.csv`

配置如下：

- 重复次数：200
- 预热次数：5
- 超时：180 秒
- 标签阈值：0.10
- 复核程序：
  - `compute_fp_mix`
  - `compute_int_add`
  - `memory_stride_write`
  - `host_getcwd_loop`
- 原始逐次记录：`data/results/labels_raw_focus_200.csv`

选择这 4 个程序的原因是：

- 前三个接近标签判定阈值，属于标签敏感样本；
- `host_getcwd_loop` 是当前最明显的异常样本，表现为 Wasm 显著优于 Native。

---

## 3. 30 次全量运行结果概览

根据 `labels_30.csv`，当前标签分布为：

- `native-better`：9 个
- `similar`：2 个
- `wasm-better`：1 个

### 3.1 明显稳定的 native-better 样本

以下程序的 ratio 明显大于 1.10，当前可视为较稳定的 `native-better`：

- `alloc_bulk_buffer`：1.212336
- `alloc_small_objects`：2.147771
- `branch_predictable`：1.187749
- `branch_unpredictable`：1.857580
- `call_chain`：1.380451
- `call_indirect`：1.804774
- `host_time_loop`：6.351105
- `memory_seq_read`：1.444696

这些样本距离阈值较远，目前没有表现出明显的标签脆弱性。

### 3.2 接近阈值或需要重点关注的样本

以下程序需要额外关注：

- `compute_fp_mix`：ratio = 1.132133，标签 = `native-better`
- `compute_int_add`：ratio = 0.974259，标签 = `similar`
- `memory_stride_write`：ratio = 1.000837，标签 = `similar`
- `host_getcwd_loop`：ratio = 0.046925，标签 = `wasm-better`

其中：

- `compute_fp_mix` 仅略高于 1.10 的阈值；
- `compute_int_add` 与 `memory_stride_write` 都非常接近 1.00；
- `host_getcwd_loop` 则是一个明显异常值，需要专门解释。

---

## 4. 200 次 focused 复核结果

### 4.1 30 次与 200 次结果对比


| 程序                    | 30 次 ratio | 30 次标签        | 200 次 ratio | 200 次标签     | 可靠性判断  |
| --------------------- | ---------- | ------------- | ----------- | ----------- | ------ |
| `compute_fp_mix`      | 1.132133   | native-better | 1.082297    | similar     | 标签发生变化 |
| `compute_int_add`     | 0.974259   | similar       | 0.968412    | similar     | 标签稳定   |
| `memory_stride_write` | 1.000837   | similar       | 0.993174    | similar     | 标签稳定   |
| `host_getcwd_loop`    | 0.046925   | wasm-better   | 0.057949    | wasm-better | 异常但稳定  |


### 4.2 结果解释

#### `compute_fp_mix`

这是本轮可靠性分析中最重要的发现。该程序在 30 次运行下被标记为 `native-better`，但在 200 次复核后变为 `similar`。

这说明：

- 原始标签并不够稳健；
- 接近阈值的程序对重复次数较为敏感；
- 对边界样本不能只依赖一次中等重复数的结果。

#### `compute_int_add`

该程序在 30 次和 200 次下都保持 `similar`，ratio 也始终接近 1.0，因此其标签稳定性较高。

#### `memory_stride_write`

该程序在两轮实验中都保持 `similar`，并且在 200 次复核后更接近 1.0。这说明该标签较为可信，不像偶然误差导致的结果。

#### `host_getcwd_loop`

这是当前最异常的样本，但也是 focused rerun 中最稳定的结论之一。它在 30 次与 200 次下都显著落在 `wasm-better` 区间。

这表明该现象并非单纯由低重复次数造成。不过，由于该结果与一般直觉不完全一致，后续仍应将其作为 case study 单独讨论，而不宜直接推广为一般性结论。

---

## 5. 波动性分析

增强后的 benchmark 记录了 `std`、`min`、`max` 等统计量，可以帮助判断计时波动情况。

### 5.1 Native 侧波动较大的样本

`labels_30.csv` 中较明显的例子有：

- `compute_int_add` native std = 27.255898 ms
- `compute_fp_mix` native std = 17.479915 ms
- `host_getcwd_loop` native std = 112.153833 ms
- `host_time_loop` native std = 17.024906 ms

这表明某些 native 程序存在较强抖动，因此提高重复次数、保留原始 timing 记录是有必要的。

### 5.2 Wasm 侧波动情况

例如：

- `call_indirect` wasm std = 9.780287 ms
- `compute_fp_mix` wasm std = 9.170284 ms
- `memory_stride_write` wasm std = 9.478102 ms
- `host_time_loop` wasm std = 14.853753 ms

在 200 次 focused rerun 中，即使标准差仍然不低，接近阈值的样本标签仍然明显更稳定。这说明增加样本量确实可以降低标签误判风险。

---

## 6. 可靠性结论

### 6.1 当前较可信的结论

目前可以较有把握地得出以下结论：

1. 当前微基准中，大多数样本属于 `native-better`。
2. `compute_int_add` 与 `memory_stride_write` 在更强测量条件下都稳定为 `similar`。
3. `host_getcwd_loop` 是一个稳定的 `wasm-better` 异常样本，值得后续单独解释。
4. 与最初的 5 次运行相比，30 次运行已经显著提高了标签可信度，可以作为默认 pilot 配置。

### 6.2 当前仍不完全可靠的部分

1. 任何接近 ±10% 阈值的程序，其标签都应视为暂时性结论，直到经过 focused rerun 验证。
2. `compute_fp_mix` 说明即使是 30 次运行，边界样本的标签仍可能发生翻转。
3. 当前数据集规模仍然较小，因此即便标签稳定，也只能说明“对当前 benchmark 集合成立”，还不能直接推广为一般规律。

---

## 7. 当前标签的使用建议

### 7.1 当前可安全使用的做法

对于探索性特征分析和 pilot 建模，当前可以采用：

- `labels_30.csv` 作为默认结果表；
- `labels_focus_200.csv` 作为 focused 样本的高可信覆盖结果。

尤其是 `compute_fp_mix`，后续分析中应优先采用 200 次复核结果，将其视为 `similar`。

### 7.2 建议的数据集策略

在构建下一版训练表时，建议：

- 默认使用 30 次运行的结果；
- 对已有 focused rerun 的程序，用 200 次结果覆盖其标签与 ratio；
- 保留所有 raw timing 文件，以保证实验可复现和可审计。

---

## 8. 建议的后续工作

### 立刻可执行的动作

- 以 `labels_30.csv` 为基础生成新的合并数据集。
- 对 focused 程序用 `labels_focus_200.csv` 结果进行覆盖更新。
- 后续分析中将 `compute_fp_mix` 视为 `similar`。
- 将 `host_getcwd_loop` 标记为异常 case study 样本。

### 短期测量改进建议

- 在 benchmark 汇总表中增加变异系数（CV）。
- 为每个程序单独输出 JSON，便于画图分析。
- 对未来 ratio 落在 [0.9, 1.1] 区间的样本统一执行 200~500 次复核。
- 若后续要求更严格的可复现性，可尝试固定 CPU affinity 或减少后台噪声。

### 论文/汇报建议

- 同时报告 30 次全量结果与 200 次 focused reliability check。
- 明确说明接近阈值样本为何需要额外复核。
- 将 `host_getcwd_loop` 作为异常讨论案例，而不是直接用来得出 “Wasm 普遍更优” 的结论。

---

## 9. 最终评估

与最初的 5 次运行版本相比，当前 benchmark pipeline 的可靠性已有明显提升。最关键的方法学改进不仅在于增加重复次数，更在于同时保留了原始 timing 记录和统计量。

focused rerun 的结果表明：不同程序的标签稳定性并不相同。有些程序在更强测量条件下仍保持原标签，而接近阈值的样本则可能发生翻转。

因此，当前结果已经可以支持下一阶段的探索性分析，但前提是：

- 对边界样本保持谨慎；
- 将高重复 focused rerun 视为更高置信度证据；
- 在后续阶段继续扩展 benchmark 数据集规模。

