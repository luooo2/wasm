# WRCF: ML-Guided Multi-Runtime Orchestrator for WebAssembly Services

Canfeng Zheng∗, Yuxin $\mathrm { S u ^ { \dagger } }$ , Zigui Jiang†, Dan $\mathrm { L i } ^ { \dagger }$ , Weizhe Zhang‡ and Zibin Zheng† ∗School of Software Engineering, Sun Yat-sen University and Peng Cheng Laboratory, China zhengcf3 $@$ mail2.sysu.edu.cn 

†School of Software Engineering, Sun Yat-sen University, Zhuhai, China, {suyx35, jiangzg3, lidan263, zhzibin}@mail.sysu.edu.cn 

‡ Harbin Institute of Technology and Peng Cheng Laboratory, China, wzzhang@hit.edu.cn 

Abstract—WebAssembly, Wasm for short, has emerged as a pivotal technology for portable and efficient cloud native computing, yet its performance and deployment efficiency are constrained by the inherent limitations of single-runtime execution paradigms. Existing approaches predominantly rely on a single Wasm runtime to handle diverse workloads, disregarding the heterogeneous design philosophies and optimization tradeoffs of different runtimes. To address this gap, we propose a Wasm runtime coordination framework (WRCF), with dynamic runtime selection that leverages the complementary strengths of multiple Wasm runtimes through a machine learning-guided strategy. By employing a random forest model to classify optimal runtimes based on workload feature vectors, our system dispatches Wasm modules to specialized runtimes, achieving performance improvements. Furthermore, we implement this framework within the containerd ecosystem, introducing optimizations for pipelining code fetching and compiling with container startup acceleration, and centralizing compilation. Based on benchmark results, experiments demonstrate that coordinated use of multiple runtimes achieves a $1 0 \%$ to ${ \bf 6 0 \% }$ improvement in execution performance compared to employing a single runtime alone, while reducing the memory footprint by about $50 \%$ and affecting startup throughput by about $20 \%$ through optimizations. 

Index Terms—WebAssembly, Serverless Computing, WebAssembly Runtime, Containerd. 

# I. INTRODUCTION

W EBASSEMBLY [1] is a low-level binary format de-signed to enable high-performance code execution in signed to enable high-performance code execution in web browsers, originally proposed in 2015 [18], [46]. It allows developers to write programs in languages like C, $\mathrm { C } { + } { + }$ or Rust and run them at near native speed, effectively overcoming JavaScript performance limitations [19], [39], [45]. As a machine-friendly format more compact than traditional language representations, Wasm delivers superior execution efficiency. Although initially created for browser environments, the introduction of WASI (WebAssembly System Interface) and Wasm runtimes has expanded its capabilities to browser and non-browser contexts [38], [41], [42]. Offering near-native execution speed, portability, and secure sandboxing, Wasm has been the preferred execution format for modern Functionas-a-Service (FaaS) platforms [21], it now powers serverless functions across major cloud services including AWS Lambda and Azure. 

The execution of Wasm in non-web and serverless environments primarily relies on WASI and Wasm Runtime [22], [24]. 

WASI empowers Wasm with system interaction capabilities, enabling Wasm code to make system calls. The Wasm Runtime is responsible for creating the execution environment for Wasm, where the code runs on a stack-based virtual machine (VM) [20]. The runtime implements various execution modes including interpretation, Just-In-Time (JIT) compilation, and Ahead-Of-Time (AOT) compilation [43]. Currently, numerous Wasm Runtimes have emerged [24], with notable examples such as Wasmtime [8], WasmEdge [9], and Wasmer [10]. These runtimes serve as the core components for executing Wasm code outside web browsers, handling critical tasks including bytecode execution, resource allocation, and WASIbased system interactions. The design quality of the runtime significantly impacts performance of the Wasm code execution [40]. Therefore, selecting an efficient Wasm Runtime is crucial for enhancing function execution efficiency in serverless platforms. These runtimes continuously optimize key components like compilation pipelines, memory management, and system calls, progressively narrowing the performance gap between Wasm and native execution. 

In container ecosystems like containerd, executing Wasm functions requires creating specialized Wasm containers that include a Wasm runtime VM. Since traditional container execution processes don’t natively support this container type, Runwasi introduced a container-shim specifically designed for Wasm containers, enabling Kubernetes and containerd to execute Wasm functions in serverless environments. Similarly, Docker proposed Docker+Wasm to facilitate Wasm application execution within Docker containers. To optimize Wasm deployment, the Wasm Open Container Initiative(OCI) Artifact [7] specification was developed, introducing dedicated layer types for Wasm that fully leverage its cross-platform compatibility and lightweight nature. This standardization allows OCI [11] images to efficiently package Wasm modules while maintaining their platform-independent characteristics and minimal footprint. 

Currently research efforts primarily focus on leveraging Wasm in serverless platforms to enhance function execution efficiency [25] [28] [29]. By designing Wasm-specific frameworks, these solutions effectively harness Wasm lightweight nature and inherent security features to optimize serverless workloads [44]. The lightweight characteristic enables rapid cold starts and efficient resource utilization, and the sandboxed 

execution environment provides strong isolation for multitenant function execution. 

In WebAssembly code analysis, researchers employ both static and dynamic analysis techniques to evaluate the performance and security of Wasm bytecode. Dynamic analysis involves instrumenting Wasm instructions to enable flexible execution tracing, allowing for precise identification of performance bottlenecks during runtime. Static analysis techniques are applied to thoroughly verify the security properties of Wasm bytecode, ensuring memory safety, control flow integrity, and compliance with security policies before execution. 

However, these researches predominantly focus on using a single runtime in isolation or applying code analysis techniques solely to monitor Wasm bytecode performance and security, failing to capitalize on the distinct execution advantages offered by different runtimes. Various Wasm runtimes are designed with fundamentally different architectures and optimizations tailored for specific scenarios—leading to significant performance variations when executing the same workload across different runtimes. For instance, Wasmtime typically excels in long-running, compute-intensive tasks due to its optimized Cranelift compiler, while WasmEdge demonstrates higher throughput for I/O-bound workloads owing to its lightweight async runtime design. 

Rather than relying on a single runtime type, a more efficient approach would be to leverage multiple runtimes strategically, deploying each workload to the runtime best suited for its characteristics. This multi-runtime orchestration can improve the overall system efficiency and resource utilization when executing diverse Wasm tasks. 

This paper proposes the WRCF, an innovative system that orchestrates diverse Wasm workloads across multiple runtimes by leveraging their distinct architectural advantages. The framework employs static bytecode feature analysis, including instruction counts and imported functions, combined with a random forest-based prediction model to dynamically select the optimal runtime for each task. And based on the unified runtime coordinator in WRCF, we rapidly instantiating the appropriate Wasm VM for the task. Implemented on containerd via runwasi extensions, WRCF introduces two key optimizations: parallelizing Wasm module retrieval and compiling with container creation to minimize container startup, and centralizing compilation in a dedicated daemon process that eliminates per-container compiler overhead while accelerating Wasm bytecode processing. This coordinated approach achieves superior performance by matching workload characteristics with specialized runtime capabilities while maintaining low-latency operation through efficient feature-based prediction. The primary contributions of this paper are summarized as follows: 

• We introduce a novel approach to runtime collaboration that moves beyond traditional single-runtime systems. By developing a task feature model that maps workloads to their optimal runtimes, we enable coordinated use of multiple runtimes to improve Wasm execution performance. 

• We propose the WRCF hierarchical orchestrator, a novel two-layer architecture combining a random forest-based runtime selector and a lightweight runtime coordinator 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/28fb06389b2269952035994060d6aed77cc268f564bcdf5fbc06eaa01d739672.jpg)



Fig. 1. Wasm Runtime Execution Time on designed benchmark tasks.


to support efficient execution of multi-runtime collaboration. 

