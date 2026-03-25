# 3/25 V1 结果分析

1. 暂时继续使用外部计时
> 更符合真实使用场景，但混入了启动/加载开销

2. pilot 程序重复次数 5 -> 30，并记录方差等数据
3. 复核异常样本和边界样本


**Questions:**
1. 程序重复次数（5次）过少，可能出现噪声影响等
2. 目前使用外部整体计时而非插桩，需要考虑后续是否改写代码进行插桩
3. 具体时间、std等数据未记录，不利于后续结果分析
4. 近阈值数据需要进行复核和讨论
5. 样本量（12个程序）太小
6. 标签不平衡，不利于后续做分类模型，需要主动设计更多接近/优于 native 的 workload
7. 部分特征区分度还不够，目前的提取逻辑还是比较粗糙，需要进一步改进


**数据分析结果**：
1. 大多数样本是 native-better
2. 纯计算类更接近 similar
3. `memory_stride_write` 也接近 similar
4. `host_getcwd_loop` 出现了 `wasm-better`


**后续 plan**：

Phase 1：补强测量可靠性
目标
让标签更可信。

要做
1. 把 `repeats` 从 5 提高到 **30**
2. 在 `run_benchmarks.py` 中记录：
   - 每次原始运行时间
   - mean
   - median
   - std
   - min/max
3. 对接近阈值样本单独跑 **100~500 次**
4. 对 `host_getcwd_loop` 做重点复核


Phase 2：扩充 benchmark 数据集
目标
把 pilot 变成可建模数据集。

要做
1. 继续补微基准变体  
   每类至少扩展到 4~6 个
2. 引入 PolyBench/C 子集
3. 增加更多真实 workload
4. 主动增加“可能接近 native / 可能 wasm-better”的样本


Phase 3：改进特征质量
目标
让特征更能解释结果。

要做
1. 改善 IR 解析精度
2. 增加：
   - `avg_bb_size`
   - `cyclomatic_complexity`
   - 更可靠的 `loop_count`
   - 更可靠的 `indirect_call_count`
3. 区分：
   - `io_call_count`
   - `filesystem_call_count`
   - `time_call_count`
   - `alloc_call_count`
4. 考虑增加 wasm 模块层特征：
   - wasm binary size
   - imported function count
   - exported function count


Phase 4：建模与解释
目标
形成论文核心结果。

要做
1. 先做相关性分析
2. 再做简单模型：
   - logistic regression
   - decision tree
   - random forest
3. 做特征重要性分析
4. 做阈值敏感性分析：
   - 5%
   - 10%
   - 15%



**Checklist**：

A. 立刻要做
- [ ] 把 `run_benchmarks.py` 的 `repeats` 改为 30
- [ ] 增加输出每次运行时间明细
- [ ] 增加 `mean/std/min/max`
- [ ] 重新跑当前 12 个微基准
- [ ] 对 `host_getcwd_loop` 单独复核 100~500 次
- [ ] 对 `memory_stride_write` / `compute_fp_mix` / `compute_int_add` 做高重复复核


B. 本周内建议完成
- [ ] 每类微基准再补 2~4 个变体
- [ ] 总样本扩展到 30+
- [ ] 增强 `extract_features.py`
- [ ] 增加 wasm 模块层特征
- [ ] 生成新的 `dataset_labeled.csv`


C. 建模前必须完成
- [ ] 检查标签分布是否严重失衡
- [ ] 检查近阈值样本稳定性
- [ ] 做 5% / 10% / 15% 三组标签敏感性分析
- [ ] 保存 raw timing records，保证可复现
- [ ] 固定容器、编译器、runtime 版本


D. 论文写作前建议准备
- [ ] 一张标签分布图
- [ ] 一张 ratio 分布图
- [ ] 一张特征相关性热力图
- [ ] 一张特征重要性图
- [ ] 2~3 个 case study
  - 一个 `native-better`
  - 一个 `similar`
  - 一个异常样本（如 `host_getcwd_loop`）