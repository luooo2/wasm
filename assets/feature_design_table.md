# 特征设计表

## 设计原则

本研究聚焦于在固定编译链与执行环境下，利用静态结构特征解释并预测程序在 `WebAssembly` 与 `native` 之间的相对性能趋势。特征设计遵循以下原则：

1. 以**静态可提取**为前提，不依赖动态 profiling。
2. 以**程序结构**为主，而不是与特定 runtime 强绑定的内部指标。
3. 采用“**LLVM IR 主特征 + Wasm 模块补充特征**”双层设计。
4. 优先选择可解释、可统计、可批量提取的特征，便于后续做相关性分析和树模型建模。

## 特征分层

- **主特征层（LLVM IR）**：刻画源程序的控制流、计算、内存访问、调用与 host interaction 结构。
- **补充特征层（Wasm 模块）**：刻画 Wasm 代码体积、导入函数与静态内存初始化等特征。

## 特征设计表

| Feature | 定义 | 提取层 | 类型 | 设计动机 |
|---|---|---|---|---|
| `ir_instruction_count` | LLVM IR 总指令数 | LLVM IR | 规模 | 反映程序整体规模与静态复杂度 |
| `function_count` | 函数数量 | LLVM IR | 规模 | 反映模块化程度与调用组织复杂度 |
| `basic_block_count` | 基本块数量 | LLVM IR | CFG规模 | 反映控制流切分程度 |
| `avg_bb_size` | `ir_instruction_count / basic_block_count` | LLVM IR | CFG规模 | 反映基本块平均长度，辅助判断控制流碎片化 |
| `compute_instr_count` | 算术/逻辑相关指令总数 | LLVM IR | 指令统计 | 衡量计算工作量 |
| `compute_density` | `compute_instr_count / ir_instruction_count` | LLVM IR | 密度 | 反映计算密集程度；纯计算 workload 理论上更接近 native |
| `memory_instr_count` | `load + store + atomicrmw + cmpxchg` 数量 | LLVM IR | 指令统计 | 衡量内存访问规模 |
| `memory_access_density` | `memory_instr_count / ir_instruction_count` | LLVM IR | 密度 | 反映内存访问压力；与线性内存、边界检查等因素相关 |
| `load_count` | `load` 指令数 | LLVM IR | 指令统计 | 区分读取主导型 workload |
| `store_count` | `store` 指令数 | LLVM IR | 指令统计 | 区分写入主导型 workload |
| `branch_instr_count` | 条件/无条件跳转、`switch`、`select` 统计 | LLVM IR | 指令统计 | 衡量控制流密度 |
| `branch_density` | `branch_instr_count / ir_instruction_count` | LLVM IR | 密度 | 反映控制流复杂度，间接对应分支处理代价 |
| `call_instr_count` | `call` / `invoke` 指令数 | LLVM IR | 指令统计 | 衡量函数调用频度 |
| `call_density` | `call_instr_count / ir_instruction_count` | LLVM IR | 密度 | 反映调用开销暴露程度 |
| `indirect_call_count` | 间接调用数（函数指针/间接目标） | LLVM IR | 调用特征 | 对应 Wasm `call_indirect` 等潜在额外开销 |
| `loop_count` | 近似循环数（通过回边/循环元数据/文本模式估计） | LLVM IR | CFG复杂度 | 反映迭代结构强度 |
| `max_loop_depth` | 近似最大循环嵌套深度 | LLVM IR | CFG复杂度 | 区分浅层循环和深层嵌套数值核 |
| `cyclomatic_complexity` | 近似圈复杂度 `E - N + 2P` 的简化估计 | LLVM IR | CFG复杂度 | 反映程序结构复杂性 |
| `hostcall_count` | host-related API 调用总数 | LLVM IR/源码符号 | host交互 | 刻画程序与外部环境交互强度 |
| `hostcall_density` | `hostcall_count / max(call_instr_count, 1)` | LLVM IR/源码符号 | host交互 | 区分纯计算程序与系统交互型程序 |
| `io_call_count` | 文件/输出相关 API 调用数 | LLVM IR/源码符号 | host交互 | 衡量 I/O 压力 |
| `time_call_count` | 时间相关 API 调用数 | LLVM IR/源码符号 | host交互 | 识别高频时间查询型 workload |
| `filesystem_call_count` | 路径、目录、文件系统 API 调用数 | LLVM IR/源码符号 | host交互 | 识别文件系统依赖 |
| `alloc_call_count` | `malloc/calloc/realloc/free` 等调用数 | LLVM IR/源码符号 | 内存管理 | 区分动态分配密集程序 |
| `imported_function_count` | Wasm 模块导入函数数 | Wasm 模块 | 模块元数据 | 反映 Wasm 对 host/runtime 依赖程度 |
| `exported_function_count` | Wasm 模块导出函数数 | Wasm 模块 | 模块元数据 | 反映模块接口规模 |
| `data_section_size` | Wasm 数据段总字节数 | Wasm 模块 | 模块元数据 | 反映静态初始化数据规模 |
| `memory_segment_init_total_size` | Wasm 内存段初始化总大小 | Wasm 模块 | 内存初始化 | 刻画 Wasm 启动时静态数据搬运成本 |
| `wasm_binary_size` | `.wasm` 文件大小（字节） | Wasm 模块 | 体积 | 反映模块规模与潜在解析/加载成本 |

## 特征提取建议

### 1. LLVM IR 主特征
建议使用以下流程：

```bash
clang -S -emit-llvm -O2 benchmark.c -o benchmark.ll
```

然后对 `.ll` 文本进行轻量统计。优点是：
- 统一、可解释；
- 同时适用于 native/wasm 源程序的共同结构描述；
- 不依赖复杂 LLVM pass，适合快速原型。

### 2. Wasm 模块补充特征
建议作为第二阶段增强项，主要提取：
- import/export 数量；
- 数据段大小；
- 模块体积；
- memory/table 相关元信息。

如后续环境允许，可借助 `wasmparser` 或 `wasm-tools` 解析。

## V1 推荐建模特征集

为避免一开始特征过多导致分析分散，建议优先使用如下 V1 集合：

- `ir_instruction_count`
- `function_count`
- `basic_block_count`
- `compute_density`
- `memory_access_density`
- `branch_density`
- `call_density`
- `indirect_call_count`
- `loop_count`
- `max_loop_depth`
- `cyclomatic_complexity`
- `hostcall_count`
- `hostcall_density`
- `io_call_count`
- `time_call_count`
- `alloc_call_count`
- `imported_function_count`（可选）
- `wasm_binary_size`（可选）

## 备注

本研究的目标不是追求对执行时间的精确数值预测，而是通过这些可解释的静态特征，建立对 `native-better / similar / wasm-better` 三类相对性能趋势的解释与分类能力。
