# eWAPA: An eBPF-based WASI Performance Analysis Framework for WebAssembly Runtimes

Chenxi Mao, Yuxin Su, Shiwen Shan and Dan Li 

School of Software Engineering 

Sun Yat-sen University 

Zhuhai, China 

Abstract—WebAssembly (Wasm) is a low-level bytecode format that can run in modern browsers. With the development of standalone runtimes and the improvement of the WebAssembly System Interface (WASI), Wasm has further provided a more complete sandboxed runtime experience for server-side applications, effectively expanding its application scenarios. However, the implementation of WASI varies across different runtimes, and suboptimal interface implementations can lead to performance degradation during interactions between the runtime and the operating system. Existing research mainly focuses on overall performance evaluation of runtimes, while studies on WASI implementations are relatively scarce. To tackle this problem, we propose an eBPF-based WASI performance analysis framework. It collects key performance metrics of the runtime under different I/O load conditions, such as total execution time, startup time, WASI execution time, and syscall time. We can comprehensively analyze the performance of the runtime’s I/O interactions with the operating system. Additionally, we provide a detailed analysis of the causes behind two specific WASI performance anomalies. These analytical results will guide the optimization of standalone runtimes and WASI implementations, enhancing their efficiency. 

Index Terms—WebAssembly, Runtime, WebAssembly System Interface, I/O Performance Testing, eBPF 

# I. INTRODUCTION

In recent years, the maturation and development of browser platforms have given rise to increasingly complex and large browser applications, such as large 3D games, audio and video software, and online deep learning real-time training platforms, highlighting the importance of efficiently executing code in browsers. However, JavaScript (JS), as the only built-in language on browsers, does not adequately meet the efficiency requirements [1]. Even though JS engines like Chrome’s V8 and SpiderMonkey have adopted Just-In-Time (JIT) compilation techniques to enhance the execution efficiency of JS code, their optimization iterations still cannot keep up with the rapid growth of modern browser applications. 

To address the aforementioned issues, WebAssembly (Wasm) emerged [1]. Designed as a low-level bytecode format for application compilation targets, Wasm was initially intended to run code on web applications close to native performance, enabling the deployment of high-performance applications written in compiled languages like C, $\mathrm { C } { + } { + }$ , Rust, etc., onto the web. In 2019, Wasm was ratified by the World 

Yuxin Su is the corresponding author. 

Wide Web Consortium (W3C) to become the fourth browser language after HTML, CSS, and JS [2]. 

In reality, Wasm is an abstraction of modern hardware, making it independent of language, hardware, and platform, while providing guarantees for type and memory safety. The emergence of standalone Wasm runtimes has pushed Wasm beyond the confines of browsers, offering a fast, scalable, secure, and sandboxed method for running the same code on various non-web environments [3], such as serverless computing [4]–[6], edge computing [7], [8], and smart contracts [9]. Particularly, the development of the Wasm System Interface (WASI) standardization efforts [10] has provided a more complete sandboxed running experience on the server side, effectively expanding the usage scenarios of Wasm runtimes. 

However, existing standalone Wasm runtimes are still in their early stages and are more likely to exhibit performance issues compared to browsers [11], which can be hard to detect during the testing phase and may adversely affect applications. When conducting extensive system-level I/O operations through WASI in runtimes, the implementation of the WASI interface varies across different runtimes, including aspects such as memory management, syscall types, and security checks. Inefficient interface implementations can impact the overall performance of applications during interactions between the runtime and the system, undermining Wasm’s performance advantages. Current research focuses on the overall performance of Wasm test cases on standalone runtimes and on revealing inconsistent behaviors between runtimes, yet there is a lack of studies on runtime WASI implementation efficiency issues in massive I/O interaction scenarios. 

In this paper, we aim to propose an automated WASI I/O performance testing method to reveal performance issues during WASI’s I/O interactions. From the perspective of WASI implementation mechanisms, we aim to provide robust technical support for enhancing the performance of standalone runtimes executing Wasm modules, inspiring future work on optimizing more efficient standalone runtimes and WASI implementations. The main contributions of this paper are as follows: 

• We develop a non-intrusive eBPF-based monitoring tool to profile WASI-enabled Wasm runtimes, which collects performance data from both Native and runtime during the I/O process. 

• We identify and analyze the abnormal performance data of WASI from multiple dimensions, by studying the performance differences between various runtimes and then pinpointing specific abnormal behaviors. 

• Furthermore, we conduct an in-depth root cause analysis of two specific anomalies identified within the runtime, providing actionable insights for optimizing WASI implementations. 

# II. BACKGROUND

# A. Wasm Core Design

1) Stack Virtual Machine Design: The architecture of Wasm and its compiler implementations leverage key characteristics of stack-based virtual machines, including structured control flow and stack containers, to achieve compact program representations [1]. The function code in Wasm modules consists of a series of instructions that operate on an implicit operand stack, popping parameter values and pushing result values. Although the size of bytecode for register machines is only $26 \%$ larger than that for corresponding stack machines [12], the stack machine approach is not necessarily faster, but it offers smaller bytecode, which is an extremely important design goal for internet-based operations [13]. 

The stack machine design also makes the code verification process simpler and more efficient. Before loading and compiling Wasm modules, browsers first check whether the code complies with Wasm standards and security features, such as whether it accesses illegal memory ranges and whether the return value types of functions are correct. By examining the actual data type of the top element of the stack after a function execution, the compiler can directly determine whether the identified return value data type of the function is correct. 

2) Linear Memory Design: The main memory of Wasm is linear memory, resembling a large byte array, which is a contiguous block of bytes. It mimics the traditional computer memory model, allowing data to be accessed according to byte addresses, and can be read from and modified by both Wasm and JS [14]. When instantiating a Wasm module at runtime, a memory instance is created, which is essentially an expandable JS ArrayBuffer [15], enabling the use and emulation of dynamic memory allocation [16]. The design of the ArrayBuffer provides a boundary, limiting the memory that Wasm modules can directly access [17]. Each Wasm module is permitted to define a single memory space, which may be shared across multiple instances. As Wasm modules run, shared memory may experience memory overflow due to insufficient remaining resources, and Wasm allows for dynamic adjustment of the size of this shared memory. 

3) Sandbox Design: When Linear memory is isolated, it does not share or overlap with other internal data structures of the execution engine, execution stacks, local variables, or memory of other processes [18], ensuring the security and isolation of memory operations and facilitating a sandboxed design. Untrusted modules can be securely executed within the same address space as other code, thereby facilitating rapid process-level isolation [1]. This also allows Wasm to efficiently 

interact with untrusted JS and Web APIs and be embedded into other runtimes without compromising memory safety. 

# B. Server-side Wasm

With the growing popularity of server-side Wasm applications and the development of the WASI interface, the Wasm development community, such as the Bytecode Alliance [19], has implemented many standalone Wasm runtimes. Currently, there are over thirty independent Wasm runtimes available on GitHub [11]. For example, WebAssembly Micro Runtime (WAMR) [20] is a lightweight standalone Wasm runtime known for its small footprint, high performance, and configurability. Wasmer [21] is an extremely fast and secure runtime that enables lightweight containers to run on desktops, clouds, edge computing, and even in browsers. Wasm3 [22], as a fast Wasm interpreter and the most universal Wasm runtime, uses a slow interpreter instead of fast just-in-time compilation. WasmEdge [23] brings cloud-native and serverless application paradigms to edge computing. Wasmtime [24] is a fast and secure Wasm runtime developed by the Bytecode Alliance. All of these share the following fundamental components: 

