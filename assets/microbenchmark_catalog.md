# 微基准程序分类说明

本文档对 `data/microbenchmarks/` 目录下全部 34 个 C 程序进行分类说明，参照 `benchmark_checklist.md` 的六大类别（Compute-heavy / Memory-heavy / Branch-heavy / Call-heavy / Host-interaction-heavy / Allocation-heavy）组织，并补充每个程序的设计目标、核心机制与关键特征。

---

## 概览


| 类别                         | 数量     | 程序列表（文件名前缀）                                                                                                                                         |
| -------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| B1. Compute-heavy          | 5      | `compute_int_add`, `compute_int_mul`, `compute_int_divmod`, `compute_fp_mix`, `compute_fp_muladd`                                                   |
| B2. Memory-heavy           | 7      | `memory_seq_read`, `memory_seq_write`, `memory_stride_read`, `memory_stride_write`, `memory_random_read`, `memory_random_write`, `memory_copy_loop` |
| B3. Branch-heavy           | 5      | `branch_predictable`, `branch_unpredictable`, `branch_nested`, `branch_switch_dense`, `branch_switch_sparse`                                        |
| B4. Call-heavy             | 4      | `call_chain`, `call_indirect`, `call_recursive`, `call_many_small_funcs`                                                                            |
| B5. Host-interaction-heavy | 7      | `host_time_loop`, `host_getcwd_loop`, `host_env_query`, `host_stat_loop`, `host_read_small`, `host_write_small`, `host_open_close_loop`             |
| B6. Allocation-heavy       | 6      | `alloc_small_objects`, `alloc_bulk_buffer`, `alloc_medium_objects`, `alloc_realloc_loop`, `alloc_pool_style`, `alloc_fragmented_pattern`            |
| **合计**                     | **34** |                                                                                                                                                     |


---

## B1. Compute-heavy（计算密集型）

该类程序以纯算术运算为主，访存极少，无宿主调用，目标是测量 Wasm 与 Native 在纯计算吞吐量上的差距。

### M01 `compute_int_add.c`

- **设计目标**：整数加法 / 位运算混合的高密度计算循环
- **核心机制**：对累加器 `acc` 执行 `+`、`^`、移位操作，循环 N=50,000,000 次
- **关键特征**：
  - `compute_density` 极高（几乎全为算术指令）
  - `memory_access_density` 极低（只有 `volatile` sink 写入）
  - 无分支、无调用、无分配、无 hostcall
- **预期结果**：ratio 接近 1；Native 与 Wasm 在纯整数加法上几乎同速，属 `similar` 边界
- **备注**：实测 `similar`（ratio≈0.990），是少数 Wasm 可追平 Native 的场景之一

---

### M02 `compute_int_mul.c`

- **设计目标**：整数乘法为主的高密度计算，加入 LCG 混合以阻止常量折叠
- **核心机制**：`acc = acc * 1664525 + (i * 1013904223)`，N=45,000,000 次；再做 XOR 移位
- **关键特征**：
  - `compute_density` 高，乘法指令占主导
  - 无访存、无分支、无调用
- **预期结果**：ratio 接近 1；乘法指令在两平台上代价相近，属 `similar`
- **备注**：实测 `similar`（ratio≈1.021）

---

### M03 `compute_int_divmod.c`

- **设计目标**：整数除法与取模（代价较高）密集循环
- **核心机制**：`q = acc / ((i & 255) + 1)`，`r = acc % ((i & 127) + 1)`，N=30,000,000 次；除数随 `i` 变化防止编译器优化
- **关键特征**：
  - 除法/取模为瓶颈指令，`compute_density` 高
  - 除数动态变化，无法被常量折叠
- **预期结果**：ratio 接近 1；整数除法两平台代价相近
- **备注**：实测 `similar`（ratio≈1.005）

---

### M04 `compute_fp_mix.c`

- **设计目标**：双精度浮点乘加混合，测量 FP 吞吐量
- **核心机制**：对 `x`, `y` 双精度变量循环做 FMA 风格混合运算，N=12,000,000 次
- **关键特征**：
  - FP 乘法 + FP 加法交替，`compute_density` 高
  - 两变量互相依赖，形成数据依赖链
- **预期结果**：FP 性能两平台接近，ratio 略大于 1
- **备注**：实测 `native-better`（ratio≈1.101），FP 上 Wasm 略慢

