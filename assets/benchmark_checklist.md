# Benchmark 清单

## 总体设计思路

本研究采用三层 benchmark 体系：

1. **标准 benchmark**：保证研究结果具备一定可比性与可信度；
2. **参数化微基准**：针对关键静态特征进行可控构造，是本研究识别底层影响因素的核心；
3. **少量真实 workload**：避免结论仅停留在 toy programs 上。

---

## A. 标准 benchmark 清单

### A1. PolyBench/C（优先级：高）
用于覆盖数值计算、循环嵌套、数组访问等典型结构。

建议优先选取：

| ID | Program | 类别 | 主要特征 |
|---|---|---|---|
| P01 | `gemm` | compute+memory | 规则循环、矩阵乘、计算密集 |
| P02 | `gemver` | compute+memory | 向量/矩阵混合 |
| P03 | `gesummv` | compute+memory | 线性代数 |
| P04 | `symm` | compute+memory | 对称矩阵计算 |
| P05 | `syr2k` | compute+memory | 高强度算术 |
| P06 | `atax` | memory-heavy | 数组访问明显 |
| P07 | `bicg` | memory-heavy | 访存与计算混合 |
| P08 | `mvt` | memory-heavy | 规则访存 |
| P09 | `jacobi-1d` | memory-heavy | stencil-like |
| P10 | `jacobi-2d` | memory-heavy | 二维规则访存 |
| P11 | `seidel-2d` | memory-heavy | 二维更新 |
| P12 | `floyd-warshall` | control+compute | 三重循环 |
| P13 | `nussinov` | dynamic-programming | 控制流与数组访问 |
| P14 | `fdtd-2d` | memory-heavy | 网格更新 |
| P15 | `correlation` | statistics | 浮点计算 |

### A2. CoreMark（优先级：中）
建议保留 2~4 个不同迭代规模版本，形成同结构、不同运行长度样本。

| ID | Program | 类别 | 备注 |
|---|---|---|---|
| C01 | `coremark-small` | compute-heavy | 小迭代 |
| C02 | `coremark-medium` | compute-heavy | 中迭代 |
| C03 | `coremark-large` | compute-heavy | 大迭代 |

### A3. 真实/现有 workload（优先级：中）
建议从现有项目中择优挑选，控制在 10~20 个内。

候选来源：
- Wasm-Score
- MiBench
- Ostrich
- 小型 crypto / text / parser 程序

建议关注：
- crypto/hash
- text processing
- image transform
- parser/tokenizer
- 小型数据结构程序

---

## B. 参数化微基准清单（本研究核心）

以下微基准将直接写入 `data/microbenchmarks/`。

### B1. Compute-heavy
| ID | 文件名 | 主要目标特征 | 说明 |
|---|---|---|---|
| M01 | `compute_int_add.c` | `compute_density` | 整数算术密集循环 |
| M02 | `compute_fp_mix.c` | `compute_density` | 浮点算术混合循环 |

### B2. Memory-heavy
| ID | 文件名 | 主要目标特征 | 说明 |
|---|---|---|---|
| M03 | `memory_seq_read.c` | `memory_access_density` | 顺序扫描读 |
| M04 | `memory_stride_write.c` | `memory_access_density` | 跨步写入 |

### B3. Branch-heavy
| ID | 文件名 | 主要目标特征 | 说明 |
|---|---|---|---|
| M05 | `branch_predictable.c` | `branch_density` | 高可预测分支 |
| M06 | `branch_unpredictable.c` | `branch_density` | 伪随机分支 |

### B4. Call-heavy
| ID | 文件名 | 主要目标特征 | 说明 |
|---|---|---|---|
| M07 | `call_chain.c` | `call_density` | 深层直接调用链 |
| M08 | `call_indirect.c` | `call_density`, `indirect_call_count` | 函数指针调用 |

### B5. Host-interaction-heavy
| ID | 文件名 | 主要目标特征 | 说明 |
|---|---|---|---|
| M09 | `host_time_loop.c` | `time_call_count`, `hostcall_density` | 高频时间查询 |
| M10 | `host_getcwd_loop.c` | `filesystem_call_count`, `hostcall_density` | 高频路径查询 |

### B6. Allocation-heavy
| ID | 文件名 | 主要目标特征 | 说明 |
|---|---|---|---|
| M11 | `alloc_small_objects.c` | `alloc_call_count` | 高频小对象分配释放 |
| M12 | `alloc_bulk_buffer.c` | `alloc_call_count`, `memory_access_density` | 大块缓冲区分配与访问 |

---

## C. Pilot 数据集建议

建议先进行一轮小规模 pilot：

- PolyBench/C：10~15 个
- CoreMark：2~3 个变体
- 微基准：12 个
- 真实 workload：5~10 个

总量约：30~40 个程序。

目标：
1. 检查标签分布是否失衡；
2. 验证特征能否稳定提取；
3. 观察特征与性能比值的初步关系；
4. 先做一次简单模型试验（如逻辑回归/随机森林）。

---

## D. 正式实验数据集建议

正式实验阶段建议扩充到：

- PolyBench/C：15~30 个
- CoreMark：3~4 个变体
- 微基准：12~24 个（每类 2~4 个追加变体）
- 真实 workload：10~20 个

总量可达到 60~100 个程序。

---

## E. benchmark 设计原则

1. 所有程序都应可独立编译运行；
2. 输入应固定或可由脚本统一传参；
3. 避免空循环等被编译器完全优化掉的无效程序；
4. Host-heavy 程序应特别注意缓存、临时文件和运行环境噪声；
5. benchmark 选择应服务于“结构覆盖”，而不是单纯追求数量。
