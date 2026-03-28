# Features V2 设计文档

## 一、优化总览

基于 V1（22 个特征）在 42 个样本上的实验分析（Cohen's d、Pearson r、箱线图、散点矩阵），
对特征集进行以下四类操作：


| 操作     | 数量     | 说明               |
| ------ | ------ | ---------------- |
| 删除     | 3      | 区分力接近 0 或严重冗余    |
| 保留     | 13     | 经验证有效            |
| 修改     | 2      | 调整计算方式或语义        |
| 新增     | 5      | 针对已知盲点引入         |
| **合计** | **18** | 从 22 → 18，精简且更有效 |


---

## 二、删除的特征（3 个）及原因

### `indirect_call_count` — 删除

- **实验依据**：Cohen's d ≈ 0，Pearson r ≈ 0
- **根本原因**：42 个样本中绝大多数值为 0（微基准和 PolyBench kernel 均无间接调用）
- **结论**：当前样本中是无效噪声。若后续引入含函数指针的真实 workload 可重新加入。

### `loop_count` — 删除

- **实验依据**：与 `basic_block_count` 高度正相关，独立解释力弱
- **根本原因**：基于文本模式匹配回边的估算不精确，引入噪声；信息已被 `basic_block_count` + `max_loop_depth` 覆盖
- **结论**：冗余，删除。

### `function_count` — 删除

- **实验依据**：42 个样本中绝大多数值为 1，方差极低，无区分力
- **根本原因**：微基准和 PolyBench kernel 均为单文件单函数；多文件场景才有意义
- **结论**：当前阶段无效，删除。留作真实 workload 阶段备用。

---

## 三、修改的特征（2 个）

### `hostcall_density` — 修改分母


|     | V1                                          | V2                                              |
| --- | ------------------------------------------- | ----------------------------------------------- |
| 定义  | `hostcall_count / max(call_instr_count, 1)` | `hostcall_count / max(ir_instruction_count, 1)` |


**改进原因**：V1 分母为 `call_instr_count`，当程序无任何 call 指令时分母强制为 1，
导致即使只有 1 次 hostcall，density 也为 1.0，语义失真。
V2 改为 `ir_instruction_count`，与 `compute_density`、`memory_access_density` 等保持
相同的归一化基准，语义一致。

### `time_call_count` — 保留但标记为异常值敏感

**V1 问题**：Pearson r=0.70，但主要由 `host_time_loop` 单个异常样本驱动，泛化性差。

**V2 处理**：保留（有真实语义：时间查询调用多 → WASI 调用开销显著），
但建模时使用鲁棒归一化（RobustScaler），不单独用作决策依据。

---

## 四、新增的特征（5 个）

### F1: `avg_bb_size` = `ir_instruction_count / max(basic_block_count, 1)`

**动机**：V1 同时保留 `ir_instruction_count` 和 `basic_block_count`，两者高度正相关（r ≈ 0.95），
边际信息量有限。比值才是真正独立的信息：平均每个基本块多少条指令。

- `avg_bb_size` 大 → 长直线段、低分支密度 → wasmtime JIT 更容易局部优化
- `avg_bb_size` 小 → 控制流碎片化 → wasm 跳转开销大

**预期**：similar/wasm-better 组的 `avg_bb_size` 高于 native-better 组。

### F2: `compute_to_memory_ratio` = `compute_density / max(memory_access_density, 1e-6)` ⭐ 核心

**动机**：V1 最重要发现——`compute_density` Cohen d=-0.65（non-native 更高），
`memory_access_density` Cohen d=+0.66（native-better 更高）。两者方向相反，
说明**高计算密度 + 低访存密度**的组合是 similar 的核心判别式。

这个比值直接编码该组合：值越大 → 越接近"纯计算、少访存" → 越可能是 similar。

**物理直觉**：wasmtime Cranelift JIT 对纯计算循环优化好；
每次访存需要 wasm 线性内存边界检查，是主要结构性开销。
compute/memory 比值高 → wasm 开销占比低 → ratio 接近 1.0。

**预期**：similar 组的 `compute_to_memory_ratio` 显著高于 native-better 组。

### F3: `load_store_ratio` = `load_count / max(store_count, 1)`

**动机**：V1 分别保留 `load_count` 和 `store_count`，两者正相关，冗余。
比值捕获**访存方向偏好**：读密集 vs 写密集。
wasm 对 store 的边界检查代价通常高于 load，
`load_store_ratio` 低（store 多）的程序 wasm 相对更慢。

### F4: `call_to_bb_ratio` = `call_instr_count / max(basic_block_count, 1)`

**动机**：V1 的 `call_density`（call/total_inst）反映调用在所有指令中的比重，
但更有意义的是每个控制流单元平均多少次调用。
高 `call_to_bb_ratio` 意味着每个基本块都有调用，wasm 函数表查找开销密集分布，
比 `call_density` 对 wasm 调用机制开销的刻画更直接。