---

### M05 `compute_fp_muladd.c`

- **设计目标**：相比 `compute_fp_mix` 更规则的 FP 乘加，减少变量间耦合
- **核心机制**：类似结构，但系数更接近 1，`x += (i & 15) * 0.03125`
- **关键特征**：与 M04 类似，但数值变化幅度更小，利于观察精度/性能边界
- **预期结果**：与 M04 结果相近
- **备注**：实测 `native-better`（ratio≈1.106）

---

## B2. Memory-heavy（访存密集型）

该类程序以大规模内存读写为主，测量不同访问模式（顺序/跨步/随机）下的性能差异，关注 Wasm 线性内存边界检查对缓存行为的影响。

### M06 `memory_seq_read.c`

- **设计目标**：顺序扫描读，最友好的缓存访问模式
- **核心机制**：分配 N=4,000,000 个 `uint32_t`，初始化后顺序累加读取
- **关键特征**：
  - `memory_access_density` 高，`load_count` 远大于 `store_count`
  - 顺序访问，硬件预取效果最佳
- **预期结果**：Wasm 在顺序访存下额外开销较小
- **备注**：实测 `native-better`（ratio≈1.551）

---

### M07 `memory_seq_write.c`

- **设计目标**：顺序写入，测量写带宽
- **核心机制**：分配 N=5,000,000 个 `uint32_t`，20 轮顺序写入，每轮对所有元素执行 `arr[i] += round + i`
- **关键特征**：
  - `store_count` 高，`memory_access_density` 高
  - 多轮写入放大访存总量
- **预期结果**：写带宽场景下 Wasm 有额外开销
- **备注**：实测 `native-better`（ratio≈1.346）

---

### M08 `memory_stride_read.c`

- **设计目标**：跨步读取，破坏顺序预取
- **核心机制**：以 STRIDE=16 跨步读取 N=5,000,000 元素数组，32 轮
- **关键特征**：
  - 每次访问跳过 15 个元素，cache line 利用率降低
  - `load_store_ratio` 高（读多写少）
- **预期结果**：跨步读比顺序读更容易放大 Wasm 开销
- **备注**：实测 `native-better`（ratio≈1.168）

---

### M09 `memory_stride_write.c`

- **设计目标**：跨步写入，评估写端的缓存利用率影响
- **核心机制**：以 STRIDE=16 跨步写入 N=4,000,000 元素数组，32 轮
- **关键特征**：
  - `store_count` 高，`memory_access_density` 高
  - 跨步写入触发 cache line 脏回写
- **预期结果**：ratio 接近 1（因写端均受 cache 限制）
- **备注**：实测 `similar`（ratio≈1.023），两平台均受写带宽瓶颈，差异缩小

---

### M10 `memory_random_read.c`

- **设计目标**：随机读，最差缓存局部性，模拟指针追踪
- **核心机制**：用 XorShift 生成随机索引，对 N=3,000,000 元素数组随机读取，24 轮
- **关键特征**：
  - 随机访问导致大量 cache miss
  - `memory_access_density` 高，`load_count` 大
- **预期结果**：随机读场景两平台均受 DRAM 延迟限制，Wasm 额外开销相对稀释
- **备注**：实测 `native-better`（ratio≈1.197）

---

### M11 `memory_random_write.c`

- **设计目标**：随机写，测量写端的随机访存性能
- **核心机制**：用 XorShift 生成随机索引，对 N=2,500,000 元素数组随机写入，20 轮
- **关键特征**：
  - 随机写触发 cache line 分配与脏回写
  - `store_count` 高，`memory_random_write` 是该组写压力最大的
- **预期结果**：与随机读类似，两平台均受内存瓶颈
- **备注**：实测 `native-better`（ratio≈1.215）

---

### M12 `memory_copy_loop.c`

- **设计目标**：大块内存拷贝，测量 `memcpy` 吞吐量
- **核心机制**：分配两个 BUF_MB=8 MB 缓冲区，N=8 次 `memcpy` 并交换指针
- **关键特征**：
  - `alloc_call_count`=4（含 malloc），`memory_access_density` 高
  - 实际操作量极大（8次 × 8MB），测量内存带宽
- **预期结果**：大块拷贝场景 Wasm 额外开销被带宽瓶颈稀释
- **备注**：实测 `native-better`（ratio≈2.006）