• We introduce two process optimizations to enhance container startup performance in containerd for Wasm modules: 1) concurrent execution of Wasm module retrieval and container creation, and 2) centralized compilation in a dedicated daemon process. These improvements reduce startup latency by $30 \% - 5 0 \%$ and enhance resource utilization efficiency by $60 \%$ on average. 

The rest of this paper is organized as follows: Section II introduces background and some related work. Sections III and IV introduce the proposed frameworks and optimization methods. Section V conducts performance evaluation experiments and analyses of experiments results. Section VI concludes the paper. 

# II. RELATED WORK

# A. Wasm in serverless

Although Wasm is initially designed for browsers, its lightweight and secure characteristics have led many efforts to focus on leveraging Wasm’s capabilities for serverless computing. Relying on the Wasm runtime and WASI, Wasm applications can run independently on the system and interact with the operating system. Faasm [25] presents a serverless framework that leverages Wasm’s lightweight software isolation capabilities. The framework combines cgroups and namespaces to enable efficient stateful serverless computing. FunLess [29] capitalizes on Wasm lightweight and sandboxed nature, enabling efficient function execution on devices with limited resources, especially for private edge cloud systems. Sledge [28] introduces a Wasm-based serverless framework optimized for high-density multi-tenancy, low startup times, and short-lived computations, demonstrating up to four times higher throughput compared to existing solutions. By introducing RPC interfaces that avoid unnecessary network-layer communication for Wasm component module, Cofaas [27] optimizes the execution of Wasm functions. Zhao et al. [26] integrated OpenWhisk [3] with a Wasm runtime to leverage Wasm’s lightweight isolation capabilities, achieving significant reduction in cold start latency for confidential serverless computing. Similarly, ZKWASM [36] integrates zeroknowledge proofs with a Wasm runtime, enabling verifiable and trustless execution of serverless functions while preserving 


TABLE I WASM RUNTIME BENCHMARK TESTS


<table><tr><td>Wasm Task Name</td><td>Task Type</td><td>Description</td></tr><tr><td>hash.wasm</td><td>Compute-intensive</td><td>Hash on data blocks</td></tr><tr><td>matrix-multi.wasm</td><td>Compute-intensive</td><td>Calculate the product of two matrices</td></tr><tr><td>transpose.wasm</td><td>Memory access-intensive</td><td>Transpose vector buffer</td></tr><tr><td>mem_alloc.wasm</td><td>Memory access-intensive</td><td>Allocate and release memory buffer</td></tr><tr><td>file_read.wasm</td><td>I/O-intensive</td><td>Read file with size randomly from 1MB to 10MB</td></tr><tr><td>file_write.wasm</td><td>I/O-intensive</td><td>Write file with size randomly from 1MB to 10MB</td></tr></table>

data confidentiality in cloud and edge environments. However, none of these approaches consider the performance differences between multiple Wasm runtimes and their varying efficiency across different types of Wasm workloads. 

# B. Wasm code analysis

The analysis of Wasm code is crucial for optimizing performance and ensuring security [31]. To address diverse use cases, various testing frameworks have been proposed for analyzing Wasm binary code.These frameworks are designed to tackle specific challenges such as dynamic analysis and static safety checks. The Wizard [33] Research Engine introduces the first non-intrusive dynamic instrumentation system for Wasm, enabling flexible and efficient analysis through bytecode-level probes while minimizing performance overhead and ensuring consistency across multiple analyses. The paper [32] introduces wasabi, a pioneering general purpose framework for dynamic analysis of Wasm, providing a high-level API that simplifies the implementation of complex analysis while addressing unique challenges such as tracing typepolymorphic instructions through an on-demand hook. Wasmprechk [35] is a superset of Wasm that utilizes indexed types for static constraint checking, enabling the removal of dynamic safety checks and achieving an average improvement at runtime of $1 . 7 1 \mathrm { x }$ with minimal overhead, while ensuring type and memory safety and maintaining backward compatibility with standard Wasm. Using dynamic program analysis to identify vulnerabilities, including integer overflows and memory vulnerabilities, the paper design WASMDYPA [34] to automate the bug detection framework for Wasm programs. While these approaches primarily focus on analyzing Wasm modules for reliability and security concerns, they offer limited optimization for overall performance improvement. 

# C. Practices in Cloud Native Systems

In Wasm Containerized Environments, the integration of Wasm with container runtimes and orchestration platforms has gained application in cloud-native ecosystems. The paper [23] extends container runtime to support orchestration of Wasm modules execution on Kubernetes. Runwasi [2], a containerized shim for Wasm, enables the seamless execution of Wasm modules as containers using WASI. This bridges the gap between traditional containerized workloads and Wasm-based applications, also allowing Kubernetes to natively manage Wasm modules through standard OCI artifacts. By decoupling Wasm execution from language-specific runtimes, runwasi 

enhances portability and resource efficiency in multi-tenant clusters. To enable the execution of Wasm applications alongside traditional Linux containers, Docker [4] has introduced Docker+Wasm [5], which provides native support for running Wasm modules as lightweight containers. This integration is primarily achieved by utilizing the extensible architecture of containerd and the Runwasi shim. In addition, there are open-source serverless platforms that support Wasm-based serverless functions. For example, OpenFunction [6] leverages Wasmedge to provide a serverless environment for deploying and managing Wasm functions. 

# III. MULTI-RUNTIME AND PREDICTION MODEL

In this section, we first present the motivation for employing a collaborative runtime to execute diverse tasks. We then introduce a collaborative framework designed to take advantage of the strengths of different runtimes. This framework consists of two key components: a runtime selector and a runtime coordinator. The runtime selector uses a random forest-based model to extract task features and predict the optimal runtime. The runtime coordinator then activates the corresponding Wasm runtime’s VM to execute the target Wasm module. 

# A. Motivation

The performance of Wasm modules in serverless environments is heavily influenced by the underlying Wasm runtimes, as their design and implementation directly affect execution efficiency. Over time, Wasm runtimes have adopted different architectural approaches and optimization strategies, resulting in diverse performance characteristics across various types of Wasm workloads. As a result, certain Wasm runtimes may demonstrate superior performance for specific categories of tasks compared to others. 

To examine the performance characteristics of different Wasm runtimes, we designed a set of Wasm benchmark tasks, which are grouped into three main categories: computeintensive, I/O-intensive, and memory access-intensive, as outlined in Table I. We assessed the performance of several Wasm runtimes by measuring the total execution time for each benchmark task. The results of these evaluations are presented in Fig. 1. 

The results indicate that no single runtime consistently outperforms the others across all benchmark tasks. Instead, there are notable differences in performance depending on the nature of the workload. For instance, in matrix computation tasks, 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/938afd87ec6d74d6691e906c85681a3b780111b4290c7074b39783b2a6488d10.jpg)



Fig. 2. WRCF Architecture On Runwasi.


Wasmedge is approximately eight times slower than Wasmtime and Wasmer. Conversely, in file I/O operations, Wasmedge demonstrates greater execution efficiency compared to both Wasmtime and Wasmer. 

The varying performance of Wasm runtimes across different Wasm workloads has inspired us to propose a collaborative runtime selection strategy that dynamically leverages the strengths of individual runtimes based on the characteristics of Wasm modules. By matching each Wasm file to its optimal runtime, we aim to maximize execution efficiency while compensating for the limitations of any single runtime. 

Furthermore, through practical observations, we identified opportunities to optimize the containerd container startup process for Wasm-specific requirements. Traditional containerd workflows, originally designed for OS-dependent containers, are not tailored to Wasm lightweight nature and dependency solely on the Wasm runtime. To address this, we redesigned the Wasm container launch flow by pre-initializing runtime resources with centralized compilation and pipelining Wasm layer loading and compiling with container initialization. 

# B. WRCF Architecture

