## Phase 2B 引入 PolyBench/C 子集说明

  

1. 选取合适的8-12个kernel

2. 改造 polybench 代码使其能适应本项目

3. 重写 `build_polybench_benchmarks.py` 对 polybench 程序进行处理

4. 运行改造后的选取的 polybench 子集得到实验结果（`labels_polybench.csv`）

  

【注意】先快速测试 1-2 个kernel，确认流程能跑通，再批量引入  

【注意】每一步留有相应的操作说明（如选取 kernel 列表及原因、polybench 改造说明等）

  

---

  

## 一、PolyBench 代码改造说明

  

### 改造了哪些文件？

  

**只新增了一个文件，原始 PolyBench 代码（gemm.c、gemm.h 等）零修改。**

  

| 文件 | 操作 | 说明 |

|------|------|------|

| `utilities/polybench_stub.c` | **新增** | 替代 `polybench.c`，见下方详细说明 |

| `utilities/polybench.h` | 不修改 | 原始头文件，包含宏定义 |

| `*/gemm.c`、`*/gemm.h` 等所有 kernel 文件 | **不修改** | 全部使用原始文件 |

  

### 为什么需要改造？

  

原始 `utilities/polybench.c` 包含如下 Linux 专有 API，在 WASI 下不支持：

  

```c

#include <sys/time.h>      // gettimeofday

#include <sys/resource.h>  // getrusage

#include <sched.h>         // sched_setaffinity

```

  

本项目采用**外部计时**方案（`run_benchmarks.py` 通过 Python subprocess 记录进程总时间），

完全不需要 PolyBench 内置计时器，因此可以用最小 stub 替代。

  

### polybench_stub.c 的设计原理

  

`polybench.h` 中，计时相关宏在**不定义 `-DPOLYBENCH_TIME` / `-DPOLYBENCH_PAPI`** 时

已经展开为**空宏**（什么都不做）：

  

```c

// polybench.h 默认路径（第 176-178 行）

#define polybench_start_instruments   // 空，不展开任何代码

#define polybench_stop_instruments    // 空

#define polybench_print_instruments   // 空

```

  

因此 `polybench_stub.c` **只需提供三个实际符号**，其余计时函数根本不会被调用：

  

| 符号 | 在原 polybench.c 中的作用 | stub 实现 |

|------|--------------------------|----------|

| `polybench_flush_cache()` | 刷 LLC 缓存，`polybench.h` 中有 extern 声明，链接时必须存在 | 空函数（no-op） |

| `polybench_alloc_data(n, elt_size)` | 堆分配，`POLYBENCH_2D_ARRAY_DECL` 等宏调用 | `malloc(n * elt_size)` |

| `polybench_free_data(ptr)` | 释放内存，启用 padding 时调用 | `free(ptr)` |

  

> **注意**：`polybench_start_instruments` 等是**宏**，不是函数。

> 不能在 stub 里把它们定义成函数，否则宏展开后会出现解析错误（这正是第一版报错的原因）。

  

---

  

## 二、编译说明

  

### 编译命令对比

  

**原始 PolyBench 官方方式：**

```bash

clang -O2 -I utilities utilities/polybench.c gemm/gemm.c -o gemm

```

  

**本项目改造后（以 gemm 为例）：**

  

```bash

# 1. native 二进制

clang -O2 -DMEDIUM_DATASET \

  -I data/polybench-c-4.2.1-beta/utilities \

  -I data/polybench-c-4.2.1-beta/linear-algebra/blas/gemm \

  data/polybench-c-4.2.1-beta/utilities/polybench_stub.c \

  data/polybench-c-4.2.1-beta/linear-algebra/blas/gemm/gemm.c \

  -o data/build/poly_gemm.native

  

# 2. wasm 二进制

/opt/wasi-sdk/bin/clang -O2 -DMEDIUM_DATASET \

  -target wasm32-wasip1 \

  -I data/polybench-c-4.2.1-beta/utilities \

  -I data/polybench-c-4.2.1-beta/linear-algebra/blas/gemm \

  data/polybench-c-4.2.1-beta/utilities/polybench_stub.c \

  data/polybench-c-4.2.1-beta/linear-algebra/blas/gemm/gemm.c \

  -o data/build/poly_gemm.wasm

  

# 3. LLVM IR（只编译 kernel .c，保证 IR 是纯 kernel 逻辑）

clang -O2 -DMEDIUM_DATASET \

  -I data/polybench-c-4.2.1-beta/utilities \

  -I data/polybench-c-4.2.1-beta/linear-algebra/blas/gemm \

  -S -emit-llvm \

  data/polybench-c-4.2.1-beta/linear-algebra/blas/gemm/gemm.c \

  -o data/build/poly_gemm.ll

```

  

**关键差异：**

- `polybench.c` → `polybench_stub.c`（规避 WASI 不兼容 API）

- 增加 `-DMEDIUM_DATASET`（控制数据集规模）

- 增加两个 `-I` 路径（utilities 目录 + kernel 自身目录）

- 不定义 `-DPOLYBENCH_TIME` / `-DPOLYBENCH_PAPI`（保持计时宏为空）

