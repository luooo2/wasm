- 控制流
  - 基本块平均大小
  - 基本块数量
  - 基本块出度
  - 最大循环嵌套深度
  - 循环体指令数
  - 分支指令数
  - 分支密度
- 计算
  - 计算指令数（算数/逻辑相关指令总数）
  - 计算密度
- 内存访问
  - Load/Store 指令占比
  - 内存指令数
- 函数 & 系统调用
  - 函数数量
  - 函数调用密度
  - 调用指令数
  - 间接调用数
  - 调用密度
  - 系统调用指令数（io+时间+文件系统）
  - 系统调用密度
- io
  - io 调用数量
  - io 密度
- 总指令数
- 计算/内存比值
- 调用/基本块比值


| **特征类别**  | **特征名称**              | **定义 / 计算方式**                             | **提取来源**    | **类型** | **设计动机 (Motivation)**                          |
| --------- | --------------------- | ----------------------------------------- | ----------- | ------ | ---------------------------------------------- |
| **总规模**   | `total_instr_count`   | LLVM IR 指令总数                              | IR          | 规模     | 衡量程序整体规模与静态复杂度。                                |
| **控制流**   | `basic_block_count`   | 基本块（Basic Block）的总数量                      | IR          | CFG 规模 | 反映程序控制流的切分程度与复杂性。                              |
|           | `avg_bb_size`         | `total_instr_count / basic_block_count`   | DERIVED     | CFG 密度 | 平均基本块大小。大则长直线段多，易于 JIT 优化；小则控制流碎片化。            |
|           | `avg_bb_out_degree`   | 所有基本块出度的平均值                               | IR/CFG      | 控制流    | 反映逻辑分支的密集程度。                                   |
|           | `max_loop_depth`      | 最大循环嵌套层数                                  | IR/LoopInfo | 结构     | 衡量计算核心的拓扑深度，影响缓存命中率与并行潜力。                      |
|           | `loop_instr_count`    | 处于循环体内的指令总数                               | IR/LoopInfo | 规模     | 反映程序中“热点区域”的静态覆盖范围。                            |
|           | `br_instr_count`      | 分支指令 (Branch/Switch) 总数                   | IR          | 指令统计   | 衡量程序逻辑判断的绝对数量。                                 |
|           | `br_density`          | `br_instr_count / total_instr_count`      | DERIVED     | 比例     | 反映程序是非线性逻辑密集型（如解析器）还是线性计算型。                    |
| **计算**    | `compute_instr_count` | 算术、逻辑及位运算指令总数                             | IR          | 指令统计   | 衡量程序执行计算任务的绝对工作量。                              |
|           | `compute_density`     | `compute_instr_count / total_instr_count` | DERIVED     | 比例     | 表征程序是否为计算密集型 (Compute-bound)。                  |
| **内存访问**  | `mem_instr_count`     | Load 与 Store 指令的总和                        | IR          | 指令统计   | 衡量程序对内存子系统的压力。                                 |
|           | `ls_ratio`            | `mem_instr_count / total_instr_count`     | DERIVED     | 比例     | 指示内存访问频率，用于评估访存带宽需求。                           |
| **函数/系统** | `func_count`          | 函数定义总数                                    | IR          | 规模     | 衡量模块化程度及过程间分析的成本。                              |
|           | `call_instr_count`    | Call 指令（含直接调用）总数                          | IR          | 指令统计   | 衡量函数间的交互频繁度。                                   |
|           | `indirect_call_count` | 通过函数指针进行的间接调用数                            | IR          | 复杂度    | 衡量控制流图（CFG）的不确定性及去虚化难度。                        |
|           | `call_density`        | `call_instr_count / total_instr_count`    | DERIVED     | 比例     | 反映代码的抽象层次；高密度通常意味着频繁的上下文切换。                    |
|           | `syscall_count`       | 系统调用相关指令（IO、文件、时间）                        | IR/Lib      | 行为     | 衡量程序与操作系统内核交互的频率。                              |
|           | `syscall_density`     | `syscall_count / total_instr_count`       | DERIVED     | 比例     | 区分用户态计算密集与系统态行为密集任务。                           |
| **IO**    | `io_call_count`       | 涉及输入输出（读写、网络）的调用数                         | IR/Lib      | 行为     | 衡量 IO 密集程度，评估程序执行中的阻塞潜力。                       |
|           | `io_density`          | `io_call_count / total_instr_count`       | DERIVED     | 比例     | 表征程序是 IO-bound 还是 CPU-bound。                   |
| **复合比率**  | `compute_mem_ratio`   | `compute_instr_count / mem_instr_count`   | DERIVED     | 效率     | **关键指标**：类似计算强度（Operational Intensity），判断瓶颈位置。 |
|           | `call_bb_ratio`       | `call_instr_count / basic_block_count`    | DERIVED     | 结构     | 衡量每个基本块内的平均调用数，反映控制流受外部调用影响的程度。                |