---

## B3. Branch-heavy（分支密集型）

该类程序以分支指令为主要工作负载，测量不同分支可预测性与结构复杂度对 Wasm / Native 性能差异的影响。

### M13 `branch_predictable.c`

- **设计目标**：高度可预测分支，分支预测器易命中
- **核心机制**：`if ((i & 1) == 0)` 严格交替，N=60,000,000 次
- **关键特征**：
  - `branch_density` 高，`compute_density` 低
  - 分支方向固定交替，预测器命中率接近 100%
- **预期结果**：可预测分支下 Wasm 编译器结构差异相对明显
- **备注**：实测 `native-better`（ratio≈1.343）

---

### M14 `branch_unpredictable.c`

- **设计目标**：伪随机分支，分支预测器难命中
- **核心机制**：用 XorShift32 生成伪随机数，依低位决定分支方向，N=40,000,000 次
- **关键特征**：
  - 分支方向接近随机，预测器命中率约 50%
  - `branch_density` 高
- **预期结果**：随机分支大幅放大两平台差距
- **备注**：实测 `native-better`（ratio≈1.812），为 branch 类中差距最大的

---

### M15 `branch_nested.c`

- **设计目标**：嵌套条件分支，测试多层 if-else 结构
- **核心机制**：两层嵌套 if，依 `i \u0026 1`、`i \u0026 3`、`i \u0026 7` 决定分支，N=35,000,000 次
- **关键特征**：
  - `branch_density` 高（多个 branch 指令/basic block）
  - `max_loop_depth`=1，但 basic_block 数多
- **预期结果**：嵌套分支结构在 Wasm 中有额外控制流开销
- **备注**：实测 `native-better`（ratio≈1.975）

---

### M16 `branch_switch_dense.c`

- **设计目标**：密集 switch，case 值连续（0–7），可被编译为跳转表
- **核心机制**：`switch (i \u0026 7)` 含 8 个连续 case，N=45,000,000 次
- **关键特征**：
  - 连续 case 值，后端通常生成 jump table
  - Wasm 的 `br_table` 指令与 Native jump table 对比
- **预期结果**：dense switch 下 Wasm `br_table` 可能比 Native 更快或持平
- **备注**：实测 `wasm-better`（ratio≈0.879），是少数 wasm-better 样本之一

---

### M17 `branch_switch_sparse.c`

- **设计目标**：稀疏 switch，case 值分散（0, 17, 53, 89），无法优化为跳转表
- **核心机制**：用 XorShift64 生成随机数，`switch (x % 97)` 仅命中 4 个 case，N=45,000,000 次
- **关键特征**：
  - 稀疏 case，后端倾向生成 if-else 链或二叉判断树
  - default 分支命中率极高
- **预期结果**：稀疏 switch 下 Wasm 可能因 `br_table` 指令的索引归一化更高效
- **备注**：实测 `wasm-better`（ratio≈0.743），差距明显，是所有程序中 Wasm 领先幅度最大的

---

## B4. Call-heavy（调用密集型）

该类程序以函数调用为核心工作负载，测量直接调用链、间接调用（函数指针）、递归调用及大量小函数调用对 Wasm / Native 性能的影响。

### M18 `call_chain.c`

- **设计目标**：深层内联调用链，测试编译器内联能力
- **核心机制**：5 层 `static inline` 函数嵌套（f1→f2→f3→f4→f5），循环 N=30,000,000 次
- **关键特征**：
  - 函数标记 `static inline`，编译器可完全内联
  - 若内联成功，`call_instr_count`=0；IR 层面仍可见调用依赖
  - 内联后等价于纯计算循环
- **预期结果**：内联后接近 compute-heavy，ratio 适中
- **备注**：实测 `native-better`（ratio≈1.422）

---

### M19 `call_indirect.c`

- **设计目标**：函数指针调用（间接调用），测试 Wasm `call_indirect` 指令开销
- **核心机制**：3 个函数指针 `op_add / op_mul / op_mix` 存入数组，按 `i % 3` 轮流调用，N=25,000,000 次
- **关键特征**：
  - `indirect_call_count` 高
  - Wasm 需执行类型签名检查（`call_indirect` 安全检查），Native 无此开销
- **预期结果**：间接调用场景 Wasm 有系统性额外开销
- **备注**：实测 `native-better`（ratio≈1.818）

