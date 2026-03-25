# feature_table

| Feature                 | 定义                                           | 类型     | 设计动机                                |
| ----------------------- | -------------------------------------------- | ------ | ----------------------------------- |
| `ir_instruction_count`  | LLVM IR 总指令数                                 | 规模     | 反映程序整体规模与静态复杂度                      |
| `function_count`        | 函数数量                                         | 规模     | 反映模块化程度与调用组织复杂度                     |
| `basic_block_count`     | 基本块数量                                        | CFG规模  | 反映控制流切分程度                           |
| `compute_instr_count`   | 算术/逻辑相关指令总数                                  | 指令统计   | 衡量计算工作量                             |
| `compute_density`       | `compute_instr_count / ir_instruction_count` | 密度     | 反映计算密集程度；纯计算 workload 理论上更接近 native |
| `memory_instr_count`    | `load + store + atomicrmw + cmpxchg` 数量      | 指令统计   | 衡量内存访问规模                            |
| `memory_access_density` | `memory_instr_count / ir_instruction_count`  | 密度     | 反映内存访问压力；与线性内存、边界检查等因素相关            |
| `load_count`            | `load` 指令数                                   | 指令统计   | 区分读取主导型 workload                    |
| `store_count`           | `store` 指令数                                  | 指令统计   | 区分写入主导型 workload                    |
| `branch_instr_count`    | 条件/无条件跳转、`switch`、`select` 统计                | 指令统计   | 衡量控制流密度                             |
| `branch_density`        | `branch_instr_count / ir_instruction_count`  | 密度     | 反映控制流复杂度，间接对应分支处理代价                 |
| `call_instr_count`      | `call` / `invoke` 指令数                        | 指令统计   | 衡量函数调用频度                            |
| `call_density`          | `call_instr_count / ir_instruction_count`    | 密度     | 反映调用开销暴露程度                          |
| `indirect_call_count`   | 间接调用数（函数指针/间接目标）                             | 调用特征   | 对应 Wasm `call_indirect` 等潜在额外开销     |
| `loop_count`            | 近似循环数（通过回边/循环元数据/文本模式估计）                     | CFG复杂度 | 反映迭代结构强度                            |
| `max_loop_depth`        | 近似最大循环嵌套深度                                   | CFG复杂度 | 区分浅层循环和深层嵌套数值核                      |
| `hostcall_count`        | host-related API 调用总数                        | host交互 | 刻画程序与外部环境交互强度                       |
| `hostcall_density`      | `hostcall_count / max(call_instr_count, 1)`  | host交互 | 区分纯计算程序与系统交互型程序                     |
| `io_call_count`         | 文件/输出相关 API 调用数                              | host交互 | 衡量 I/O 压力                           |
| `time_call_count`       | 时间相关 API 调用数                                 | host交互 | 识别高频时间查询型 workload                  |
| `filesystem_call_count` | 路径、目录、文件系统 API 调用数                           | host交互 | 识别文件系统依赖                            |
| `alloc_call_count`      | `malloc/calloc/realloc/free` 等调用数            | 内存管理   | 区分动态分配密集程序                          |


**从源代码提取的特征**：
* hostcall_count - 所有宿主调用总数（IO+时间+文件系统）

* io_call_count - IO相关调用（printf、read、open等）

* time_call_count - 时间相关调用（time、gettimeofday等）

* filesystem_call_count - 文件系统调用（stat、opendir、chdir等）

* alloc_call_count - 内存分配调用（malloc、free、realloc等）

* max_loop_depth - 最大循环嵌套深度
> 通过扫描源代码中的for、while、do关键字和{、}括号 维护嵌套深度计数器，记录最大深度

其他特征是从IR中提取的