In this section, we present the fundamental design of WRCF framework as shown in Fig. 2. To dynamically select the optimal runtime for each task and efficiently execute Wasm modules through runtime VMs, we designed WRCF to coordinate multiple runtimes, leveraging the strengths of different Wasm runtimes. And to ensure consistent dynamic execution for Wasm workloads, we provide a unified execution runtime with multiple Wasm runtimes. 

Unlike using a single Wasm runtime in isolation, WRCF abstracts and integrates multiple Wasm runtimes to leverage their respective strengths for executing diverse Wasm tasks. To determine the most suitable runtime for each Wasm task and setup the target runtime VM to execute the task, WRCF comprises two key components: a runtime selector and a runtime coordinator. 

The runtime selector consists of two core components: feature extraction and optimal runtime selection. The feature extraction module takes Wasm bytecode as input, analyzes its static characteristics such as instruction patterns and control flow structures, and transforms these attributes into a feature 

matrix. The runtime selection engine then processes this feature matrix, leveraging predefined performance profiles to match the Wasm module with the most suitable runtime engine that demonstrates optimal execution efficiency for the given workload characteristics as much as possible. This process enables data-driven runtime selection by correlating code features with historical performance metrics across different Wasm runtimes. 

The runtime coordinator abstracts heterogeneous Wasm runtimes into a unified invocation process. Despite architectural differences across runtimes, all implementations share fundamental execution phases: loading Wasm bytecode, initializing execution environments, compiling modules, instantiating instances, and invoking exported functions. The coordinator standardizes these operational interfaces across various Wasm VMs. It accepts both the target Wasm bytecode and the runtime recommendation of the selector , then dynamically instantiates the corresponding Wasm VM (e.g., spawning a Wasmedge instance when selected) to execute the workload through this normalized workflow. 

# C. Design Of Runtime Selector

We now detail the implementation and design considerations of the runtime selector. Given that this component may introduce non-trivial overhead, we carefully optimized both feature extraction and model selection to minimize performance impact. 

For feature extraction, we deliberately focus on static code analysis rather than dynamic profiling. While dynamic information could provide more precise semantic insights, obtaining it typically requires Wasm code instrumentation, which incurs prohibitive latency at minimum several dozen milliseconds, and up to $1 6 3 \times$ the original task execution time [32]. Such overhead is generally unacceptable in serverless scenarios. Even with sophisticated partial instrumentation strategies, the incurred latency remains unpredictable and workload-dependent. 

In contrast, static feature extraction achieves microsecondlevel speed by analyzing the raw bytecode without execution. To balance efficiency and expressiveness, we selected 27 statistical code features, detailed in Table II, that capture key Wasm execution patterns without complex control and data 


TABLE II 27 WASM CODE STATIC FEATURES


<table><tr><td>Features Type</td><td>Features</td><td>Quantity</td></tr><tr><td rowspan="5">Module Section Metadata</td><td>type_section_count, imported_function_count</td><td>10</td></tr><tr><td>none Imported_function_count, import_fd_function_count</td><td></td></tr><tr><td>export_function_count, data_section_count</td><td></td></tr><tr><td>data_section_size, table_section_count</td><td></td></tr><tr><td>tableFuncref_table_size, parse_cost_time</td><td></td></tr><tr><td rowspan="2">Instruction Type Distribution</td><td>instruction_count, arithmeticInstruction_count</td><td>3</td></tr><tr><td>average_parameter_count</td><td></td></tr><tr><td rowspan="6">Control Flow Complexity</td><td>branch Instruction_count, if_block Instruction_count</td><td>10</td></tr><tr><td>loop Instruction_count, br_table Instruction_count</td><td></td></tr><tr><td>complexity, call_direct_function_count</td><td></td></tr><tr><td>call_direct_fd_function_count, call_indirect Instruction_count</td><td></td></tr><tr><td>call_direct POTENTIAL Imported Function count</td><td></td></tr><tr><td>call_direct POTENTIAL none Imported function count</td><td></td></tr><tr><td rowspan="2">Memory Usage Patterns</td><td>memory_segment_count, memory_segment_init_total_size</td><td>4</td></tr><tr><td>memory Instruction_count, load/store Instruction_count</td><td></td></tr></table>

flow analysis. Notably, we avoided full static program analysis, as even these techniques introduce tens of millisecond-level delays. Our simplified approach preserves feature extraction at microsecond scale while still maintaining workload characterization validity to some extent. 

These 27 code features encompass module section metadata, distribution of instruction types, control flow statistics, and memory usage information, as detailed in Table II. These readily extractable features are obtained through the wasmparser tool [17], which efficiently analyzes and parses Wasm bytecode to extract various static characteristics including module sections, function blocks, and instruction contents. We utilize these features to represent the execution profile of Wasm modules, converting them into vectorized formats to serve as model inputs. The wasmparser capability to systematically decompose Wasm binaries enables comprehensive static analysis while maintaining processing efficiency, making it particularly suitable for runtime prediction tasks where quick feature extraction is crucial. 

To minimize cold-start latency while effectively learning the mapping between code features and optimal runtime selection, we implemented a decision tree-based random forest model for runtime prediction. We use random forest classifier due to its robustness in handling multiple-dimensional data and inherent capability to evaluate feature importance. Compared to deep learning alternatives, this approach offers superior interpretability and significantly faster training and prediction speeds, typically completing within submillisecond time frames. The model operates by taking a 27-dimensional feature vector extracted from Wasm bytecode as input, and outputs the predicted optimal runtime based on historical execution performance data. 

The key advantages of random forest model include: (1) The ability to learn quantifiable feature-runtime correlations, for instance, modules with high Wasm multiplication instruction frequency show $8 \times$ better performance on Wasmtime, Wasmer versus Wasmedge as shown in Fig. 1; (2) Training focus exclusively on minimizing Wasm execution time 

through supervised learning with 〈feature vectors, fastestruntime〉 pairs; (3) Dynamic adaptability to new runtimes through simple model retraining, eliminating the need for manual performance rule engineering or empirical analysis of runtime architectures. This data-driven approach automatically captures runtime performance characteristics without requiring deep technical analysis of each Wasm VM internal design.It could maintain compatibility with diverse and evolving runtime implementations. 

# D. Runtime Coordinator Architecture And Containerd Shim Implementation

The Runtime Coordinator serves as a unified abstraction layer that integrates heterogeneous Wasm runtimes, like Wasmedge and Wasmtime through a standardized invocation pipeline. 

The runtime coordinator employs a three-tier architecture illustrated in Fig. 3, comprising a coordination abstraction layer with standardized external APIs, concrete runtime library implementations, and dynamically instantiated Wasm VM execution instances. This architecture dynamically selects target runtimes by processing two key input parameters, the raw Wasm bytecode to be executed and a predefined identifier specifying the Wasm runtime to be utilized. 

Upon invocation, the coordinator abstraction layer routes these inputs to the corresponding runtime library implementation, which then spawns a dedicated Wasm VM to execute the module. This design enables seamless incorporation of new runtimes vendors simply implement the predefined interface contract includeing module loading and initialization without requiring modifications to the upper-layer scheduler. By decoupling runtime-specific details through this adapter pattern, the coordinator maintains little overhead during VM creation while supporting cross-runtime execution parity. 

To enable containerized execution through containerd, we developed a coordinated runtime library based on runwasi [2], a project that supports running Wasm workloads via containerd. Containerd primarily manages container states and 

images, while the container startup process is handled by corresponding containerd-shim processes. By leveraging containerd to select appropriate containerd-shim implementations during container execution, we implemented containerd-shimwrcf on top of runwasi to support coordinated runtime invocation. When containerd requests container creation, simply configuring it to use our containerd-shim-wrcf enables the coordinated runtime to execute the Wasm container image. This containerd-shim-wrcf incorporates the runtime selector component. After containerd launches the shim process, it first parses the image to extract the target Wasm bytecode, then uses the runtime selector to determine the most suitable Wasm runtime for the code, and finally creates the corresponding Wasm VM through the coordinated runtime to execute the Wasm bytecode from the container image. 