1) Wasm Module Compilation Process: The WASI-SDK [25] is a toolkit developed for WASI, including specific compilers and libraries that optimize the compilation process. This SDK is used to compile $\mathrm { C } / \mathrm { C } { + + }$ code into Wasm modules that conform to the WASI specifications. Wasm modules compiled with the WASI-SDK can access operating system-level functions, greatly expanding Wasm’s application potential in server-side and other non-browser environments. 

2) WASI Interaction with Operating Systems: Wasm is an assembly language intended for conceptual machines rather than physical ones, requiring a system interface of a conceptual operating system, allowing it to run on all different operating systems. With the help of WASI, Wasm applications can operate independently, securely communicating with the system without needing to be embedded in other programming environments [3]. Serving as a modular system interface between Wasm modules and the host operating system [26], WASI enables syscalls in a permission-based manner [26], contributing a series of implementation proposals for interactions in I/O, file systems, HTTP protocols, command-line interfaces, and network connections [27] [28]. 

# III. METHODOLOGY

# A. Overview

We develop an I/O Performance analysis method for Wasm runtimes based on eBPF, which identifies performance issues in the WASI implementation within standalone Wasm runtimes by running I/O-related test cases at runtime. This method, as shown in Figure 1, is divided into four key parts: compiling test cases, injecting eBPF bytecode into the Linux kernel to monitor performance, acquiring I/O performance data, and identifying anomalies in performance implementation. 

Step 1 selects I/O test cases from the LLVM test suite, then compiling them into Wasm modules and native binary files. Step 2 writes eBPF programs and injects them into the Linux 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/c0325e2e623560d72aa6cd06078d03039696c84121a535d1aab972577ac4c261.jpg)



Fig. 1. Method Overview.


kernel to monitor performance metrics such as execution time and frequency of WASI and syscalls, as well as runtime startup time. Step 3 selects suitable test runtimes to execute the test cases on, and collects I/O performance data. Step 4 analyzes the data and determines the causes of performance anomalies in the runtime WASI. 

# B. Step 1: Compile Test Cases.

The first step is to compile test cases, which is divided into two sub-steps. 

Initially, it is necessary to identify I/O test cases. To select test cases that well support Wasm and are more likely to trigger performance issues [11], we utilize the LLVM test suite, which is designed for testing and evaluating the performance of LLVM compilers and toolchains [29]. Test cases are chosen from the SingleSource directory of the test suite, as the source programs in this directory are individual programs written in $\mathrm { C / C } { + + }$ , facilitating their compilation into Wasm and execution during the experiment. The test suite’s cases primarily target terminal I/O; however, we focus on file I/O. Therefore, we modify the stdin and stdout in the test cases to use fopen and fclose, retains fwrite and fread functions, and add the execution of fseek function to accommodate the characteristics of file I/O. The two test cases ultimately selected meet the requirements for testing various basic functions related to I/O. 

Secondly, it is necessary to obtain the Wasm modules of the test cases and the control group’s native binary files. For the Wasm runtime, we use WASI-SDK-21.0 to compile the source programs into Wasm modules. The WASI-SDK is a software development kit specifically developed for the WASI environment, providing a set of tools and libraries that enable developers to compile C and $\mathrm { C } { + } { + }$ code into Wasm, while also supporting system-level calls through the WASI API. For the native environment, we employ Clang and ${ \mathrm { C l a n g } } + +$ tools to compile the source programs into native binary files with an optimization level of O3. 

# C. Step 2: Injecting eBPF Bytecode into the Linux Kernel to monitor Performance.

We has established a series of metrics, including WASI execution time, syscall execution time, total runtime, number 

of WASI executions, number of syscalls, average execution time of WASI, average execution time of syscalls, and runtime startup time. An eBPF program is written to monitor these metrics, typically using the C language. 

The process of injecting eBPF into the kernel is commonly referred to as ”loading.” Specifically, this process involves using the BCC framework to compile the BPF program into bytecode, which is then loaded into the Linux kernel via a BPF syscall and attached to a kernel hook point, such as a network interface, syscall, or other kernel events. 

In this paper, the primary focus of the hooks encompasses the runtime’s WASI function compilation symbols along with Linux’s I/O syscalls and symbols related to the compilation of runtime startup functions. The WASI function and runtime startup-related function compilation symbols are hooks in user space, while I/O syscalls are hooks in the Linux kernel space. The eBPF monitoring symbols related to WASI in both native and Wasm runtimes are shown in Table I (using the Read event as an example). 

To monitor the Read WASI execution time in the Wasmer runtime, first, locate the compiled symbol of the Read WASI function in the runtime flame graph, and use the nm command to find the corresponding symbol in the runtime executable. In a Python program under the BCC framework, we use attach uprobe to attach the eBPF program to user space. When the symbol’s entry and exit points are hit, the corresponding trace fread entry and trace fread exit eBPF programs execute, storing data such as execution time and counts using the BPF Hash structure. Finally, data is retrieved and processed in Python code from the eBPF. 

For the Read syscall, use the attach kprobe function to attach to Linux kernel space, executing syscall.attach kprobe(event=” x64 sys read”, fn name=”trace readv entry”) to attach the eBPF program to the kernel space symbol x64 sys read, filtering the triggering process’s command to select the corresponding syscalls executed by the Wasm runtime. 

Additionally, the eBPF monitoring functions related to Wasm runtime startup time are as shown in Table II. When the runtime begins loading the Wasm module, it indicates that the runtime has completed initialization. The startup time is the interval from the entry of the initialization function to the entry of the function loading the Wasm module. Taking the Wasm3 runtime as an example, first, initialize result variables and the environment, execute $e n \nu = m { 3 }$ NewEnvironment(); to create a new Wasm3 environment, then parse command line arguments, using a series of conditional statements to identify different command flags and set the corresponding variables. Next, perform module loading and initialization. The program, based on parsed parameters, calls repl initto initialize the REPL (Read-Eval-Print Loop) environment, set the stack size and then uses repl load to load the specified Wasm module. Finally, perform conditional compilation, module execution, and error handling. 


TABLE I WASI FUNCTION COMPILATION SYMBOL HOOKS


<table><tr><td></td><td>Native</td><td>Wasm3</td><td>Wasetime</td><td>wasetime preview2</td><td>Wasmer</td><td>WAMR</td></tr><tr><td>WASI Hook</td><td>fread</td><td>m3_wasi.Generic_fd_read</td><td>wasi_common...fd_read</td><td>wasetime_wasi:::preview2...fd_read</td><td>wasmer_wasix...fd_read</td><td>wasi_fd_read</td></tr><tr><td>Syscall Type</td><td>read</td><td>-ready</td><td>ready</td><td>ready</td><td>read</td><td>pread64</td></tr><tr><td>Syscall Hook</td><td>_x64_sys_read</td><td>_x64_sys_read</td><td>_x64_sys_read</td><td>_x64_sys_read</td><td>_x64_sys_read</td><td>_x64_sys_pread64</td></tr></table>