### F5: `hostcall_per_bb` = `hostcall_count / max(basic_block_count, 1)`

**动机**：`hostcall_count` 绝对数量在不同规模程序间不可比；
`hostcall_per_bb` 反映每个控制流单元的 WASI 边界切换频率，
是衡量宿主交互密度的更精准指标。
wasm 的 WASI 调用是跨越 wasm/host 边界，每次有固定开销。

---

## 五、V2 完整特征表（18 个）

> 提取来源：IR = 从 LLVM IR 提取；SRC = 从 C 源代码提取；DERIVED = 由其他特征派生计算


| Feature                   | 定义                                                   | 来源      | 类型     | 设计动机                                                    |
| ------------------------- | ---------------------------------------------------- | ------- | ------ | ------------------------------------------------------- |
| `ir_instruction_count`    | LLVM IR 总指令数                                         | IR      | 规模     | 程序整体规模与静态复杂度；Cohen d=+0.77                              |
| `basic_block_count`       | 基本块数量                                                | IR      | CFG规模  | 控制流切分程度；Cohen d=+0.64                                   |
| `avg_bb_size`             | `ir_instruction_count / basic_block_count`           | DERIVED | CFG密度  | 平均基本块大小；大→长直线段→JIT易优化；小→控制流碎片化                          |
| `compute_instr_count`     | 算术/逻辑相关指令总数                                          | IR      | 指令统计   | 计算工作量绝对值                                                |
| `compute_density`         | `compute_instr_count / ir_instruction_count`         | IR      | 密度     | 计算密集程度；Cohen d=-0.65，non-native组更高，是similar核心信号         |
| `memory_instr_count`      | `load+store+atomicrmw+cmpxchg` 数量                    | IR      | 指令统计   | 内存访问规模；Cohen d=+0.62                                    |
| `memory_access_density`   | `memory_instr_count / ir_instruction_count`          | IR      | 密度     | 内存访问压力；wasm线性内存边界检查开销来源；Cohen d=+0.66                   |
| `compute_to_memory_ratio` | `compute_density / max(memory_access_density, 1e-6)` | DERIVED | 比值     | ⭐ similar判别核心；编码"高计算、低访存"组合；值越大越接近similar               |
| `load_store_ratio`        | `load_count / max(store_count, 1)`                   | DERIVED | 比值     | 访存方向偏好；store多→wasm写边界检查代价高→更倾向native-better             |
| `branch_instr_count`      | 条件/无条件跳转、switch、select 统计                            | IR      | 指令统计   | 控制流密度；Cohen d=+0.66                                     |
| `branch_density`          | `branch_instr_count / ir_instruction_count`          | IR      | 密度     | 控制流复杂度；间接对应分支处理代价                                       |
| `call_instr_count`        | `call` / `invoke` 指令数                                | IR      | 指令统计   | 函数调用频度                                                  |
| `call_to_bb_ratio`        | `call_instr_count / max(basic_block_count, 1)`       | DERIVED | 比值     | 每基本块平均调用次数；比call_density更直接刻画wasm函数表查找开销                |
| `max_loop_depth`          | 最大循环嵌套深度（源码扫描估算）                                     | SRC     | CFG复杂度 | 区分浅层循环与深层嵌套数值核                                          |
| `hostcall_count`          | host-related API 调用总数（IO+时间+文件系统）                    | SRC     | host交互 | 宿主交互强度绝对值；WASI调用次数                                      |
| `hostcall_density`        | `hostcall_count / max(ir_instruction_count, 1)`      | DERIVED | host交互 | hostcall在整个程序中的比重；分母统一为ir_instruction_count（V2修改）       |
| `hostcall_per_bb`         | `hostcall_count / max(basic_block_count, 1)`         | DERIVED | host交互 | 每控制流单元的WASI边界切换频率；衡量host交互密度                            |
| `alloc_call_count`        | `malloc/calloc/realloc/free` 等调用数                    | SRC     | 内存管理   | 动态分配密集程序；wasm堆内存管理有额外开销                                 |
| `time_call_count` ⚠️      | 时间相关API调用数（time、gettimeofday等）                       | SRC     | host交互 | Pearson r=0.70但异常值敏感（host_time_loop拉动）；建模时用RobustScaler |


> **说明**：
>
> - `load_count` 和 `store_count` 仍在 IR 提取阶段计算（用于派生 `load_store_ratio`），但不直接输入模型
> - `io_call_count`、`filesystem_call_count` 信息已包含在 `hostcall_count` 中，单独输入产生冗余，V2 不再独立使用
> - ⚠️ 标记表示该特征异常值敏感，建模时需特殊处理