For the runtime selector implementation on shim, we deploy the trained random forest model within a dedicated daemon process. When the containerd-shim-wrcf extracts code features, it communicates with this daemon via Unix domain sockets to request optimal runtime predictions. The daemon spawns dedicated handler threads upon receiving requests, processes predictions using the pre-trained model, and returns results to the runtime selector. This architecture enables all containerd instances on a node to share the same trained prediction model through their respective containerd-shimwrcf instances while maintaining efficient inter-process communication through lightweight Unix socket connections. 

To optimize execution performance, we implemented AOT compilation support in containerd-shim-wrcf to address the significant overhead of repeatedly compiling Wasm bytecode. Since Wasm runtimes typically support executing precompiled AOT formats, each with their own specific format, for instance, Wasmedge could generate .so files while Wasmtime produces .cwasm files, our solution automatically pre-compiles Wasm bytecode into the corresponding runtime AOT format after selecting the optimal runtime. This cached compilation enables subsequent executions to directly load the pre-compiled artifacts, eliminating redundant recompilation. The containerd-shim-wrcf manages this process through standardized pre-compilation interfaces that each integrated Wasm runtime must implement, ensuring seamless AOT execution while maintaining compatibility across different runtimespecific compilation formats. This reduces cold-start latency for frequently executed Wasm workloads while preserving the benefits of runtime-specific optimizations in the compiled artifacts. 

# IV. OPTIMIZATION

To optimize Wasm container performance within execution workflow of containerd, we implemented two key enhancements targeting container startup latency and resource efficiency: pre-initializing runtime resources with centralized compilation, and pipelining Wasm module loading and compiling with container initialization. 

While existing execution flow of containerd was originally designed for traditional containers, the emergence of Wasm workloads revealed optimization opportunities. The ecosystem 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/f8056a8389d29e2aad82f28139cb44409d5d009077167cd427befdbf7ac29e79.jpg)



Fig. 3. Runtime Coordinator Layers.


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/364a1120016a7305ba331f020ec0d2e8d5c55eb12fd6ffc0464f94eff582747b.jpg)



Fig. 4. Wasm container execution flow process: (a) original container flow (b) with pipelining loading and compiling flow


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/d96eb7324b0cc91d98d7029b34d7f3f28bc78e007c03f24a2a39e0e2268e100d.jpg)



Fig. 5. Wasm container execution flow time: (a) original container flow time (b) with pipelining loading and compiling flow time


has responded with Wasm OCI artifact layout specifications [7], which extend the OCI image format to natively support packaging Wasm modules and components, enabling containerd to handle Wasm workloads while maintaining compatibility with existing container toolchains. 

Our improvements specifically address the unique characteristics of Wasm execution, particularly the compilation overhead and resource initialization patterns. We realize this by implementing shared compilation caching across container instances and modifying workflow of containerd to parallelize module loading and compiling with container setup. 

A. Pre-initializing Runtime Resources With Centralized Compilation 

This section introduces our approach to optimizing Wasm compilation through a daemon process that preloads compilation resources and centralizes Wasm bytecode compilation. When Wasm runtimes execute bytecode via JIT or AOT compilation, like Wasmtime uses Cranelift, they require initialization of compilation environments. In conventional Wasm container execution, each container that loads Wasm bytecode must independently initialize and load these compilers. Loading compilers for every container is a redundant process since the same Wasm runtime uses identical compilers regardless of the specific Wasm code being compiled. This per-container compiler initialization creates resource waste, as compiler resource demands often exceed those required for actual Wasm execution. Furthermore, compilers typically retain allocated resources throughout the entire lifecycle of container rather than releasing them post-compilation, as Wasm runtimes assume potential future compilation needs. 

To eliminate this redundancy, we implement a centralized compilation leveraging our daemon process. The daemon preloads and initializes compiler resources for multiple Wasm runtimes during its startup phase. When containers request execution, instead of handling compilation locally in container, they delegate this task to the daemon. The daemon, having already loaded the necessary compilers, can immediately precompile incoming Wasm bytecode into AOT format using the target designated Wasm container runtime before delivering the optimized code by shared memory for execution. While this approach sacrifices some JIT flexibility by exclusively using AOT execution, it provides compensating advantages: compiled artifacts can be cached in containerd for reuse, and AOT typically delivers faster execution speeds than JIT. 

In this way, we allow containers to focus exclusively on maintaining execution environments for Wasm code while offloading compilation responsibilities to the specialized daemon with the compiler already loaded. The daemon could maintain one compiler instance per Wasm runtime, serving compilation requests across all containers, or multiple compilers per Wasm runtime. Compared to per-container compiler initialization, this eliminates redundant resource loading while actually improving compilation speed since the prewarmed compilers in daemon avoid cold start overhead. For compiler warm-up, we initialize compilers during daemon startup by processing several generic Wasm files, this proactively loads necessary resources into process memory, ensuring optimal performance when handling actual compilation requests. By the initialized compilers, we decouple compilation resource management from container execution, achieving both better resource utilization and faster container startup times. 

# B. Pipelining Wasm Layer Loading And Compiling With Container Initialization

To optimize the container creation flow for Wasm workloads, we’ve implemented parallel execution of Wasm code loading and compiling with container process initialization, 

eliminating the previous sequential dependency where container creation has to wait for Wasm bytecode retrieval from containerd. In traditional container execution, container runtimes like containerd manage image pulling, where images contain all necessary binaries, data, and configuration files. For Wasm OCI artifacts, the Wasm bytecode isn’t directly embedded in the image file but managed by containerd, enabling platform independence by storing only one copy in containerd. Containerd could also caches precompiled Wasm AOT code for exact Wasm runtime to avoid compilation. 

The current Wasm container creation flow requires the shim process to first pull Wasm bytecode from containerd into its memory before forking the container process. However, Wasm bytecode retrieval isn’t strictly necessary for container initialization.It only needs to be loaded into container memory before Wasm function execution really begins. This sequential approach creates bottlenecks, especially during multiple container creation when multiple shim processes simultaneously request Wasm files from containerd. Although Wasm bytecode is lightweight, typically tens of KB, rarely exceeding a few MB, the cumulative overhead becomes significant. 

Our solution implements true parallelization between container initialization and Wasm module retrieval. As shown in Fig. 4, we have modified the original Wasm container creation workflow in Fig. 4 (a) by implementing a pipelining flow for both the Wasm module loading and compilation processes in Fig. 4 (b). We still use a dedicated daemon process that is responsible for communication between shim containerd and containers. Before container creation, we asynchronously send container request information to this daemon, which immediately spawns background threads to pull either raw Wasm bytecode or precompiled AOT artifacts from containerd. After confirming the daemon request, we proceed directly with the creation and initialization of the container process. 

The daemon process needs to rapidly transfer the retrieved Wasm bytecode or AOT code into the container memory space after fetching. We implement a shared memory communication approach, which requires the container and daemon process to share an IPC namespace. The timeline in Fig. 5 shows how pipelining optimization primarily reduces latency by parallelizing the formerly sequential container pull and compilation phases. Upon receiving container creation requests, the daemon process initiates a parallel workflow , first retrieving the target Wasm bytecode from containerd while simultaneously performing AOT compilation, then provisioning shared memory space to persist the compilation artifacts for immediate container access.Both writing compilation results to shared memory space and requesting containers can be completed within 1-2 ms. After successful initialization, the container accesses the shared memory region to retrieve the compiled Wasm bytecode and begins immediate execution. 

To ensure proper synchronization, we use a readiness handshake protocol between the container and daemon process. During initialization before executing Wasm code, the container enters a polling loop awaiting the daemon for response flag. The daemon writes the compiled Wasm module into the shared memory space and sets a ready flag upon completion. Only after detecting this flag does the container proceed to 

read the Wasm code in shared memory for execution. 