TABLE II WASM RUNTIME STARTUP-RELATED FUNCTIONS


<table><tr><td></td><td>Wasm3</td><td>Wasftime &amp; Preview2</td><td>Wasmer</td><td>WAMR</td></tr><tr><td>Initialization Function</td><td>m3_NewEnv...</td><td>new.execute()</td><td>__libc_start_main</td><td>wasm_routine_full_init</td></tr><tr><td>Function for Loading Wasm</td><td>repl_load(...)</td><td>self.run.load_module</td><td>WaAm::Module::imports</td><td>bh_read_file_to_buffer</td></tr></table>

# D. Step 3: Acquiring I/O performance data.

We execute the Wasm modules compiled in Step 1 on various test runtimes. At the same time, the compiled native binary files are run in the local environment as a control. The evaluation of the fread function, alongside the overall runtime, is conducted using three distinct input file sizes: 1GB, 10GB, and 100GB. Similarly, the fwrite function and the total runtime are assessed across four varying output file sizes: 48MB, 4.7GB, 11GB, and 99GB. Additionally, the startup time of the runtime is tested under two different input file sizes of 1GB and 10GB, and two different output file sizes of 48MB and 4.7GB. To prevent auxiliary I/O functions from exhibiting performance issues due to too short startup times, we execute the fseek, fopen, and fclose functions 50 times each in a loop to better identify performance issues. For fseek, the test file size is 1GB, with the loop count set as $i$ , so the seek position each cycle is $i \times 1 , 0 0 0 , 0 0 0$ ; for fopen and fclose, the test file size is 4.7GB. In each runtime and native environment, each test case Wasm module is executed 10 times, and the average of the 10 execution times is taken as the final execution time. 

# E. Step 4: Identifying performance anomalies.

This step analyzes the I/O performance data collected in Step 3, identifying anomalies and the causes of performance issues in runtime WASI. It is divided into four substeps: 

(1) Analyzing runtime execution time trends under varying I/O loads. We collect data on I/O syscall times, I/O WASI interaction times, runtime startup times, and total runtime execution times at different I/O file sizes. Line charts depicting the trend of increasing execution times as file sizes increase are drawn, and the charts are analyzed to draw some conclusions. 

(2) Analyzing the proportion of runtime execution time under heavy I/O loads. We calculate the proportion of Read/Write WASI and syscalls in the total runtime for inputs of 100GB and outputs of 99GB and chart these proportions. Additionally, to compare the impact of different I/O loads on these proportions, we also calculate and chart the proportions of Read/Write WASI and syscalls in the total runtime for inputs of 10GB and outputs of 4.7 GB. 

(3) Analyzing the WASI execution time for I/O auxiliary functions. The WASI execution times for the fopen, close, and fseek functions are analyzed. 

(4) Case study. Data related to I/O WASI and syscalls for different runtimes under large file I/O conditions (input 100GB, output 99GB) are collected. This includes a series of metrics such as WASI’s execution time, number of executions, average execution time, and syscall’s execution time, number of executions, and average execution time. We select two instances of performance anomalies from the experimental results and find out the reasons by analyzing data and code implementation. 

# IV. EVALUATION AND ANALYSIS

In this section, we aim to answer the following research questions: 

• RQ1: How does the trend of runtime execution times vary with different I/O loads? 

• RQ2: When the I/O load is large, what is the proportion of runtime execution time? 

• RQ3: What is the execution time of WASI for I/O auxiliary functions? 

# A. Experimental Setting

Experimental Environment. All experiments were conducted on a server equipped with an Intel(R) Core(TM) i5- 12400F 4.4GHz CPU and 32GB of DDR4 memory. The server operates on a 64-bit Arch Linux system, with the Linux kernel version 6.8.2-arch2-1. 

Wasm Runtime Selection. We search for the keyword “WebAssembly Runtime” on GitHub, and select runtimes with stars more than 4.5K. We also filter out runtimes without continuous releases and acceptable execution time. Ultimately, four representative independent Wasm runtimes are selected: Wasmer, Wasmtime, Wasm3, and WAMR. During the experiment, Wasmtime updated to the preview21 version [30], we consider it as a fifth runtime. Information on the runtimes is shown in Table III. 

1The wasmtime wasi package is transitioning from the older wasi common (preview1) to supporting wasmtime wasi::preview2. This new implementation supports both WASIp1 and WASIp2 versions. This transition signifies a gradual deprecation of the old implementation, with a full shift towards a more modern and updated WASI implementation in the future. 


TABLE III WASM RUNTIME VERSION INFORMATION


<table><tr><td></td><td>GitHub Stars</td><td>Test Version</td><td>Commit Hash</td></tr><tr><td>Wasm3</td><td>7k</td><td>-</td><td>772f8f4648fcba75f77f894a6050db121e7651a2</td></tr><tr><td>WAMR</td><td>4.5k</td><td>-</td><td>52db362b897221c2a438197a0f2e4a9a300becd4</td></tr><tr><td>Wasotime</td><td>14.4k</td><td>v14.0.4</td><td>-</td></tr><tr><td>Wasmer</td><td>17.7k</td><td>v4.2.2</td><td>-</td></tr><tr><td>Wasptime preview2</td><td>14.4k</td><td>v18.0.0</td><td>-</td></tr></table>

# B. RQ1: Execution Time Trend

1) Syscall Execution Times: With different I/O loads, the trends in read and write syscall times for native and Wasm runtimes are illustrated in Figure 2. 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/5ac3abc50758e3d6e71c03c1d16f65e816e270cfcf4e376a28ce0ff7e875a379.jpg)



(a) Fread syscall time trend


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/af28f008d01c459c570bb464cca2706ceae6bbb4db0add4cf5251d1170b896b7.jpg)



(b) Fwrite syscall time trend



Fig. 2. I/O syscall time trend (seconds)


$\textcircled{1}$ Compared to write, the syscall times for read do not show a completely linear growth trend as sizes of input file increase. The rate of increase in execution time of syscall for reading large files is greater than that for smaller files in both native environments and various runtimes. This suggests that runtimes are more likely to encounter bottlenecks when reading large-scale data. Conversely, the syscall times for write exhibit a more stable growth trend with increasing file sizes. 

$\textcircled{2}$ In read operations, the syscall times across the four runtimes are generally similar, though WAMR’s syscall time is noticeably slightly higher than the others. In write, the syscall times for Wasmtime, WAMR, and Wasm3 are quite close, while Wasmer and Wasmtime preview2 show significantly higher times compared to the first three. 

$\textcircled{3}$ There are some commonalities in both read and write: the syscall times for native read and write are the shortest among all runtimes, which aligns with normal expectations. 

2) WASI Execution Times: Under different I/O loads, the trends in WASI interaction time during read and write for Native and Wasm runtimes are illustrated in Figure 3. The horizontal axis represents the unit of GB, and the vertical axis represents the unit of seconds. Regarding the analysis of WASI execution time, significant performance differences in WASI and system interaction are observed across various runtimes when handling different scales of file read and write. 