---

### M20 `call_recursive.c`

- **设计目标**：深层递归调用，测量调用栈开销
- **核心机制**：`recur(x, d)` 递归深度 DEPTH=26，外层循环 N=300,000 次
- **关键特征**：
  - 每次外层迭代产生 26 层递归调用
  - `call_instr_count` 高（相对于 IR 指令总数）
  - Wasm 调用栈与 shadow stack 有额外开销
- **预期结果**：深层递归下 Wasm 额外开销显著
- **备注**：实测 `native-better`（ratio≈2.260）

---

### M21 `call_many_small_funcs.c`

- **设计目标**：多个小函数频繁调用，测量调用本身的开销（而非递归深度）
- **核心机制**：5 个 `static inline` 小函数 f0–f4 依次调用，循环 N=20,000,000 次
- **关键特征**：
  - 与 `call_chain` 类似，但函数功能更独立
  - 编译器可能内联，测量的是"内联后"的计算效率
- **预期结果**：内联后接近 compute-heavy
- **备注**：实测 `native-better`（ratio≈1.255）

---

## B5. Host-interaction-heavy（宿主交互密集型）

该类程序以系统调用 / WASI 宿主调用为主要工作负载，测量 hostcall 在 Wasm 沙箱边界的额外开销。此类程序的性能行为与其他类别差异显著，部分程序出现 `wasm-better` 现象。

### M22 `host_time_loop.c`

- **设计目标**：高频 `clock_gettime` 调用，测量时间查询的 hostcall 开销
- **核心机制**：N=500,000 次 `clock_gettime(CLOCK_REALTIME, \u0026ts)`
- **关键特征**：
  - `time_call_count`=1，`hostcall_count`=2
  - Wasm 端每次调用需跨越 WASI 边界；Native 可能走 vDSO 快路径
  - 是与 `ratio` 相关性最强的特征（|r|=0.701）的来源样本
- **预期结果**：Native 通过 vDSO 几乎无系统调用开销，Wasm 有明显边界开销
- **备注**：实测 `native-better`（ratio≈5.250），是所有程序中 ratio 最大的之一

---

### M23 `host_getcwd_loop.c`

- **设计目标**：高频 `getcwd` 调用，测量文件系统路径查询的 hostcall 开销
- **核心机制**：N=300,000 次 `getcwd(buf, sizeof(buf))`
- **关键特征**：
  - `filesystem_call_count`=1，`hostcall_count`=2
  - Wasm 的 `getcwd` 通过 WASI `path_open` 等接口实现，可能比 Native 轻量
- **预期结果**：`getcwd` 在部分 Wasm 运行时实现比 Native OS 系统调用更轻
- **备注**：实测 `wasm-better`（ratio≈0.165），是差距最大的 wasm-better 样本，Wasm 速度远超 Native

---

### M24 `host_env_query.c`

- **设计目标**：高频 `getenv` 调用，测量环境变量查询开销
- **核心机制**：N=600,000 次 `getenv("PATH")`
- **关键特征**：
  - `hostcall_count`=1（`getenv` 在部分 WASI 运行时实现为查表）
  - Native `getenv` 直接访问进程内存，极快
- **预期结果**：Native 直接内存访问，Wasm 有 WASI 接口开销
- **备注**：实测 `native-better`（ratio≈2.268）

---

### M25 `host_stat_loop.c`

- **设计目标**：高频 `stat` 调用，测量文件元数据查询开销
- **核心机制**：N=300,000 次 `stat(".", \u0026st)`
- **关键特征**：
  - `filesystem_call_count`=1，`hostcall_count`=2
  - 每次 `stat` 在 Native 下通过 VFS，在 Wasm 下通过 WASI `path_filestat_get`
- **预期结果**：文件系统调用下 Wasm 有额外 WASI 封装开销
- **备注**：实测 `native-better`（ratio≈2.104）

---

### M26 `host_read_small.c`

- **设计目标**：循环 open/read/close 小文件，测量文件 I/O 完整路径开销
- **核心机制**：先写入 64 字节文件，再循环 N=80,000 次执行 open→read→close
- **关键特征**：
  - `hostcall_count`=7（open, read, close 各占一部分）
  - 每次迭代产生 3 次系统调用
  - `io_call_count` 高