While sharing IPC space between containers and the daemon process may introduce security concerns, Wasm memory safety guarantees and the sandboxing of Wasm Runtime ensure the Wasm code cannot randomly access this shared memory region. Furthermore, our Linux implementation leverages the /dev/shm memory-backed filesystem for shared memory operations, utilizing memory-mapped files to achieve better performance. 

# V. EXPERIMENTS

This section presents experimental evaluations of the performance of WRCF. We begin by detailing our test environment setup, including the benchmark suite and performance metrics used for measurement. Subsequently, we present and analyze the experimental results obtained from our testing. The evaluation demonstrates the effects of WRCF in optimizing Wasm workload execution through multiple runtime coordination while improving startup latency, throughput, and resource utilization compared to conventional single-runtime approaches. Our experiments further examine the framework overhead and scalability characteristics. All experiments are carried out on an Ubuntu VMWare virtual machine with a host CPU of i7-14700F, where the virtual machine was configured with 24 vCPUs and 24GB of memory. The operating system kernel version is Linux-5.15. We test based on the containerd version of 1.75. 

# A. Experimental Setup

Benchmarks: To evaluate the effectiveness of the collaborative runtime approach, we collected a total of 169 Wasm tasks. The test suite includes Wasm code sets from Polybench, CoreMark, Wasm-R3, Wasm-Score, Ostrich, and Libsodium, covering both standard C benchmarks and real-world Wasm workloads. Here is the introduction to each Wasm task set: 

• Polybench: The Polybench, originally a C-specific benchmark suite, comprises 30 numerical computing tasks featuring static control flow and spanning diverse domains such as linear algebra, image processing, physics simulation, dynamic programming, and statistical computing. 

• CoreMark [14]: CoreMark, a single-core CPU benchmark. We produced four Wasm variants with identical logic but differing iteration counts to analyze performance scaling. 

• Wasm-R3 [37]: Wasm-R3 includes 27 browser-based applications derived from the research paper [37]. Leveraging record-and-replay techniques, it transforms environment-dependent Wasm applications into selfcontained executables, enabling their use as practical benchmarks. 

• Wasm-Score [13]: Wasm-Score is a benchmarking tool designed to evaluate platform performance for executing Wasm programs. The benchmark suite includes various computational workloads, such as cryptographic processing and gaming. We only take parts of the Wasm tasks in the whole Wasm-Score set. 


TABLE III MODEL PREDICTION ACCURACY


<table><tr><td>Runtime Selector</td><td>Accuracy</td></tr><tr><td>WRCF based Random Forest</td><td>82.8%</td></tr><tr><td>Random</td><td>44.1%</td></tr></table>

![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/0169f1bdc9a2bd709bc682e2dd47f4289c6bb072b4d3662bc1c582b8e8025b6a.jpg)



Fig. 6. Comparison of Single-Runtime and collaborative runtime performance on Benchmarks, with Optimal Average time


• Ostrich [15]: Ostrich is a specialized benchmark suite developed to assess programming language performance in numerical computing applications, including linear algebra operations and backpropagation algorithms. The test suite comprises 12 carefully selected Wasm programs. 

• Libsodium [16]: Libsodium is an optimized cryptographic library that provides robust security primitives through a concise API. The library implements core cryptographic functions, including authenticated encryption, secure key exchange, digital signatures, and modern password hashing, while enforcing secure default configurations and memory safety guarantees. This benchmark includes a total of 70 programs based on Libsodium. 

To facilitate testing, we have embedded the test parameters within these programs, similar to Wasm-R3 benchmark, enabling standalone execution without mandatory requirement for runtime parameter input. 

We employ the WASI-SDK [12] compilation toolchain for benchmarks not originally in Wasm format to convert standalone test programs written in $\mathrm { C } / \mathrm { C } { + + }$ into executable Wasm binaries. The uniform compilation parameters are adopted to ensure testing consistency. 

Baseline: We conducted performance comparisons between our collaborative runtime approach and traditional singleruntime solutions. In our cooperative runtime environment, we primarily utilized Wasmtime, Wasmedge, and Wasmer as the core execution engines. For the container execution workflow, we benchmark against the native runwasi implementation in containerd. 

Metrics: We evaluate the function execution platform using several key metrics: task execution time, memory consumption, container setup time, and throughput. These measurements demonstrate the effects of our collaborative runtime approach in handling diverse workloads. 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/4bd6169d40ba47500786def9b595ba8e3f519bbab5c2da566c04a3742b673071.jpg)



Fig. 7. Comparison of single runtime and collaborative multiple runtime performance on testsets


# B. Experimental Results

Based on the established experimental setup, we conduct a series of systematic evaluations: First, we perform comprehensive measurements to assess both the effects of our collaborative runtime concept and the predictive accuracy of our random forest-based model. Subsequently, we evaluated the operational performance of the WRCF framework implemented on the collaborative runtime architecture. In parallel, we designed controlled comparative experiments to precisely measure the impact of two specific optimizations applied to the containerd startup workflow. Through exact analysis of the collected experimental data across these experiments, we derived conclusive findings regarding system performance improvements and optimization effectiveness. 

1)Prediction Of Radom Forest Runtime Selector: This experimental study aims to verify the effectiveness of the collaborative runtime concept and demonstrate that our random forest-based prediction model can efficiently identify the most suitable Wasm runtime target by analyzing 27 code features. The execution time of Wasm code serves as the primary metric for evaluating runtime performance superiority. The execution time of the Wasm file contains two parts: the compilation time and the execution time of the Wasm function. We refer to only the Wasm function execution time. Since Wasmedge compilation is highly time-consuming and may impact analysis and the compiled results can be cached to skip recompilation during repeated Wasm executions. In this situation, the function execution time becomes the more critical metric to focus on. 

To initially investigate the performance advantages of the collaborative runtime approach for Wasm execution, we conducted experiments to measure the theoretical maximum reduction in execution time achievable through our cooperative runtime system. We compare with using individual standalone runtimes.The results are shown in Fig. 6. 

Fig. 6 illustrates the average task execution times across different runtimes in the benchmark. Wasmedge demonstrates the poorest performance, while Wasmtime shows optimal results that most closely approximate the collaborative runtime performance. Although Wasmtime outperforms others on most tasks, certain workloads exhibit better execution under Wasmedge or Wasmer, preventing Wasmtime from fully matching the collaborative scenario efficiency. On average, 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/0dcd29136ed8d2aa41ab5ea49351584adad7c4549f0a6e8898e7acd37e505878.jpg)



Fig. 8. Distribution of execution time on test set with different prediction type


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/63210eccb93a4246f43bcce280e6e2e13b628c4603d494ca36be2de640c7aa64.jpg)



Fig. 9. Comparison on average execution time of different prediction accuracy level


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/f6924bf5107701d6683622183e7f576cb39282dc3df72112b7361d244a8d9ec5.jpg)



Fig. 10. Model prediction time with various concurrent request level


the collaborative runtime achieves approximately 3 seconds of execution speed improvement compared to the best standalone runtime implementations. 

The experimental methodology employed an 8:2 random split of the 169 benchmarks into training and testing sets, with the trained random forest model evaluated for its accuracy in predicting optimal runtime targets within the collaborative runtime framework. We evaluate model accuracy based on its ability to predict the optimal runtime for given tasks. As shown in the Table. III, the model achieves $8 2 . 8 \%$ prediction accuracy on test sets, outperforming random selection average $4 4 . 1 \%$ , demonstrating runtime selection capabilities to some extent. Fig. 7 presents the average runtime execution time on 


TABLE IV FEATURE PERMUTATION IMPORTANCE TOP 10