$\textcircled{1}$ When Native performs file write, the fwrite function exhibits exceptional performance behavior, showing the highest execution time growth rate. As shown in Section IV-B1, the syscall time for Native is the shortest. This indicates that in the Native environment, there exists much redundant time between syscalls and the fwrite function, resulting in longer 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/9318c4dabc0bcbd1c3cc6c3862dc896b62b493dc170d3100494b1add613c4959.jpg)



(a) Fread WASI time trend


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/0517b294dd3d2f3768bd4bd3b535c0a36e17702fd9cdc7998e532dcdad652d5f.jpg)



(b) Fwrite WASI time trend



Fig. 3. I/O WASI time trend (seconds)


execution time for fwrite compared to WASI. Additionally, when handling small-scale file read, although the execution time of Native’s fread function is longer, slightly higher than Wasm3 and WAMR, it does not show a significant performance advantage. However, for larger input sizes, Native’s fread function typically demonstrates the lowest execution time. This suggests that compared to other runtimes, Native’s fread function may have better input processing efficiency for large files, while struggling to showcase performance advantages for small files. 

$\textcircled{2}$ Compared to write, the WASI time for read does not exhibit a completely linear growth trend with increasing input file sizes. The growth rate of time for large files of each runtime is higher than that for small files, indicating potential bottlenecks when processing larger-scale data, consistent with the first point in Section IV-B1. 

$\textcircled{3}$ Some commonalities are observed in both read and write: Wasm3, Wasmtime, and WAMR exhibit similar execution time growth curves, with close WASI execution times. During file read, Wasmer shows the highest execution time growth rate, suggesting that as the input size increases, its performance degradation in WASI and system interaction may be the most significant, followed by Wasmtime preview2. During file write, Wasmer and Wasmtime preview2 still exhibit relatively poor interaction performance. 

3) Runtime Startup Time: Figure 4 illustrates the startup times of various runtimes. The horizontal axis represents the names of the runtimes, and the vertical axis shows the execution time in seconds. Due to the excessively long startup times of Wasmer and WAMR, the data for these two runtimes were adjusted by reducing them by factors of 100 and 10, respectively, to better display the data for other runtimes in the figure. 

$\textcircled{1}$ Comparing the startup times of the same runtime under different I/O scales reveals that even with input and output scales differing by more than tenfold, the variations in startup times for executing different test cases across various Wasm runtimes are not significant. This suggests that these runtimes have low dependencies on input and output scales during startup. It also indicates that these runtimes may be welloptimized during startup, with minimal increase in startup time due to data scale. 

$\textcircled{2}$ Contrasting the startup times of different runtimes under 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/d1e9d3000fe89dd9a0a767d957e6c0896c0bdfb20ee77317184dbb969a0827d1.jpg)



Fig. 4. Wasm runtime startup time under different I/O scales (seconds)


the same I/O scale shows significant differences. Wasm3 has the shortest startup time, followed by Wasmtime and Wasmtime preview2, while the startup times of WAMR and Wasmer are significantly higher than the other three runtimes. Wasmtime and Wasmtime preview2, as different implementations of the same runtime, exhibit similar startup times. Although Wasm3 and WAMR show similar performance on several other tests, the difference in startup time is substantial, nearly a hundredfold. Wasmer’s startup time is also much longer than WAMR and the other three runtimes, differing by almost 2000 times from the shortest startup time of Wasm3. 

The evaluation of runtime startup times indicates that the startup times remain nearly unchanged in response to changes in the I/O scale. It means that the startup phase is welloptimized and largely independent of data size. However, significant differences in startup times between different runtimes are apparent, with some runtimes exhibiting exceptionally long startup times. 

4) Overall Execution Time: Under different I/O loads, the overall execution time trends for read and write in Native and Wasm runtimes are illustrated in Figure 5. The horizontal axis represents GB, and the vertical axis represents seconds. 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/37f3a347abe393f1c8ff7d661fc362c7deaadc8dd300abce753626293699a7e3.jpg)



(a) Fread overall execution time trend


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/9fadc269a61be5a6416b34b86dc334d34f6a9c7725355be0d4db737b75fc9540.jpg)



(b) Fwrite overall execution time trend



Fig. 5. I/O overall execution time trend (seconds)


$\textcircled{1}$ For both read and write, the execution times of the WAMR and Wasm3 are close. As the I/O scale increases, the overall runtime time shows a significant linear growth trend. This may indicate that both runtimes face performance bottlenecks when handling large amounts of data, possibly due to inefficient implementation of code outside the WASI. 

$\textcircled{2}$ During read, apart from WAMR and Wasm3, other runtimes show a more moderate increase in execution time. The execution times of Wasmer and Wasmtime preview2 are close and slightly higher than Native’s. Wasmtime’s execution time is the closest to Native, demonstrating faster running speed and overall efficiency. In write, the execution times of Wasmer, Wasmtime preview2, and Wasmtime are shorter than the total execution time of Native. The reduction in total execution time for Wasmer and Wasmtime preview2 is partly due to the impact of the Tokio asynchronous mechanism used by these runtimes, which helps reduce overall execution time during large file I/O operations. 


C. RQ2: Proportion of Execution Time


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/e32ce028f26a33754c559d3face91a6ea36ae505f68f9e6b10d540cfad282163.jpg)


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/dc7ef7ba7711aac32d883184ee34564d27175bb787e328ef092952b180a3ff89.jpg)


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/9457fe4dfed35ea22ae3f0bc77153e27495ccea205e21b1c8c1a3b6a4312de88.jpg)


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/aa5c78f9b64b868e3c2057e52d84d18ce10e864661cd6074abd946af8fd15a8b.jpg)



Fig. 6. Distribution of proportion of time occupied by each part of I/O.


We develop a frontend program to display the proportion of WASI and syscall times in the total runtime, as shown in Figure 6. Comparing large-scale read and write, it can be seen that the runtime, excluding WASI, accounts for a high proportion in Wasm3 and WAMR, which aligns with the first point in Section IV-B4. The execution times of Native’s fwrite, Wasmtime’s I/O WASI, Wasmtime preview2’s I/O WASI, and Wasmer’s I/O WASI have a high proportion in the overall runtime, especially in Wasmer. 

When comparing the write operation across different I/O scales, it is observed that the proportion of execution times remains relatively consistent across all evaluated runtimes. An analysis of read operations across various I/O scales indicates that, particularly for large-scale read processes, there is a substantial increase in the proportion of WASI and syscall execution times relative to the total runtime. This aligns with the second point in Section IV-B2. 

# D. RQ3: Execution Time of I/O Auxiliary Functions

We test lightweight I/O auxiliary functions such as fseek, fopen and fclose, and obtain the interaction times with WASI for each function. 

1) Fopen and Fclose: By repeatedly executing fopen and fclose for 50 times, we obtain the interaction times with WASI, as shown in Table IV. For fopen, the execution times of Native and most Wasm runtimes are generally consistent, with Wasmtime preview2 having significantly shorter execution 

times than the other runtimes. For fclose, the execution times of Wasmtime preview2 and Wasmer are much shorter than those of the other runtimes, followed by Wasm3 and WAMR. 