- **预期结果**：文件 I/O 密集场景两平台均受 OS 限制，但 Wasm 有额外层级
- **备注**：实测 `native-better`（ratio≈1.196），但 ratio 相对低，I/O 瓶颈稀释了差距

---

### M27 `host_write_small.c`

- **设计目标**：循环 open/write/close 小文件，测量写端 I/O 路径
- **核心机制**：N=5,000 次 open→write(64 bytes)→close（每次 truncate）
- **关键特征**：
  - `hostcall_count`=4，`io_call_count`=4
  - 迭代次数少，但每次均有完整 I/O 往返
- **预期结果**：写端 I/O 与读端类似，受系统调用次数影响
- **备注**：实测 `native-better`（ratio≈1.101），I/O 开销主导，Wasm 额外开销相对小

---

### M28 `host_open_close_loop.c`

- **设计目标**：纯 open/close 循环，隔离文件描述符分配/释放的开销
- **核心机制**：先创建文件，再 N=150,000 次 open（只读）+ close
- **关键特征**：
  - `hostcall_count`=6，每次迭代 2 次 hostcall（open + close）
  - 无读写操作，专注 fd 管理路径
- **预期结果**：fd 管理路径下 Wasm WASI 封装有一定开销
- **备注**：实测 `native-better`（ratio≈1.221）；注意该程序绝对耗时较长（>90s），受文件系统影响大

---

## B6. Allocation-heavy（分配密集型）

该类程序以堆内存分配与释放为核心，测量不同分配模式（小对象高频、大块批量、中等对象、realloc、pool-style、碎片化）下的 Wasm / Native 性能差异。

### M29 `alloc_small_objects.c`

- **设计目标**：高频小对象（8×uint32_t）分配与释放
- **核心机制**：N=2,000,000 次 malloc(32 bytes) → 写入 → 求和 → free
- **关键特征**：
  - `alloc_call_count`=2（malloc + free），高频
  - Wasm 的 `malloc` 通过 `dlmalloc` / `wee_alloc` 等实现，比 Native glibc 分配器慢
- **预期结果**：高频小对象分配下 Wasm 分配器开销累积显著
- **备注**：实测 `native-better`（ratio≈2.056）

---

### M30 `alloc_bulk_buffer.c`

- **设计目标**：大块缓冲区（1 MB）分配与批量访问
- **核心机制**：N=512 次 malloc(1 MB) → memset → 采样读 → free
- **关键特征**：
  - `alloc_call_count`=2，每次分配 1 MB
  - 分配次数少但单次规模大，访存量大
  - `memory_access_density` 高（memset 全写）
- **预期结果**：大块分配次数少，分配器开销被访存摊薄
- **备注**：实测 `native-better`（ratio≈1.298），ratio 相对低

---

### M31 `alloc_medium_objects.c`

- **设计目标**：中等大小对象（64×uint32_t = 256 bytes）分配与释放
- **核心机制**：N=1,200,000 次 malloc(256 bytes) → 写入 → 读一个元素 → free
- **关键特征**：
  - `alloc_call_count`=2，规模介于小对象与大块之间
  - `store_count` 高（写入 SZ=64 个元素）
- **预期结果**：中等对象下分配开销较小对象略低，但仍显著
- **备注**：实测 `native-better`（ratio≈2.039）

---

### M32 `alloc_realloc_loop.c`

- **设计目标**：循环 `realloc` 动态扩缩容，测量重分配路径
- **核心机制**：N=1,000,000 次，每 8 次迭代触发一次 realloc（容量在 16–4096 字节间循环增减）
- **关键特征**：
  - `alloc_call_count`=3（含 malloc、realloc、free）
  - realloc 可能触发数据复制，开销不规则
- **预期结果**：realloc 路径下 Wasm 分配器实现差异更为明显
- **备注**：实测 `native-better`（ratio≈1.851）

---

### M33 `alloc_pool_style.c`

- **设计目标**：预分配大池后反复写读，模拟 pool allocator 行为
- **核心机制**：一次 malloc(POOL=262144×uint32_t)，然后 N=8,000,000 次按索引写读（`pool[i % POOL]`）
- **关键特征**：
  - `alloc_call_count`=2（只分配/释放一次），分配开销被完全摊薄
  - 主要工作是循环访存（顺序循环索引）
  - `memory_access_density` 高
- **预期结果**：分配开销可忽略，性能由访存主导；ratio 应低于其他 alloc 类
- **备注**：实测 `native-better`（ratio≈1.695）