<table><tr><td>Feature Name</td><td>Permutation Importance</td><td>Permutation Std</td><td>Description</td></tr><tr><td>br_tableInstruction_count</td><td>0.092</td><td>0.031</td><td>Count br_table Instruction</td></tr><tr><td>arithmeticInstruction_count</td><td>0.082</td><td>0.018</td><td>Count arithmetic Instruction</td></tr><tr><td>load/storeInstruction_count</td><td>0.081</td><td>0.022</td><td>Count load and store memory Instruction</td></tr><tr><td>call_direct_function_count</td><td>0.071</td><td>0.023</td><td>Count direct function call Instruction</td></tr><tr><td>loopInstruction_count</td><td>0.068</td><td>0.023</td><td>Count loop block</td></tr><tr><td>parse_cost</td><td>0.059</td><td>0.047</td><td>Time to parse module static info</td></tr><tr><td>instruction_count</td><td>0.056</td><td>0.024</td><td>Count total instruction</td></tr><tr><td>if_blockInstruction_count</td><td>0.053</td><td>0.027</td><td>Count if block</td></tr><tr><td>export_function_count</td><td>0.050</td><td>0.026</td><td>Count export function def</td></tr><tr><td>table FUNCREF_table_size</td><td>0.047</td><td>0.023</td><td>Size of table section</td></tr></table>

![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/eafcc642b71f56a10d782f5fa05d8fd970b173ffbda6b289098670ce95ce645e.jpg)



Fig. 11. Container startup time of Wasmtime container runtime


test sets. The results demonstrate that the model predicted execution times closely approximate the ideal collaborative runtime performance, exhibiting only marginal differences of tens of milliseconds. Comparative analysis reveals that while individual runtimes outperform the worst-case collaborative scenarios, each runtime exhibits distinct advantages for specific task types. 

Fig. 8 makes a further examination of Wasm workload distribution across runtimes and shows strong alignment between Wasmtime, optimal collaborative performance, and model predictions. Notably, Wasmtime demonstrates superior capability for longer-running tasks exceeding 20 seconds, confirming the model effects in matching code characteristics to appropriate runtime environments. 

The evaluation adopts a $5 \%$ execution time differential as the threshold for optimal runtime matching. Measurements encompass three scenarios: perfect matches, suboptimal matches (within $5 \%$ deviation), and wrong matches. Fig. 9 indicate that even suboptimal and wrong selections maintain competitive performance relative to the ideal collaborative case, with execution times remaining substantially shorter than worst-case scenarios. This demonstrates that the prediction model is good at maintaining satisfactory performance levels across various matching conditions while properly leveraging the strengths of individual runtime within the collaborative framework. 

To evaluate feature importance within different feature vectors, we measured permutation feature importance for each attribute, as quantified in Table IV. The table presents the 

top 10 features ranked by permutation importance, demonstrating that static instruction count features exhibit predictive relevance for the model. Notably, control flow instructions particularly br table jumps, computational operations, and memory access instructions emerge as the most influential features. The execution efficiency of these instructions may vary across different runtimes due to their distinct architectural designs and implementation approaches for handling various instruction types. 

2)Performance Of WRCF: This section evaluates the runtime performance improvement and overhead introduced by the WRCF execution workflow. The WRCF architecture requires Wasm code to undergo static feature extraction via wasmparser before execution, followed by optimal runtime target prediction using the random forest model, both stages contributing measurable latency. Experimental measurements in Fig. 10 reveal the model prediction experiment result. When handled by the dedicated model prediction daemon process, the random forest-based prediction maintains approximately 10ms latency under concurrent workloads while achieving microsecond-level response times in sequential scenarios. It is acceptable for container setup with the model implementation preserving near-instantaneous decision-making capabilities. The prediction result also could be labeled for Wasm image. The Wasm image with optimal runtime info could prevent undergoing prediction again. 

We implements two key optimizations to Wasm container startup process. We conduct related experiments about the container startup time and resource consumption. 

We define the startup time as the duration between container creation and the execution of the first Wasm function. For container startup time. The results are presented in the Fig. 11. This experiment compares the container startup duration of Wasmtime with and without the WRCF optimization strategy. As shown in the figure, the strategy reduces container startup time by $30 \% - 5 0 \%$ . This acceleration primarily stems from parallelizing container initialization and Wasm file compilation.Since Wasm compilation typically accounts for a substantial portion of the startup overhead, performing compilation concurrently with container launch enables faster overall startup. The Wasm-r3 task set with high startup time results from high compilation time. 

We conduct benchmarking of centralized compilation, 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/7e807b6074bcd564c21c3c385e9a142ff1f00923d4c90a00f9e837003679f547.jpg)



(a) Wasmedge


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/68b5c3927ed6cdf3e95b80dc2210760533a8b5d65c1e32d8023d564e3202a163.jpg)



(b) Wasmtime


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/04974f8e89a62a5ee38c79e2d6373d424ceccc7883bf83088d5bcbd10ba1acb0.jpg)



(c) Wasmer



Fig. 12. Compilation time comparison of Wasmedge, Wasmtime, and Wasmer on task sets


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/0bc53ce2d5b64265c21ed350165b3be81a1a7a7f1cce59d21fd1c93bf2ca82d3.jpg)



(a) Polybench


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/d7bec8612aff4947c2a365d21d1b926a7681b59773a29733e05121c01d799f0c.jpg)



(b) Ostrich


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/ecd5eccea60d166da7d0c1d81331da6c001eea01f3a1123cc982b36f1207e0a5.jpg)



(c) Wasm-score



Fig. 13. Compilation memory peak consumption of each runtime on benchmarks with a concurrency level of 10


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/5c7bc32340ee1d937c8470db3aa3a020269c69dbd365fd09e35c3d33abdf2dfc.jpg)



(a) Polybench


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/53800a7778bad5b06906b6bbcaace208a0581da79843dc656654ea7b5d7f8515.jpg)



(b) Wasm-r3



Fig. 14. Throughput of different shim container runtime on polybench and wasm-r3 benchmark. The shim container runtime is different with whether support multiple runtime and use WRCF optimization strategies


demonstrating measurable improvements in compilation speed. The experimental measurements shown in Fig. 12 compare compilation times between centralized and decentralized compilation approaches across different runtimes. The results clearly demonstrate that centralized compilation noticeably reduces compilation duration compared to decentralized compilation, with relatively consistent time savings observed across various Wasm code samples. This improvement comes primarily centralized compilation could preload and initialize compilation resources in advance. Taking Wasmtime as an example, its dependency on the Cranelift compiler means that the centralized approach eliminates the need for repeated loading when processing incoming Wasm code. The resource loading and initialization phase, which normally incurs fixed overhead regardless of Wasm code characteristics, gets mitigated through centralized compilation. 

To demonstrate the resource efficiency of centralized com-

pilation, we measured peak memory utilization during parallel compilation of correlated task sets of Polybench, Ostrich and Wasm-score. The Fig. 13 compares the maximum memory footprint across different task sets under varying runtime compilation strategies. The results demonstrate that compiler processes consume substantial memory resources. Centralized compilation significantly reduces memory usage spikes, achieving a $50 \% - 9 0 \%$ decrease in peak memory consumption. This reduction in peak memory pressure could enhances both the stability and security of system execution performance. In contrast to decentralized compilation where each Wasm file requires a dedicated compiler instance that releases memory immediately after compilation, WRCF centralized approach maintains persistent memory allocation. This pre-load compilation resource pool enables faster response to compilation requests, despite the sustained memory footprint. While WRCF centralized approach achieves lower peak memory through 

reused compilation resources typically enabling faster overall task completion, Wasmedge current compilation model lacks shared compiler support for concurrent multi-file compilation. This limitation introduces measurable compilation latency in Wasmedge environments.To prevent Wasmedge latency, we could reuse multiple fixed Wasmedge compilers to execute the Wasm file compilation. 

To evaluate the systemic performance impact of WRCF integration, we measured container task startup throughput across different Shim Container Runtime implementations. It is noted that the measurement specifically exclude Wasm function execution time, as it remains consistent across all container runtime environments. As shown in the Fig. 14, we conduct benchmarks using both the Polybench and Wasmr3 test suites. Since the introduction of multiple runtimes increases the Container Runtime binary size and thereby impacting startup latency, we design four distinct runtime configurations for comparison: 

