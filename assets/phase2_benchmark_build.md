
## Phase 2 总目标

把当前这 12 个参数化微基准，扩展为一个**30~50 个 benchmark 的第一版可建模数据集**，满足：

1. **结构覆盖更全**  
   compute / memory / branch / call / host / alloc 都有足够变体

2. **标签分布更健康**  
   不能几乎全是 `native-better`

3. **来源更丰富**  
   不仅有自写微基准，还要有：
   - PolyBench/C 子集
   - 真实 workload
   - 主动设计的“接近 native / 可能 wasm-better”样本

4. **特征空间更可学**  
   同一类 benchmark 内部要有可控变化，而不是每类只一个点

---

**目前的`benchmark`微基准程序**（6类每类2个样本程序）：

- compute-heavy
- memory-heavy
- branch-heavy
- call-heavy
- host-interaction-heavy
- allocation-heavy



**Questions**：
1. 每类基类样本太少，只有2个。
	- memory 类只有顺序读、跨步写
	- branch 类只有 predictable / unpredictable
	- call 类只有 direct / indirect
2. 标签分布不平衡
3. 缺少“接近 native / wasm-better”的主动设计样本


**建议**：
- 微基准：24~30
- PolyBench/C：8~12
- 真实 workload：6~10


## Phase 2A：微基准先扩到 30+
- 微基准从 12 扩到 24 左右
- 先不急着加太多真实 workload
- 目的是先让“结构特征空间”更稠密

### A1. Compute-heavy：补到 5 个

当前已有：
- `compute_int_add`
- `compute_fp_mix`

建议新增：

### 1. `compute_int_mul.c`
- 特征目标：高 `compute_density`
- 作用：和加法型整数算术区分开
- 预期：可能接近 native，但不一定最优

### 2. `compute_fp_muladd.c`
- 特征目标：浮点乘加密集
- 作用：和混合浮点运算区分开
- 预期：较可能 `similar`

### 3. `compute_transcendental.c`
- 包含 `sin/cos/log/sqrt` 等
- 作用：引入 libm / 数学库开销
- 预期：更可能 `native-better`

这样 compute 类可以形成：
- int-add
- int-mul
- fp-mix
- fp-muladd
- transcendental

---

### A2. Memory-heavy：补到 5~6 个

当前已有：
- `memory_seq_read`
- `memory_stride_write`

建议新增：

### 1. `memory_seq_write.c`
- 顺序写
- 和顺序读对照

### 2. `memory_stride_read.c`
- 跨步读
- 和跨步写对照

### 3. `memory_random_read.c`
- 伪随机索引读
- 引入 cache-unfriendly 行为

### 4. `memory_random_write.c`
- 伪随机写
- 比顺序/stride 更不规则

### 5. `memory_copy_loop.c`
- 类似 `memcpy` 风格循环
- 规则访存，可能更接近 `similar`

memory 类就可以覆盖：
- seq read
- seq write
- stride read
- stride write
- random read
- random write / copy

这类对后续很重要，因为你现在已经观察到：
> 规则化访存模式可能更接近 native

---

### A3. Branch-heavy：补到 4~5 个

当前已有：
- `branch_predictable`
- `branch_unpredictable`

建议新增：

### 1. `branch_nested.c`
- 多层嵌套条件
- 强化控制流复杂度

### 2. `branch_switch_dense.c`
- `switch-case` 密集分支
- 引入 jump-table 风格结构

### 3. `branch_switch_sparse.c`
- 稀疏 switch
- 和 dense switch 做对照

### 4. `branch_data_dependent.c`
- 分支依赖数据分布
- 与完全随机、完全可预测形成中间地带

这样 branch 类不再只是“预测 vs 不可预测”，而是有：
- predictable
- unpredictable
- nested
- dense switch
- sparse switch
- data-dependent

---

### A4. Call-heavy：补到 4~5 个

当前已有：
- `call_chain`
- `call_indirect`

建议新增：

### 1. `call_many_small_funcs.c`
- 大量极短函数调用
- 测试调用边界成本

### 2. `call_recursive.c`
- 递归调用
- 与直接链式调用对照

### 3. `call_virtual_table_style.c`
- 多函数指针分发表
- 加强 indirect call 特征

### 4. `call_mixed_direct_indirect.c`
- 直接+间接混合
- 更像真实程序结构