---

### M34 `alloc_fragmented_pattern.c`

- **设计目标**：碎片化分配模式，模拟真实应用中交替分配/释放不同大小对象
- **核心机制**：维护 64 个 slot，N=600,000 次轮流对同一 slot 先 free 旧对象再 malloc 新对象（大小随 `i % 128 + 8` 变化），或反之
- **关键特征**：
  - `alloc_call_count`=3，分配大小不规则
  - 交替 malloc/free 导致堆碎片化
  - `call_instr_count`=3（含 malloc、free、条件分支内嵌调用）
- **预期结果**：碎片化场景下堆管理开销最大，Wasm 分配器受影响明显
- **备注**：实测 `native-better`（ratio≈2.021）

---

## 附录：程序索引表


| 编号  | 文件名                          | 类别         | 实测标签            | ratio |
| --- | ---------------------------- | ---------- | --------------- | ----- |
| M01 | `compute_int_add.c`          | B1 Compute | similar         | 0.990 |
| M02 | `compute_int_mul.c`          | B1 Compute | similar         | 1.021 |
| M03 | `compute_int_divmod.c`       | B1 Compute | similar         | 1.005 |
| M04 | `compute_fp_mix.c`           | B1 Compute | native-better   | 1.101 |
| M05 | `compute_fp_muladd.c`        | B1 Compute | native-better   | 1.106 |
| M06 | `memory_seq_read.c`          | B2 Memory  | native-better   | 1.551 |
| M07 | `memory_seq_write.c`         | B2 Memory  | native-better   | 1.346 |
| M08 | `memory_stride_read.c`       | B2 Memory  | native-better   | 1.168 |
| M09 | `memory_stride_write.c`      | B2 Memory  | similar         | 1.023 |
| M10 | `memory_random_read.c`       | B2 Memory  | native-better   | 1.197 |
| M11 | `memory_random_write.c`      | B2 Memory  | native-better   | 1.215 |
| M12 | `memory_copy_loop.c`         | B2 Memory  | native-better   | 2.006 |
| M13 | `branch_predictable.c`       | B3 Branch  | native-better   | 1.343 |
| M14 | `branch_unpredictable.c`     | B3 Branch  | native-better   | 1.812 |
| M15 | `branch_nested.c`            | B3 Branch  | native-better   | 1.975 |
| M16 | `branch_switch_dense.c`      | B3 Branch  | **wasm-better** | 0.879 |
| M17 | `branch_switch_sparse.c`     | B3 Branch  | **wasm-better** | 0.743 |
| M18 | `call_chain.c`               | B4 Call    | native-better   | 1.422 |
| M19 | `call_indirect.c`            | B4 Call    | native-better   | 1.818 |
| M20 | `call_recursive.c`           | B4 Call    | native-better   | 2.260 |
| M21 | `call_many_small_funcs.c`    | B4 Call    | native-better   | 1.255 |
| M22 | `host_time_loop.c`           | B5 Host    | native-better   | 5.250 |
| M23 | `host_getcwd_loop.c`         | B5 Host    | **wasm-better** | 0.165 |
| M24 | `host_env_query.c`           | B5 Host    | native-better   | 2.268 |
| M25 | `host_stat_loop.c`           | B5 Host    | native-better   | 2.104 |
| M26 | `host_read_small.c`          | B5 Host    | native-better   | 1.196 |
| M27 | `host_write_small.c`         | B5 Host    | native-better   | 1.101 |
| M28 | `host_open_close_loop.c`     | B5 Host    | native-better   | 1.221 |
| M29 | `alloc_small_objects.c`      | B6 Alloc   | native-better   | 2.056 |
| M30 | `alloc_bulk_buffer.c`        | B6 Alloc   | native-better   | 1.298 |
| M31 | `alloc_medium_objects.c`     | B6 Alloc   | native-better   | 2.039 |
| M32 | `alloc_realloc_loop.c`       | B6 Alloc   | native-better   | 1.851 |
| M33 | `alloc_pool_style.c`         | B6 Alloc   | native-better   | 1.695 |
| M34 | `alloc_fragmented_pattern.c` | B6 Alloc   | native-better   | 2.021 |


> ratio = wasm_median_ms / native_median_ms，ratio < 1 表示 Wasm 更快。