• wrcfnoc-v1: with multiple runtime support and without WRCF optimization strategies; 

• wasmtime-v1: with single Wasmtime and without WRCF optimization strategies; 

• wrcf-v1: with multiple runtime support and with WRCF optimization strategies; 

• wasmtimewrcf-v1: with single Wasmtime and with WRCF optimization strategies. 

The results demonstrates that wrcfnoc-v1 with multiple runtime but no optimizations yields the lowest container startup throughput, while the optimized single-runtime configuration wasmtimewrcf-v1 achieves peak throughput performance. And comparisons among wrcfnoc-v1/wrcf-v1 and wasmtimev1/wasmtimewrcf-v1 reveal that the optimization strategies properly improve container startup throughput. This enhancement is particularly pronounced in PolyBench workloads where compilation time is short. Despite the inherent latency overhead from multiple runtime support, the optimized wrcfv1 configuration demonstrates higher throughput than baseline wasmtime-v1. 

# VI. CONCLUSION

We present WRCF, a novel framework that enables collaborative execution across multiple WebAssembly runtimes. The framework incorporates two key optimizations to reduce startup latency and improve resource efficiency. Our experimental evaluation shows that WRCF achieves better performance than single-runtime approaches by leveraging the complementary strengths of different runtimes. Future work will focus on improving runtime selection accuracy through dynamic execution context analysis and further optimizing the Wasm container initialization process. 

# REFERENCES



[1] WebAssembly, 2025. [Online]. Available: https://webassembly.org 





[2] Runwasi, “Runwasi: A project to facilitate running wasm workloads managed by containerd”, 2025. [Online]. Available: https://github.com/containerd/runwasi 





[3] Apache OpenWhisk, “Openwhisk: A Open Source Serverless Cloud Platform”, 2025. [Online]. Available: https://openwhisk.apache.org/ 





[4] Docker,2025. [Online]. Available: https://www.docker.com/ 





[5] Docker+Wasm, “Running Wasm applications alongside your Linux containers in Docker”, 2025. [Online]. Available: https://docs.docker.com/desktop/features/wasm/ 





[6] OpenFunction, “Openfunction: A cloud-native open-source FaaS platform”, 2025. [Online]. Available: https://openfunction.dev/ 





[7] Wasm OCI Artifact, “Wasm OCI Artifact: A OCI image format for Wasm that can be used across projects”, 2025. [Online]. Available: https://tagruntime.cncf.io/wgs/wasm/deliverables/wasm-oci-artifact/ 





[8] Wasmtime: A fast and secure runtime for WebAssembly, 2025. [Online]. Available: https://github.com/bytecodealliance/wasmtime 





[9] Wasmedge, 2025. [Online]. Available: https://github.com/WasmEdge 





[10] Wasmer, 2025. [Online]. Available: https://github.com/wasmerio/wasmer 





[11] Open Container Initiative, 2025. [Online]. Available: https://opencontainers.org/about/overview/ 





[12] Wasi-Sdk Github,”Wasi-Sdk: Using Clang And LLVM with wasilibc”,2025. [Online]. Available: https://github.com/WebAssembly/wasisdk 





[13] Wasm-Score,”WasmScore aims to benchmark platform performance when executing WebAssembly outside the browser.”, 2025. [Online]. Available: https://github.com/bytecodealliance/wasm-score 





[14] CoreMark,”A EEMBC’s comprehensive embedded benchmark suites”, 2025. [Online]. Available: https://github.com/eembc/coremark 





[15] Khan, Faiz and Foley-Bourgon, Vincent and Kathrotia, Sujay and Lavoie, Erick Ostrich Benchmark Suite. (2014,6,9), https://github.com/Sable/Ostrich 





[16] Libsodium,”Sodium is a modern, easy-to-use software library for encryption, decryption, signatures, password hashing, and more”, 2025. [Online]. Available: https://doc.libsodium.org/ 





[17] Wasmparser: A simple event-driven library for parsing WebAssembly binary files, 2025. [Online]. Available: https://docs.rs/wasmparser/latest/wasmparser/ 





[18] Makitalo, N., Bankowski, V., Daubaris, P., Mikkola, R., Beletski, O. & ¨ Mikkonen, T. Bringing WebAssembly up to speed with dynamic linking. Proceedings Of The 36th Annual ACM Symposium On Applied Computing. pp. 1727-1735 (2021), https://doi.org/10.1145/3412841.3442045 





[19] Nießen, T., Dawson, M., Patros, P. & Kent, K. Insights into WebAssembly: compilation performance and shared code caching in Node.js. Proceedings Of The 30th Annual International Conference On Computer Science And Software Engineering. pp. 163-172 (2020) 





[20] Wang, W. How Far We’ve Come – A Characterization Study of Standalone WebAssembly Runtimes. 2022 IEEE International Symposium On Workload Characterization (IISWC). pp. 228-241 (2022) 





[21] Kjorveziroski, V. & Filiposka, S. WebAssembly as an Enabler for Next Generation Serverless Computing. J. Grid Comput.. 21 (2023,6), https://doi.org/10.1007/s10723-023-09669-8 





[22] Gackstatter, P., Frangoudis, P. & Dustdar, S. Pushing Serverless to the Edge with WebAssembly Runtimes. 2022 22nd IEEE International Symposium On Cluster, Cloud And Internet Computing (CCGrid). pp. 140-149 (2022) 





[23] Kjorveziroski, V. & Filiposka, S. WebAssembly Orchestration in the Context of Serverless Computing. Journal Of Network And Systems Management. 31, 62 (2023,7), https://doi.org/10.1007/s10922-023-09753- 0 





[24] Zhang, Y., Liu, M., Wang, H., Ma, Y., Huang, G. & Liu, X. Research on WebAssembly Runtimes: A Survey. (2024), https://arxiv.org/abs/2404.12621 





[25] Shillaker, S. & Pietzuch, P. Faasm: Lightweight Isolation for Efficient Stateful Serverless Computing. 2020 USENIX Annual Technical Conference (USENIX ATC 20). pp. 419-433 (2020,7), https://www.usenix.org/conference/atc20/presentation/shillaker 





[26] Zhao, S., Xu, P., Chen, G., Zhang, M., Zhang, Y. & Lin, Z. Reusable Enclaves for Confidential Serverless Computing. 32nd USENIX Security Symposium (USENIX Security 23). pp. 4015-4032 (2023,8), https://www.usenix.org/conference/usenixsecurity23/presentation/zhaoshixuan 





[27] Asheim, T., Jahre, M. & Kumar, R. CoFaaS: Automatic Transformationbased Consolidation of Serverless Functions. Proceedings Of The 2nd Workshop On SErverless Systems, Applications And MEthodologies. pp. 1-8 (2024), https://doi.org/10.1145/3642977.3652093 





[28] Gadepalli, P., McBride, S., Peach, G., Cherkasova, L. & Parmer, G. Sledge: a Serverless-first, Light-weight Wasm Runtime for the Edge. Proceedings Of The 21st International Middleware Conference. pp. 265- 279 (2020), https://doi.org/10.1145/3423211.3425680 





[29] De Palma, G., Giallorenzo, S., Mauro, J., Trentin, M. & Zavattaro, G. FunLess: Functions-as-a-Service for Private Edge Cloud Systems. 2024 





IEEE International Conference On Web Services (ICWS). pp. 961-967 (2024) 





[30] Liu, M., Shen, H., Zhang, Y., Mei, H. & Ma, Y. WebAssembly for Container Runtime: Are We There Yet?. ACM Trans. Softw. Eng. Methodol.. (2025,2), https://doi.org/10.1145/3712197, Just Accepted 