call 类应该重点做，因为你现在结果已经显示：
- `call_chain`
- `call_indirect`
都明显偏 `native-better`

这是论文里很可能能形成强解释的特征簇。

---

### A5. Host-interaction-heavy：补到 5~6 个

当前已有：
- `host_time_loop`
- `host_getcwd_loop`

建议新增：

### 1. `host_stat_loop.c`
- 高频 `stat`
- 文件系统 metadata 查询

### 2. `host_open_close_loop.c`
- 高频 open/close
- 明显 host boundary 成本

### 3. `host_read_small.c`
- 小块读取
- 真实 I/O 更接近 workload

### 4. `host_write_small.c`
- 小块写
- 与 read 对照

### 5. `host_env_query.c`
- 如 `getenv` / 类似环境查询
- 可能比文件系统调用轻量

这类里要**主动保留一些轻量 host call**，因为它们更有机会接近 `similar`，甚至极少数场景可能出现 `wasm-better`。

---

### A6. Allocation-heavy：补到 4~5 个

当前已有：
- `alloc_small_objects`
- `alloc_bulk_buffer`

建议新增：

### 1. `alloc_medium_objects.c`
- 中等对象频繁分配
- 填补 small/bulk 中间区域

### 2. `alloc_realloc_loop.c`
- 高频 `realloc`
- 更接近真实 buffer growth

### 3. `alloc_pool_style.c`
- 预分配池后重复使用
- 这类可能更接近 `similar`

### 4. `alloc_fragmented_pattern.c`
- 交错分配释放
- 更容易暴露管理开销

这里尤其建议加入 `alloc_pool_style`，因为它是**主动制造更接近 native 的候选样本**。


## Phase2B：引入 PolyBench/C 子集

这是 Phase 2 非常关键的一步。  
因为你不能只靠自写微基准做论文结论，否则外部有效性不够。

### 选取原则
优先选：
- 单文件/易移植
- 不依赖复杂 I/O
- 计算结构清晰
- 覆盖不同 loop / memory pattern

### 推荐子集（8~12 个）

#### 线性代数类
1. `gemm`
2. `gemver`
3. `gesummv`
4. `atax`
5. `bicg`

#### stencil / dynamic programming
6. `jacobi-1d`
7. `jacobi-2d`
8. `seidel-2d`

#### 数据局部性/数组操作
9. `doitgen`
10. `mvt`

#### 可选补充
11. `correlation`
12. `covariance`

---

### 为什么这些合适？
它们有几个好处：

- 大多是**规则循环 + 规则访存**
- 很多程序理论上应该更接近 `similar`
- 能很好补充你当前“计算类更接近 native”的观察
- 能把数据集从“玩具 benchmark”推进到“标准 benchmark + 自定义 benchmark 混合”的层次

---

### 预期标签分布作用
PolyBench/C 子集很可能会贡献较多：
- `similar`
- 中等 `native-better`

这对缓解当前标签不平衡很有帮助。

---

## Phase2C：增加真实 workload

这是为了让你的数据集更像“研究数据集”，而不是只像课程实验。

建议选 **6~10 个**，优先轻量、可独立编译、无复杂外部依赖的。

---

### C1. 文本/字节处理类
#### 1. `checksum_crc32`
- 规则计算 + 字节流扫描
- 可能接近 `similar`

#### 2. `string_search_kmp`
- 控制流 + 线性扫描混合
- 可用于区分 compute / branch / memory

#### 3. `word_count`
- 文件读入 + 文本处理
- 更真实，但要注意 I/O 成本

---

### C2. 图像/数组处理类
#### 4. `image_blur_gray`
- 规则 stencil
- 很可能接近 `similar`

#### 5. `sobel_edge`
- 计算+访存混合
- 比简单 blur 更复杂

#### 6. `histogram`
- 可能涉及竞争式更新或分布统计
- 行为不完全规则

---

### C3. 数据结构/算法类
#### 7. `quicksort_int`
- 分支 + 递归 + 内存访问混合
- 很可能 `native-better`

#### 8. `binary_search_batch`
- 规则较强，可能接近 `similar`

#### 9. `hash_table_lookup`
- 随机访存 + 分支
- 可能明显 `native-better`

#### 10. `matrix_multiply_blocked`
- 比简单 gemm 更接近“实际优化代码”
- 可能较接近 `similar`