TABLE IV WASI INTERACTION TIME BETWEEN FOPEN AND FCLOSE (SECONDS)


<table><tr><td></td><td>Native</td><td>Wasm3</td><td>Wastime</td><td>Wastime preview2</td><td>Wasmer</td><td>WAMR</td></tr><tr><td>Fopen</td><td>20.86419</td><td>21.09183</td><td>19.69448</td><td>0.00036</td><td>21.45274</td><td>21.10804</td></tr><tr><td>Fclose</td><td>35.00267</td><td>5.17304</td><td>24.15975</td><td>0.00016</td><td>0.00019</td><td>5.87338</td></tr></table>

2) Fseek: The test file size for fseek is 1GB, with 50 iterations. Let the iteration count be $i$ , and the seek position for each iteration is $i * 1 0 0 0 0 0 0$ . Tests are conducted on Native and various Wasm runtimes to obtain the interaction times with WASI, as shown in Table V. The fseek times for Wasm3, Wasmer, and WAMR are relatively close and do not exhibit significant performance anomalies. The fseek execution times for Wasmtime Preview1 and Preview2 are relatively longer. 


TABLE V WASI INTERACTION TIME OF FSEEK (SECONDS)


<table><tr><td></td><td>Native</td><td>Wasm3</td><td>Wasptime</td><td>Wasptime preview2</td><td>Wasmer</td><td>WAMR</td></tr><tr><td>Fseek</td><td>0.00033</td><td>0.00013</td><td>0.00023</td><td>0.00022</td><td>0.00017</td><td>0.00015</td></tr></table>

# V. CASE STUDY

To explain the reasons behind some of the above conclusions, we select two performance anomaly cases and analyze their root causes. First, under large file I/O conditions (input 100GB, output 99GB), data related to I/O WASI and syscalls are collected for different runtimes. It includes the WASI execution time, execution count, average execution time, syscall execution time, execution count, and average execution time, as shown in Table VI and Table VII. 

# A. Case Analysis 1

The first case analyzed is the longer execution time of the fwrite function in the Native environment compared to the Write WASI interaction time of all runtimes. This is a counterintuitive performance anomaly. 

According to Table VII, in terms of syscall time, the total syscall time for Native is much shorter than that for other runtimes. Native uses the write syscall, with a total of 25,976,563 calls, fewer than the actual fwrite calls of 1,750,000,077 times, with an average syscall time of 2533ns. In contrast, Wasm runtimes (e.g., wasm3) use the writev syscall (as shown in Figure 7, with each writev divided into two parts, writing approximately 976 bytes and 61 bytes, totaling 1037 bytes), with a total of 101,797,388 calls, consistent with the Write WASI call count, and an average syscall time of 2191ns. The difference in the writing methods of syscalls between Native and other runtimes results in a significantly shorter total syscall time for Native, despite the similar average syscall time per call. The discrepancy is due to differences in the mechanisms for writing cached data to disk between the two. 

In the $\mathrm { C } / \mathrm { C } { + + }$ standard library, the fwrite function is typically equipped with an internal buffering mechanism. Data is first 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/5b12aa9cb6ef48a7f09676b7e431496729080482137db50845e1683c632f91aa.jpg)



Fig. 7. Wasm3 Syscall: writev


written to the internal buffer, and only when the buffer is full or an explicit flush is triggered (such as by calling the fflush function), will the actual write call to the operating system occur. This is also reflected in the timing of fwrite executions: most fwrite executions are very short, but occasionally, there will be longer execution times, which usually indicates an actual write. When the buffer is full, after about 68 fwrite calls, a single write syscall writes the entire 4096 bytes to disk. 

In Wasm, the buffer size is not fixed. Taking Wasm3 as an example (with similar behavior in other runtimes), according to the writev syscall data shown in Figure 7, when the buffer accumulates to approximately 1037 bytes, the runtime will initiate a write WASI call, which then triggers a writev syscall to actually write the data to the file. Specifically, in the test case, each fwrite writes 60 bytes, and 16 consecutive fwrite calls accumulate to 976 bytes, corresponding to the first iov base of the writev syscall. An additional fwrite call adds 61 bytes, corresponding to the second iov base. Therefore, approximately 17 fwrite function executions, totaling 1037 bytes, will trigger a write WASI and a writev syscall. 

From Table VII, it can be seen that the number of fwrite calls is 1,750,000,077 times, which matches the actual number of fwrite function calls in the code. The number of write WASI calls is 101,797,388 times, and the number of writev syscalls is also 101,797,388 times. This essentially verifies the above ratio, i.e., the execution ratio of fwrite to write WASI to writev is 17:1:1. 

To verify the variability of the Wasm runtime buffer size, we modify the test case code to set each write to 280 bytes and re-traced the execution. In the test, each fwrite writes 280 bytes, and three consecutive fwrite calls accumulate 840 bytes, corresponding to the first iov base of the writev syscall. An additional fwrite call adds 280 bytes, corresponding to the second iov base. This indicates that approximately four fwrite function executions, totaling 1120 bytes, will trigger a write WASI and a writev syscall. In this test case, the ratio of fwrite to write WASI to writev will be 4:1:1. This result supports the view that the Wasm runtime buffer size is variable and different from the Native buffer size. 

In conclusion, the significant differences in the execution time of fwrite between Native and Wasm can be primarily attributed to the different buffering mechanisms. In the Native environment, the execution time of fwrite includes the time taken to write data into a fixed 4096-byte buffer until it is full, followed by a single write syscall. This means that many fwrite that merely involves writing to the buffer is also included in the timing statistics. In contrast, in Wasm WASI, the buffer size is not fixed, and once the accumulated data reaches a certain 


TABLE VI FREAD RELATED WASI AND SYSCALL DATA


<table><tr><td></td><td>Fread WASI Time (s)</td><td>WASI Numer (s)</td><td>WASI Average Time (s)</td><td>Read syscall Time (s)</td><td>syscall Num (s)</td><td>syscall Average Time (s)</td></tr><tr><td>CPP</td><td>178</td><td>26214401</td><td>7719</td><td>123</td><td>26214401</td><td>5643</td></tr><tr><td>Wasm3</td><td>211</td><td>26214401</td><td>9244</td><td>180</td><td>26214401</td><td>8100</td></tr><tr><td>WAMR</td><td>249</td><td>26214401</td><td>9660</td><td>226</td><td>26214401</td><td>9701</td></tr><tr><td>Wasptime preview2</td><td>311</td><td>52428801</td><td>6528</td><td>144</td><td>52428801</td><td>3324</td></tr><tr><td>Wasmer</td><td>683</td><td>26214401</td><td>26796</td><td>165</td><td>52428801</td><td>3333</td></tr><tr><td>Wasptime</td><td>215</td><td>26214401</td><td>8088</td><td>157</td><td>26214401</td><td>5858</td></tr></table>


TABLE VII FWRITE RELATED WASI AND SYSCALL DATA