- IR 编译不链接 stub（IR 只需要 kernel 逻辑，不需要运行时符号）

  

### 数据集规模选择

  

PolyBench 通过宏控制矩阵/向量维度：

  

| 宏 | gemm NI/NJ/NK | 预估 native 运行时间 |

|----|--------------|--------------------|

| `MINI_DATASET` | 20/25/30 | < 1 ms（计时误差大，不适用）|

| `SMALL_DATASET` | 60/70/80 | ~1-10 ms |

| `MEDIUM_DATASET` | 200/220/240 | ~10-500 ms ✓ |

| `LARGE_DATASET` | 1000/1100/... | > 5 s（太慢）|

  

选用 **`MEDIUM_DATASET`**，在 30 次重复测量下运行时间稳定，计时误差可控。

  

---

  

## 三、选取的 Kernel 列表及原因

  

### 选取策略

  

1. **覆盖不同访存/计算模式**：探索特征空间中 native-better 的不同子区域

2. **优先选 ratio 可能偏低的 kernel**：为将来在更小规模下产生 `similar` 样本铺垫

3. **避免含 sqrt/pow 的 kernel**：防止 wasm libm 行为差异干扰测量

  

### Kernel 列表（共 8 个）

  

| 输出名 | 原始路径 | 类别 | 选取原因 |

|--------|---------|------|----------|

| `poly_gemm` | `linear-algebra/blas/gemm/gemm.c` | BLAS | 标准矩阵乘 α·A·B+β·C；深层嵌套循环；基准参照 |

| `poly_gemver` | `linear-algebra/blas/gemver/gemver.c` | BLAS | 矩阵乘+向量运算混合；compute + memory 混合型 |

| `poly_gesummv` | `linear-algebra/blas/gesummv/gesummv.c` | BLAS | 对称矩阵-向量乘；结构比 gemm 轻，规律访存 |

| `poly_2mm` | `linear-algebra/kernels/2mm/2mm.c` | kernels | 两次连续矩阵乘；ratio=1.40，本批最接近 similar |

| `poly_atax` | `linear-algebra/kernels/atax/atax.c` | kernels | Ax + A^Tx 模式；两种访存方向交替，memory 特征丰富 |

| `poly_jacobi_1d` | `stencils/jacobi-1d/jacobi-1d.c` | stencils | 1-D 模板计算；高 memory_access_density，规则 streaming |

| `poly_jacobi_2d` | `stencils/jacobi-2d/jacobi-2d.c` | stencils | 2-D 模板计算；深层嵌套，探索 max_loop_depth 特征 |

| `poly_floyd_warshall` | `medley/floyd-warshall/floyd-warshall.c` | medley | 三层嵌套+条件分支；branch_density 高；ratio=1.61，第二低 |

  

### 未选取的 kernel 及原因

  

| kernel | 未选原因 |

|--------|----------|

| `cholesky`, `gramschmidt`, `correlation`, `covariance` | 含 `sqrt()` / `pow()`，wasm libm 行为可能与 native 存在差异 |

| `deriche` | 含大量浮点 exp/div，计时波动较大 |

| `nussinov` | 动态规划+密集条件分支，留作后续批次 |

| `heat-3d`, `seidel-2d` | 3D stencil 在 MEDIUM 规模下运行过慢（> 10 s）|

| `lu`, `ludcmp` | 三角分解 + if 分支密集，留作后续 |

  

---

  

## 四、新增文件说明

  

| 文件 | 说明 |

|------|------|

| `data/polybench-c-4.2.1-beta/utilities/polybench_stub.c` | 替代 polybench.c 的最小 stub，兼容 native + wasm |

| `src/build_polybench_benchmarks.py` | PolyBench 专用编译脚本，支持 `--dataset`、`--kernels` 参数 |

| `src/extract_polybench_features.py` | PolyBench 专用特征提取脚本（处理子目录 .c 与 data/build/*.ll 的路径映射）|

  

---

  

## 五、实验结果

  

所有 8 个 kernel 编译结果（native / IR / wasm）全部成功（8/8）。

30 次重复测量结果：

  

| kernel | native median (ms) | wasm median (ms) | ratio | label |

|--------|--------------------|-----------------|-------|-------|

| poly_gemm | 9.08 | 21.53 | 2.37 | native-better |

| poly_gemver | 5.57 | 11.90 | 2.14 | native-better |

| poly_gesummv | 4.60 | 11.60 | 2.52 | native-better |

| poly_2mm | 22.72 | 31.78 | 1.40 | native-better |

| poly_atax | 5.35 | 12.28 | 2.29 | native-better |

| poly_jacobi_1d | 3.86 | 11.77 | 3.05 | native-better |

| poly_jacobi_2d | 14.52 | 32.45 | 2.23 | native-better |

| poly_floyd_warshall | 68.84 | 110.56 | 1.61 | native-better |

  

> 8 个 kernel 全部为 native-better，ratio 集中在 1.4~3.1。

> poly_2mm（1.40）和 poly_floyd_warshall（1.61）最接近 similar 阈值，

> 可考虑用更小数据集规模重测以产生 similar 样本。