[31] Harnes, H. & Morrison, D. SoK: Analysis Techniques for WebAssembly. Future Internet. 16, 84 (2024,2), http://dx.doi.org/10.3390/fi16030084 





[32] Lehmann, D. & Pradel, M. Wasabi: A Framework for Dynamically Analyzing WebAssembly. (2018), https://arxiv.org/abs/1808.10652 





[33] Titzer, B., Gilbert, E., Teo, B., Anand, Y., Takayama, K. & Miller, H. Flexible Non-intrusive Dynamic Instrumentation for WebAssembly. (2024), https://arxiv.org/abs/2403.07973 





[34] Zheng, W., Hua, B. & Jiang, Z. WASMDYPA: Effectively Detecting WebAssembly Bugs via Dynamic Program Analysis. 2023 IEEE 23rd International Conference On Software Quality, Reliability, And Security Companion (QRS-C). pp. 867-868 (2023) 





[35] Geller, A., Frank, J. & Bowman, W. Indexed Types for a Statically Safe WebAssembly. Proc. ACM Program. Lang.. 8 (2024,1), https://doi.org/10.1145/3632922 





[36] Gao, S., Li, G. & Fu, H. ZKWASM: A ZKSNARK WASM Emulator. IEEE Trans. Serv. Comput.. 17, 4508-4521 (2024), https://doi.org/10.1109/TSC.2024.3422798 





[37] Baek, D., Getz, J., Sim, Y., Lehmann, D., Titzer, B., Ryu, S. & Pradel, M. Wasm-R3: Record-Reduce-Replay for Realistic and Standalone WebAssembly Benchmarks. (2024), https://arxiv.org/abs/2409.00708 





[38] Chadha, M., Krueger, N., John, J., Jindal, A., Gerndt, M. & Benedict, S. Exploring the Use of WebAssembly in HPC. Proceedings Of The 28th ACM SIGPLAN Annual Symposium On Principles And Practice Of Parallel Programming. pp. 92-106 (2023,2), http://dx.doi.org/10.1145/3572848.3577436 





[39] Hilbig, A., Lehmann, D. & Pradel, M. An Empirical Study of Real-World WebAssembly Binaries: Security, Languages, Use Cases. Proceedings Of The Web Conference 2021. pp. 2696-2708 (2021), https://doi.org/10.1145/3442381.3450138 





[40] Jiang, S., Zeng, R., Rao, Z., Gu, J., Zhou, Y. & Lyu, M. Revealing Performance Issues in Server-side WebAssembly Runtimes via Differential Testing. (2023) 





[41] Kakati, S. & Brorsson, M. WebAssembly Beyond the Web: A Review for the Edge-Cloud Continuum. 2023 3rd International Conference On Intelligent Technologies (CONIT). pp. 1-8 (2023) 





[42] Li, B., Dong, W. & Gao, Y. WiProg: A WebAssembly-based Approach to Integrated IoT Programming. IEEE INFOCOM 2021 - IEEE Conference On Computer Communications. pp. 1-10 (2021) 





[43] Liu, Z., Xiao, D., Li, Z., Wang, S. & Meng, W. Exploring Missed Optimizations in WebAssembly Optimizers. Proceedings Of The 32nd ACM SIGSOFT International Symposium On Software Testing And Analysis. pp. 436-448 (2023), https://doi.org/10.1145/3597926.3598068 





[44] Makitalo, N., Mikkonen, T., Pautasso, C., Bankowski, V., Daubaris, P., ¨ Mikkola, R. & Beletski, O. WebAssembly Modules as Lightweight Containers for Liquid IoT Applications. Web Engineering: 21st International Conference, ICWE 2021, Biarritz, France, May 18–21, 2021, Proceedings. pp. 328-336 (2021), https://doi.org/10.1007/978-3-030-74296-6 25 





[45] Wang, W. Empowering Web Applications with WebAssembly: Are We There Yet?. 2021 36th IEEE/ACM International Conference On Automated Software Engineering (ASE). pp. 1301-1305 (2021) 





[46] Wen, E. & Weber, G. Wasmachine: Bring the Edge up to Speed with A WebAssembly OS. 2020 IEEE 13th International Conference On Cloud Computing (CLOUD). pp. 353-360 (2020) 



![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/efd07373ce238acce891939fcf3b3c52cfcc182507a3bdc472f1708fec6d8f29.jpg)



Canfeng Zheng obtained his BS degree from Sun Yat-sen University in 2024. He is currently pursuing a Ph.D. at the same institution and Peng Cheng Laboratory, with research interests focusing on cloud computing and resource optimization.


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/fbd85a0ba90da4c65f474567aad74c72ac2ff8024e6d51c02cf24950ace76966.jpg)



Yuxin Su received his Ph.D. degree from the Chinese University of Hong Kong in 2019. He is an Associate Professor and the Deputy Dean of the School of Software Engineering at Sun Yat-sen University. He works at the intersection of software engineering and artificial intelligence. His main research interests include software reliability, cloud computing, AI for software systems, and AIOps. He has more than 30 high-quality publications, including ICSE, ASE, ISSTA, SOSP, FAST, and TOSEM, and is the recipient of two Best Paper/Tool Awards.


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/f5fda29b05063bf5ac0531c53e0260dd75c87d46ad6178074e00414f968e409b.jpg)



Zigui Jiang (Member, IEEE) received the Ph.D degree in computer science and technology from the Beijing University of Posts and Telecommunications, Beijing, China, in 2019. She is an Associate Professor at the School of Software Engineering, Sun Yat-sen University, China. Her research interests include blockchain, smart contracts, big data analysis, and service recommendation. She has published over 20 papers in international journals and conferences such as TSC, TKDE, TII, ISSTA, and ICSE.


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/2689a5400fc5cdac3f126911a03fc3d1b32d5d53956dc74fe6b40bcd6aa72781.jpg)



Dan Li received the B.S. degree in automation engineering from the University of Electronic Science and Technology of China (UESTC), Chengdu, China, in 2012, and the Ph.D. degree with the School of Electrical and Electronic Engineering, Nanyang Technological University, Singapore, in 2017. From 2018 to 2021, she worked as a Research Fellow with the Institute of Data Science, National University of Singapore, Singapore. In 2021, Dr Li jioned the School of Software Engineering, Sun Yat-Sen University, Zhuhai, China, where she is currently an



Associtate Professor. Her research interests include data-centric AI, time series data analysis, and related vertical applications.


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/b073bfd8607344afb5ee8a9dfed8e34ae8f0d5df207c86373c9c91dc96e70ff4.jpg)



Weizhe Zhang is currently a Professor and Ph.D. Supervisor in the School of Computer Science and Technology, Harbin Institute of Technology, China. He has published around 100 scientific papers in the well-established journals including Computing. He conducts research in high performance computing, parallel and distributed system, cloud computing, real-time computing and computer network&security. He is a member of the IEEE, ACM, IEICE and CCF.


![image](https://cdn-mineru.openxlab.org.cn/result/2026-03-24/7aaca851-95ac-4d03-9c58-603caf756cc2/927cd754967c176b65bc94fc07583df1337707aa9cbb8c320fe7ea2a09d700fa.jpg)



Zibin Zheng (Fellow, IEEE) is currently a Professor and the Dean with the School of Software Engineering, Sun Yat-Sen University, Zhuhai, China. He authored or coauthored more than 300 international journal and conference papers, including one ESI hot paper and ten ESI highly cited papers. According to Google Scholar, his papers have more than 45,000 citations. His research interests include blockchain, software engineering, and services computing. He was the BlockSys’19 and CollaborateCom16 General Co-Chair, SC2’19, ICIOT18 and IoV14 PC Co-



Chair. He is a Fellow of the IET. He was the recipient of several awards, including the Top 50 Influential Papers in Blockchain of 2018, the ACM SIGSOFT Distinguished Paper Award at ICSE2010, ISSTA2024, the Best Student Paper Award at ICWS2010.