<table><tr><td></td><td>Fwrite WASI Time (s)</td><td>WASI Numer (s)</td><td>WASI Average Time (s)</td><td>Write syscall Time (s)</td><td>syscall Num (s)</td><td>syscall Average Time (s)</td></tr><tr><td>CPP</td><td>2701</td><td>1750000077</td><td>1616</td><td>51</td><td>25976563</td><td>2533</td></tr><tr><td>Wasm3</td><td>311</td><td>101797388</td><td>3302</td><td>201</td><td>101797388</td><td>2191</td></tr><tr><td>WAMR</td><td>290</td><td>101797388</td><td>3181</td><td>186</td><td>101797388</td><td>2129</td></tr><tr><td>Wasptime preview2</td><td>1026</td><td>203594775</td><td>5505</td><td>370</td><td>203594775</td><td>2165</td></tr><tr><td>Wasmer</td><td>1775</td><td>101797388</td><td>17261</td><td>370</td><td>203594776</td><td>2193</td></tr><tr><td>Wasptime</td><td>419</td><td>101797388</td><td>3681</td><td>198</td><td>101797388</td><td>1597</td></tr></table>

iov base size, a write WASI execution and a writev syscall are triggered. Statistically, Wasm WASI only records the execution times of those instances that actually involve file writes, which are closely related to the syscalls, more directly reflecting the actual disk write. The ratio of fwrite executions in Native to Wasm WASI is 17:1, so the fwrite execution times recorded in the Wasm WASI environment typically appear shorter. 

The differences in the design of buffering mechanisms between the $\mathrm { C } / \mathrm { C } { + + }$ standard library and Wasm also explain why there is no performance discrepancy observed in the read WASI tests. This is because the test case specifies that each read is 4096 bytes, making the buffer size identical in both environments. Therefore, as shown in Table VI, with the number of read being consistent, the execution time of fread in the Native environment is shorter than that in Wasm WASI, as expected. 

However, if the number of bytes read each time is adjusted to 2000 bytes, the situation changes. In the Native environment, each execution of the fread function reads 2000 bytes from the buffer; when the buffer is empty (approximately after 2 fread executions), the system performs a read syscall to read another 4096 bytes from the disk to refill the buffer. This indicates that in the $\mathrm { C / C } { + + }$ standard library, the buffer for read is also set to 4096 bytes. In the Wasm environment, each execution of the fread function directly corresponds to a read WASI call and a readv syscall. Each readv syscall reads 2000 bytes of file content. In this case, the fread function in Native and the read WASI in Wasm will, like the fwrite function, result in differences in execution counts and recorded times. 

# B. Case Analysis 2

Case 2 analyzes the impact of the asynchronous library on two runtimes, Wasmer and Wasmtime preview2. As shown in Figure8 and Figure 9. 

Wasmtime preview2 uses the Tokio asynchronous library. When performing I/O operations, three processes are executed in total. The runtime’s main process handles the read WASI calls (symbol ZN13wasmtime wasi8preview28...), while Tokio starts two asynchronous processes, with one 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/583bc119c35431f41409c559c3dda20e831b4bdb6e3eb30b0d14e00c87fad99d.jpg)



Fig. 8. Wasmtime preview2 wasmtime process executes read WASI


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/2e5334aeb11c770daeda066824a0f11538f9308da81624f628f95c836f8ce5a5.jpg)



Fig. 9. Wasmtime preview2 tokio-runtime-w process asynchronously executes $\_ { \mathrm { x 6 4 } }$ sys pread


of these processes executing the pread syscall (symbol x64 sys pread64 within libc pread), which is asynchronous with the runtime’s own WASI process. Similarly, Wasmer also uses this asynchronous library. Under heavy I/O load, these two runtimes exhibit certain peculiarities in their WASI and syscalls compared to other runtimes. 

In Figure 2, the write syscall time for Wasmer and Wasmtime preview2 is significantly longer than other runtimes. Referring to Table VII, it can be observed that the syscall times for several runtimes are quite similar, around 2100 ns. However, the number of syscalls for Wasmer and Wasmtime preview2 is twice that of the other runtimes. 

Using the Strace tool, the syscall processes for the two runtimes are traced. Figure 10 shows the syscalls for Wasmtime preview2, where other runtimes read two iov vectors in a single writev call, whereas Wasmtime preview2 uses two separate pwrite64 syscalls. Similarly, Figure 11 illustrates the syscalls of Wasmer. It also uses two separate write syscalls for reading. Given that the time for each syscall does not differ significantly, the doubled number of syscalls results in a longer total syscall time. 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/9e2f06067a6e758657de376993445ed108a4f5f32ee4b38c9aa8e4fe3fbfdbfa.jpg)



Fig. 10. Wasmtime preview2 Syscall: pwrite64


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-05/0641ad7a-0767-486c-bf11-0dd623ecf38c/8927b3e5cbc5b8204eaaea6e89bd5132a4d9b68e3de1f9d6507a3223440560ae.jpg)



Fig. 11. Wasmer Syscall: write


Tokio chooses to break down large writev into multiple smaller write due to the characteristics of the asynchronous library, considering the time-slice rotation mechanism of the operating system. A larger writev call might result in a longer execution time, delaying the execution of other tasks. Breaking it down into smaller operations can reduce long-time-slice occupancy, avoiding I/O or CPU bottlenecks caused by a single large operation. Additionally, breaking down operations increases the likelihood of completing them within a single time slice, thereby reducing the need for the operating system to perform context switches between tasks. In an asynchronous environment, executing short operations allows the asynchronous library to respond more quickly to other tasks, which is crucial for building high-performance asynchronous systems. 

As shown in Figure 3, the WASI execution time for Wasmer and Wasmtime preview2 is significantly longer than that for other runtimes. From Section IV-C, it can also be seen that the WASI execution time for these two runtimes accounts for a larger proportion of the total runtime. 

This is because the Tokio asynchronous library used in Wasmtime preview2 has not been specifically optimized for 

non-asynchronous scenarios. Tokio uses spawn blocking to implement blocking. Based on the configuration of the allow blocking current thread variable within the object, it decides whether to synchronously execute a closure in the current execution environment or asynchronously execute it through Tokio’s blocking thread pool to avoid blocking the current asynchronous execution environment. 

Although spawn blocking in Tokio is designed to handle synchronous operations that may cause blocking in an asynchronous execution environment by running these operations on dedicated threads, it aims to keep the asynchronous executor running efficiently rather than being blocked by a timeconsuming synchronous operation. However, the test cases used in this paper are synchronously sequential programs, and remains in a blocked-wait state during I/O operations without executing other computational tasks to improve performance. As shown in Figure 10 and Figure 11, this instead leads to additional context switching, synchronization mechanisms (futex), and thread management overhead, thereby introducing unnecessary performance burdens and adversely affecting WASI’s interaction performance during I/O operations. 

In the absence of sufficient parallel tasks or asynchronous logic to fully utilize the advantages of multithreading, these overheads may not be offset by the blocking time saved. In fact, in such cases, directly executing I/O synchronously may be more efficient because it avoids the complexity and additional resource consumption introduced by multithreading. Recently, to optimize this process [31], the open-source community has provided a flag option for wasiCtx that allows users to choose whether to call spawn blocking to execute on the current thread, thus avoiding blocking the main thread in synchronous scenarios. 

# VI. RELATED WORK

# A. Wasm Reliability

Some studies have empirically explored bugs related to Wasm [32]–[34]. Hilbig et al. [32] focused on bugs within Wasm modules, collecting and analyzing Wasm binaries from various real-world sources. Wang et al. [33] conducted the first empirical analysis of 867 bugs in four popular Wasm runtimes, uncovering the characteristics, impacts, and repair patterns of these bugs. They discussed the broad implications of their findings for bug detection, localization, debugging, and repair in Wasm runtimes. Romano et al. [34] performed qualitative and quantitative analyses of 1,200 bugs in three open-source Wasm compilers, deeply investigating the characteristics and impacts of these bugs, providing insights for designing tools to test and debug Wasm compilers. 

Other research has aimed to explore methods to ensure the security of Wasm module execution, whether by implementing sandboxing to ensure system security [35], [36] or by discovering inconsistencies in Wasm module execution [37], [38]. Abbadini et al. [36] proposed a method to enhance Wasm runtime sandboxing by using eBPF programs instead of traditional security checks, achieving finer-grained access security restrictions for the file system. Zhou et al. 

[37] designed a symbolic execution engine to generate test cases that can trigger runtime inconsistent behavior, proposing the differential testing framework WADIFF to evaluate the accuracy and reliability of Wasm runtimes. Cao et al. [38] proposed the differential testing framework WRTester, which generates complex Wasm test cases by decomposing and assembling real-world Wasm binaries to trigger hidden inconsistencies between independent runtimes. They designed a runtime-independent root cause localization method to accurately pinpoint errors in independent runtimes. 

# B. Wasm Performance Testing

Unlike traditional JS, Wasm as an emerging compilation target provides performance closer to native execution in the browser, empowering the development of web applications. In recent years, significant efforts have been focused on comparing various metrics of performance between JS and Wasm in the browser [15], [16], [39], providing directions for future optimizations of Wasm technology. The work by Yan et al. [15] and Wang [16] systematically reveals the characteristics and differences between Wasm and JS in terms of memory usage, execution time, and performance optimization. They also investigate whether browsers can optimize Wasm execution compared to JS. Macedo et al. [39] construct a benchmarking framework to explore whether Wasm has advantages in energy efficiency and runtime compared to JS. Romano et al. [40] elucidate how browser compilers optimize the execution efficiency of Wasm modules and study the counter-intuitive effects of function inlining optimization on the performance of Wasm module execution. 

Regarding performance testing of server-side Wasm, there is relatively less research [3], [11]. Spies et al. [3] measure metrics such as code size, startup time, and execution time in non-web environments, comparing different Wasm implementations with native code and JS optimized using asm.js. Jiang et al. [11] design a differential testing method called WarpDiff to identify performance issues in server-side Wasm runtimes and further analyze exceptional cases, summarizing seven popular categories of performance issues in independent runtime implementations of Wasm, sparking research into improving Wasm independent runtime implementations. 

However, existing research primarily focuses on identifying unreasonable implementations based on the overall execution time and final state of Wasm modules, with a lack of studies on testing the efficiency of independent runtime WASI implementations, making it difficult to evaluate the performance of runtime I/O interactions with the operating system via WASI. 

# VII. FUTURE WORK

In this work, we currently focus only on empirical analysis of I/O performance data, revealing performance issues in WASI during I/O processes in independent Wasm runtimes. By analyzing the causes of performance anomalies in two specific cases, the method provides recommendations for future performance improvements in runtime WASI. However, in this paper, we do not yet propose specific improvements 

for the performance issues in WASI implementations. Future research needs to include experiments to refine performance improvements. 

Besides, the proposed method automatically obtain performance data for WASI, but the identification of performance anomalies and the analysis of their causes still require manual intervention, which is inefficient. In the future, it is hoped that methods from other fields for automatic anomaly detection can be referenced to achieve automated identification of performance anomaly data and specific code locations. 

Additionally, since eBPF tools and the BCC framework are only applicable on Linux systems and certain system events on Windows are relatively closed, the tools developed in this paper currently only support performance monitoring on Linux systems. Future research will explore suitable methods to capture syscall events on Windows, making the tools applicable to a wider range of systems. 

# VIII. CONCLUSION

With the development of independent Wasm runtimes, Wasm is no longer confined to the browser but also offers a fast, scalable, secure, and sandboxed way to run the same code across all machines on the server side. In contrast to browser environments, the design proposals and implementations of the WebAssembly System Interface (WASI) remain in their nascent stages. Moreover, the implementation of the WASI interface exhibits considerable variability across different serverside runtimes. Inefficient interface implementations can slow down runtime interactions with the system, making it difficult to highlight Wasm’s performance advantages. Addressing this issue, in this paper, we proposes an eBPF-based performance analysis method for Wasm runtime I/O operations. By collecting performance data, the proposed framework aims to identify performance issues in the WASI implementations within Wasm runtimes. The framework does not only provide strong technical support for improving the performance of Wasm module execution in independent runtimes from the perspective of WASI implementation mechanisms but also stimulates future optimization efforts for more efficient independent runtimes and WASI implementations. 

# IX. ACKNOWLEDGMENTS

The work described in this paper was supported by the National Natural Science Foundation of China (No. 62202511) and Guangdong Natural Science Foundation General Program (Grant No. 2022A1515011713). 

# REFERENCES



[1] A. Haas, A. Rossberg, D. L. Schuff, B. L. Titzer, M. Holman, D. Gohman, L. Wagner, A. Zakai, and J. Bastien, “Bringing the web up to speed with webassembly,” in Proceedings of the 38th ACM SIGPLAN Conference on Programming Language Design and Implementation, 2017, pp. 185–200. 





[2] World Wide Web Consortium, “World wide web consortium (w3c) brings a new language to the web as webassembly becomes a w3c recommendation,” 2019. [Online]. Available: https://www.w3.org/ press-releases/2019/wasm/ 





[3] B. Spies and M. Mock, “An evaluation of webassembly in non-web environments,” in 2021 XLVII Latin American Computing Conference (CLEI). IEEE, 2021, pp. 1–10. 





[4] S. Shillaker and P. Pietzuch, “Faasm: Lightweight isolation for efficient stateful serverless computing,” in 2020 USENIX Annual Technical Conference (USENIX ATC 20), 2020, pp. 419–433. 





[5] V. Kjorveziroski and S. Filiposka, “Webassembly orchestration in the context of serverless computing,” Journal of Network and Systems Management, vol. 31, no. 3, p. 62, 2023. 





[6] ——, “Webassembly as an enabler for next generation serverless computing,” Journal of Grid Computing, vol. 21, no. 3, p. 34, 2023. 





[7] J. Men´ etrey, M. Pasin, P. Felber, and V. Schiavoni, “Webassembly as ´ a common layer for the cloud-edge continuum,” in Proceedings of the 2nd Workshop on Flexible Resource and Application Management on the Edge, 2022, pp. 3–8. 





[8] M. Nurul-Hoque and K. A. Harras, “Nomad: Cross-platform computational offloading and migration in femtoclouds using webassembly,” in 2021 IEEE International Conference on Cloud Engineering (IC2E). IEEE, 2021, pp. 168–178. 





[9] W. Chen, Z. Sun, H. Wang, X. Luo, H. Cai, and L. Wu, “Wasai: uncovering vulnerabilities in wasm smart contracts,” in Proceedings of the 31st ACM SIGSOFT International Symposium on Software Testing and Analysis, 2022, pp. 703–715. 





[10] M. Hacks, “Standardizing wasi: A webassembly system interface,” 2019. [Online]. Available: https://hacks.mozilla.org/2019/ 03/standardizing-wasi-a-webassembly-system-interface/ 





[11] S. Jiang, R. Zeng, Z. Rao, J. Gu, Y. Zhou, and M. R. Lyu, “Revealing performance issues in server-side webassembly runtimes via differential testing,” in 2023 38th IEEE/ACM International Conference on Automated Software Engineering (ASE). IEEE, 2023, pp. 661–672. 





[12] Y. Shi, K. Casey, M. A. Ertl, and D. Gregg, “Virtual machine showdown: Stack versus registers,” ACM Transactions on Architecture and Code Optimization (TACO), vol. 4, no. 4, pp. 1–36, 2008. 





[13] P. Ferris, “The design of webassembly,” 2023. [Online]. Available: https://www.freecodecamp.org/news/ the-design-of-webassembly-81f1dcabaddd/ 





[14] M. Musch, C. Wressnegger, M. Johns, and K. Rieck, “New kid on the web: A study on the prevalence of webassembly in the wild,” in Detection of Intrusions and Malware, and Vulnerability Assessment: 16th International Conference, DIMVA 2019, Gothenburg, Sweden, June 19–20, 2019, Proceedings 16. Springer, 2019, pp. 23–42. 





[15] Y. Yan, T. Tu, L. Zhao, Y. Zhou, and W. Wang, “Understanding the performance of webassembly applications,” in Proceedings of the 21st ACM Internet Measurement Conference, 2021, pp. 533–549. 





[16] W. Wang, “Empowering web applications with webassembly: Are we there yet?” in 2021 36th IEEE/ACM International Conference on Automated Software Engineering (ASE). IEEE, 2021, pp. 1301–1305. 





[17] L. Clark, “Memory in webassembly, and why it’s safer than you think,” 2017. [Online]. Available: https://hacks.mozilla.org/2017/07/ memory-in-webassembly-and-why-its-safer-than-you-think/ 





[18] W. Community, “Semantics - linear memory,” Accessed 2024. [Online]. Available: https://github.com/WebAssembly/design/blob/main/ Semantics.md#linear-memory 





[19] B. Alliance, “Bytecode alliance,” Accessed 2024. [Online]. Available: https://bytecodealliance.org/ 





[20] W. Team, “Webassembly micro runtime (wamr) documentation,” Accessed 2024. [Online]. Available: https://wamr.gitbook.io/document/ 





[21] Wasmerio, “Wasmer - the universal webassembly runtime,” Accessed 2024. [Online]. Available: https://github.com/wasmerio/wasmer 





[22] W. Contributors, “Wasm3 - a fast webassembly interpreter,” Accessed 2024. [Online]. Available: https://github.com/wasm3/wasm3 





[23] W. Team, “Wasmedge: A lightweight, high-performance, and extensible webassembly runtime,” accessed 2024. [Online]. Available: https: //wasmedge.org/ 





[24] B. Alliance, “Wasmtime: A fast and secure runtime for webassembly,” accessed 2024. [Online]. Available: https://wasmtime.dev/ 





[25] W. Community, “Wasi-sdk: Wasi-enabled webassembly $\mathrm { c / c } { + + }$ toolchain,” Accessed 2024. [Online]. Available: https://github.com/ WebAssembly/wasi-sdk 





[26] “Wasm abis webassembly guide,” Accessed 2024. [Online]. Available: https://www.webassembly.guide/webassembly-guide/ webassembly/wasm-abis 





[27] W. C. Group, “Wasi proposals,” Accessed 2024. [Online]. Available: https://github.com/WebAssembly/WASI/blob/main/Proposals.md 





[28] — “Webassembly specifications,” Accessed 2024. [Online]. Available: https://webassembly.org/specs/ 





[29] “Llvm test suite guide,” Accessed 2024. [Online]. Available: https: //llvm.org/docs/TestSuiteGuide.html 





[30] W. Contributors, “v18.0.0: Release wasmtime 18.0.0 (7958),” accessed 2024. [Online]. Available: https://github.com/bytecodealliance/ wasmtime/releases/tag/v18.0.0 





[31] W. Issues, “Poor performance of wasmtime file i/o maybe because tokio,” accessed 2024. [Online]. Available: https://github.com/bytecodealliance/wasmtime/issues/7973 





[32] A. Hilbig, D. Lehmann, and M. Pradel, “An empirical study of realworld webassembly binaries: Security, languages, use cases,” in Proceedings of the web conference 2021, 2021, pp. 2696–2708. 





[33] Y. Wang, Z. Zhou, Z. Ren, D. Liu, and H. Jiang, “A comprehensive study of webassembly runtime bugs,” in 2023 IEEE International Conference on Software Analysis, Evolution and Reengineering (SANER). IEEE, 2023, pp. 355–366. 





[34] A. Romano, X. Liu, Y. Kwon, and W. Wang, “An empirical study of bugs in webassembly compilers,” in 2021 36th IEEE/ACM International Conference on Automated Software Engineering (ASE). IEEE, 2021, pp. 42–54. 





[35] J. Bosamiya, W. S. Lim, and B. Parno, “{Provably-Safe} multilingual software sandboxing using {WebAssembly},” in 31st USENIX Security Symposium (USENIX Security 22), 2022, pp. 1975–1992. 





[36] M. Abbadini, M. Beretta, D. Facchinetti, G. Oldani, M. Rossi, and S. Paraboschi, “Poster: Leveraging ebpf to enhance sandboxing of webassembly runtimes,” in Proceedings of the 2023 ACM Asia Conference on Computer and Communications Security, 2023, pp. 1028–1030. 





[37] S. Zhou, M. Jiang, W. Chen, H. Zhou, H. Wang, and X. Luo, “Wadiff: A differential testing framework for webassembly runtimes,” in 2023 38th IEEE/ACM International Conference on Automated Software Engineering (ASE). IEEE, 2023, pp. 939–950. 





[38] S. Cao, N. He, X. She, Y. Zhang, M. Zhang, and H. Wang, “Wrtester: Differential testing of webassembly runtimes via semantic-aware binary generation,” arXiv preprint arXiv:2312.10456, 2023. 





[39] J. De Macedo, R. Abreu, R. Pereira, and J. Saraiva, “On the runtime and energy performance of webassembly: Is webassembly superior to javascript yet?” in 2021 36th IEEE/ACM International Conference on Automated Software Engineering Workshops (ASEW). IEEE, 2021, pp. 255–262. 





[40] A. Romano and W. Wang, “When function inlining meets webassembly: Counterintuitive impacts on runtime performance,” in Proceedings of the 31st ACM Joint European Software Engineering Conference and Symposium on the Foundations of Software Engineering, 2023, pp. 350– 362. 

