# Andrei Gulin

# Evaluating the performance of WebAssembly compared to JavaScript in CPU-intensive browser applications

Bachelor’s thesis 

Bachelor of Engineering 

Degree Programme in Information Technology 

2025 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-02/7c362c03-7d21-43f2-863b-71a9aa90e2ce/c48eb541b8c129c60fba10d4e8c77169c54db13816c32f62a2f93ba2ba9ced6f.jpg)


South-Eastern Finland University of Applied Sciences 

Degree title Bachelor of Engineering 

Author(s) Andrei Gulin 

Thesis title Evaluating the performance of WebAssembly compared to JavaScript in 

CPU-intensive browser applications 

Year 2025 

Pages 40 pages 

Supervisor Miika Reijonen 

# ABSTRACT

Web applications’ complexity grows, and frequently developed tasks for desktop applications migrate into the web. JavaScript as the main language of the web has evolved significantly with advances in just-in-time compilation and engine optimizations, but its limitations do not allow to efficiently process computationally heavy workloads. WebAssembly emerged as a technology that would target JavaScript’s limitations by providing portability, near-native performance while maintaining browser security. 

The objective of this study was to compare and evaluate the performance of JavaScript and WebAssembly in CPU demanding image processing tasks by implementing a web application framework for testing. 

Three image processing algorithms were selected and implemented in the web framework: image inversion, edge detection using Sobel operators with Gaussian blur, and K-Means color quantization using K-Means++ method for initialization. Each algorithm had different computational complexity and was implemented identically in pure JavaScript and Rust compiled to WebAssembly to ensure adequate comparison. 

The testing stage utilized four datasets including various images with different dimensions and formats. All execution tests were made in Google Chrome on Linux using the V8 JavaScript engine. Performance measurements captured execution time, cold start overhead, performance consistency, scaling behavior across image sizes and the file formats impact. 

The results demonstrated that WebAssembly consistently outperformed JavaScript across all tested scenarios, except the cold start overhead metric. Additionally, the evaluation revealed unexpected non-linear scaling patterns where WebAssembly’s speedup factor peaked at medium image sizes for certain algorithms. The evaluation was supported by visual feedback developed in the web application framework. The web application framework is open-sourced and publicly available. 

Keywords: WebAssembly, JavaScript, image processing, browser applications 

# CONTENTS

# 1 INTRODUCTION

1.1 Background and motivation 

1.2 Problem statement 

1.3 Objectives and research questions 

1.4 Scope and limitations 

# 2 BACKGROUND

2.1 JavaScript - history, design, and compilation strengths and weaknesses 

2.2 WebAssembly - history, design, compilation, and integration with JS 

2.3 Runtime performance considerations in CPU-heavy tasks 

# 3 RELATED PREVIOUS STUDIES

3.1 Previous comparisons of JavaScript and WebAssembly 

3.2 Use cases in practice. 

3.3 Gaps in research 

# 4 RESEARCH DESIGN AND METHODOLOGY

4.1 Research approach 

4.2 Selection of workloads 

4.3 Metrics for evaluation 

4.4 Tools and environment 

4.5 Methods of collecting data 

# 5 IMPLEMENTATION

5.1 Application concept 

5.2 User Flow 

5.3 Browser Environment and Execution 

5.4 Architecture and Feature Implementation 

5.5 Selected workloads implemented 

5.6 Implementations in JavaScript 

5.7 Implementation in Rust to WASM 

# 6 EVALUATION

6.1 Color inversion performance analysis 

6.2 Edge detection performance analysis 

6.3 K-Means Color Quantization Performance Analysis 

# 7 DISCUSSION

7.1 interpretation of results 

7.2 Synthesis of Findings 

7.3 Practical Implications for Developers 

7.4 Limitations of the study 

# 8 CONCLUSIONS

# 9 FUTURE PERSPECTIVES

# REFERENCES

# 1 INTRODUCTION

# 1.1 Background and motivation

With each passing day, web applications become increasingly complex and capable, frequently performing tasks that were originally developed for native desktop applications, such as complex and large image manipulations. Although the development of JavaScript, the primary language of the web, and its infrastructure such as JavaScript engines, has been rapid (Krylov 2020), JavaScript has its limitations, and it's not capable of covering all web operations. A typical example of a job not suitable for JavaScript would be any computationally heavy workload. 

There are developing technologies specifically targeting these limitations, such as WebAssembly (Haas 2017). WebAssembly (WASM) is a low-level, portable binary format that can run alongside JavaScript in both browser and server environments. It allows developers to compile low-level languages such as Rust or $\complement / \complement { + + }$ into efficient modules that can be executed at near-native speed (Haas 2017). With the possibility to integrate WebAssembly into JavaScript, there are fewer speed limitations, which makes it appealing for developers. 

The purpose of this study is to analyze and compare the performance of JavaScript and WebAssembly on CPU intense tasks, eventually identifying whether WebAssembly is more suitable for handling heavy, medium, or minor computational tasks than JavaScript. 

# 1.2 Problem statement

The performance of WebAssembly differs depending on a variety of factors, such as the runtime, integration of JavaScript with WebAssembly, workload type, and browser (Yan 2021). Although WebAssembly promises near-native execution, most studies focus on specifically narrow or synthetic cases that do not fully prove WebAssembly's capabilities on real computationally intense web workloads. The thesis aims to define the real-world conditions and tasks in which WebAssembly might outperform JavaScript by building a showcase application allowing the user to experience the performance and understand which technology is better suited for computational tasks, such as image manipulations. 

# 1.3 Objectives and research questions

The main objective of this paper is to compare and evaluate the performance of WebAssembly and JavaScript in workloads involving medium or high computations, such as image manipulations. 

In order to achieve this, the study focuses on answering the following questions: 

● Which CPU-heavy-medium workloads are common in real-world web applications? 

● What are the performance characteristics of JavaScript and WebAssembly in these tasks? 

● What are the main trade-offs between implementing CPU-heavy workloads, such as image manipulations in JavaScript versus Rust compiled to WASM? 

# 1.4 Scope and limitations

The focus of this study lies exclusively on the performance evaluation of CPU-intensive tasks commonly found on the web, such as mathematical operations on large data structures, e.g. images. Since the main focus is on performance, narrower specifications such as I/O latency, security, or network connection are not addressed. 

The implementation will be limited to pure JavaScript and Rust compiled to WebAssembly using wasm-bindgen. The reason to use standard JavaScript and not a framework is that additional optimizations of the framework could compromise the accuracy of the comparisons. All experiments are conducted in a Linux desktop environment using Google Chrome, which runs on the V8 JavaScript engine. 

# 2 BACKGROUND

# 2.1 JavaScript - history, design, and compilation strengths and weaknesses

JavaScript was created by Brendan Eich in 1995 to enable interactions in web pages. Its initial purpose was simple client-side scripting, but over time, it evolved into the most commonly used, general-purpose language, capable of managing large-scale web applications and even being run on the server (Ortiz 2014). 

The evolution of JavaScript has directly influenced its performance characteristics. For instance, the introduction of Typed Arrays in Spider Monkey has influenced its performance on the video and audio data, enabling efficient binary manipulations by providing direct memory access and bypassing JavaScript’s dynamic type system for arrays. 

The evolution was driven not only by improvements to the language itself but also by the development of JavaScript engines, such as V8 in Google Chrome and SpiderMonkey in Firefox. These engines are responsible for parsing, optimizing, and executing JavaScript code. Initially, JavaScript was purely interpreted, which made it slower than compiled languages. However, the introduction of Just-In-Time (JIT) compilation significantly improved its performance (Svensson 2001). JIT compilers monitor frequently executed code sections and dynamically translate them into optimized machine code at runtime, improving execution speed while maintaining the flexibility of interpretation. 

In order to better understand JavaScript’s performance behavior, its execution cycle must be examined. The source code is fetched by the browser’s JavaScript engine, parsed into an abstract syntax tree (AST), and later interpreted into byte code which is a representation of the source code that the browser can process and the interpreter can execute. Once the interpreter starts to execute code, the JIT compiler selectively compiles frequently executed code sections into machine code, which is significantly faster to process, while the engine continuously collects runtime feedback to optimize new code sections or deoptimize wrongly optimized sections. Garbage collection is another important part of the cycle. This refers to periodically clearing unused memory, which sometimes can cause small, unpredictable pauses in execution. 

JavaScript’s strengths lie in its flexibility, dynamic typing, and broad ecosystem. Its strengths make it appealing to developers because it is easy to use, largely supported, and the large user community helps to answer user questions. Unfortunately, JavaScript also has its weaknesses. Dynamic typing introduces runtime overhead because type checks must be performed during execution (Li, Cheng 2011). Garbage collection can produce unpredictable pauses, impacting responsiveness. These negative characteristics limit JavaScript computational performance, motivating the development of new technologies such as WebAssembly. 

# 2.2 WebAssembly - history, design, compilation, and integration with JS

WebAssembly (WASM) emerged in 2017 as a low-level, portable binary format designed to deliver near-native performance to web applications (Haas 2017a). Its purpose is not to replace JavaScript, but to complement it, allowing developers to execute computationally intensive code efficiently while maintaining security and portability across environments. 

The origins of WebAssembly can be traced back to earlier attempts to execute non-JavaScript code efficiently inside browsers. One of the first and major steps in this direction was Emscripten, a toolchain developed by Alon Zakai that compiled C and ${ \mathsf { C } } { + } { + }$ code into JavaScript (Jiang and Jin 2017; Zakai 2018). Sometime later, Luke Wagner, an engineer from Mozilla’s JavaScript engine team, noticed that some subsets of JavaScript - particularly those generated by Emscripten - could be extremely efficiently optimized by JIT compilers (Wagner 2015). This was because JavaScript code produced from a low-level, manually memorymanaged language, such as $\complement / \complement { + + }$ , often saved original characteristics of $\complement / \complement { + + }$ , such as static typing or linear memory access, which made it predictable for optimization. 

Wagner and Zakai began collaborating on a statically typed, low-level subset of JavaScript called asm.js. Asm.js code contained only the highly optimized patterns of JavaScript code that compilers could process efficiently, demonstrating that near-native performance was possible directly in the browser without altering the web platform itself. Although it seemed a promising future, Asm.js had noticeable limitations. The generated asm.js code was large and difficult to parse, and it remained constrained by JavaScript’s execution cycle. It was clear that there was a need for a new standard that would cover these inefficiencies . 

WebAssembly has become the standard for addressing JavaScript limitations. It provides a compact, binary instruction format, leading to a smaller file size compared to files of asm.js; it can be decoded and compiled directly into efficient machine code, omitting JIT compilation entirely, in contrast to asm.js. WebAssembly retained JavaScript’s sandboxed execution model, meaning it still required integration with JavaScript, but it managed to deliver faster load times and provide independence from JIT compilation, which was a great breakthrough (Yan 2021). 

# 2.3 Runtime performance considerations in CPU-heavy tasks

When comparing JavaScript and WebAssembly, it is important to remember that computational performance is determined not only by the technology design, but also by the way runtimes execute and optimize code. In this section, the execution and optimization of code are examined for each technology. 

Modern JavaScript engines, such as V8 and SpiderMonkey, perform several operations: parsing, compilation, execution optimization, de-optimization and re-optimization, and garbage collection (Wang 2022). Each process can introduce variability in performance and unpredictability, especially JIT (Just-In-Time) compilation. As mentioned earlier, the JIT compiler monitors execution behavior to identify frequently executed code sections to optimize them dynamically. When assumptions about code execution fail, the JIT must deoptimize wrongly optimized code sections, making performance unstable, especially when there are many data structure changes, for instance, changes in variable types (Kedlaya 2014). 

WebAssembly avoids most of the dynamic overhead that exists in JavaScript. WASM modules are compact binary representations that the runtime needs to decode, validate, and compile into machine code before execution (Ţălu, 2025). The approach taken by WebAssembly avoids repeated compilations and time delays related to unstable JIT optimizations, leading to more predictable and consistent performance. Additionally, WebAssembly’s binary format is more compact than JavaScript source files, making it faster at fetching. Although WebAssembly manages to escape the overhead that exists in JavaScript, its existing execution module and its separate linear memory model introduce overhead of copying the data from one memory space to WebAssembly’s linear memory, directly impacting the performance with images, for example. 

However, there are limitations applied to both technologies. For example, both JavaScript and WebAssembly run inside managed environments that affect performance. In browser environments, both JavaScript and WebAssembly share the same event loop and singlethreaded model, which limits parallel execution (Rajani 2015). For many typical web workloads the performance is similar because of these limitations,. Yet in CPU-bound tasks, WebAssembly is executed closer to the machine, improving its performance. 

WebAssembly’s main performance drawback lies in its linear memory model. For image processing, for example, pixel data must be transferred into WASM’s linear memory, then processed, and finally transferred back. This creates overhead and affects performance. 

Despite WebAssembly’s disadvantages, it supports deterministic memory access, threading, and SIMD (Single Instruction, Multiple Data), which expedites machine code production compared to JIT. Because of these features, WebAssembly can achieve near-native performance, while JavaScript’s execution remains constrained by garbage collection, dynamic typing, and limited access to hardware parallelism. 

As a result, while JavaScript maintains strengths in flexibility, rapid iteration, and integrations with web APIs, WebAssembly offers near-native performance for applications that demand efficient numerical computations, parallelism, and largely predictable execution times. 

# 3 RELATED PREVIOUS STUDIES

# 3.1 Previous comparisons of JavaScript and WebAssembly

Primarily, JavaScript and WebAssembly have been compared in terms of computational efficiency, startup time, and runtime predictability. There are several academic works that have analyzed WebAssembly’s performance across different computational kernels, often demonstrating that WASM achieves 1.2 to 10 times faster execution speed compared to an optimized set of JavaScript, depending on the workloads (Haas 2017). Benchmarking efforts by Mozilla and Google’s V8 teams have further confirmed that WebAssembly significantly reduces parsing and compilation times due to its compact, binary format, offering faster fetching, and more stable execution. However, these results vary, and few studies compare JavaScript and WebAssembly on real computationally heavy or medium-heavy workloads. 

# 3.2 Use cases in practice.

Numerous large-scale web applications have already adopted WebAssembly in some form, yielding valuable insights. For instance, Figma utilizes WebAssembly for executing its vector graphics engine in the browser(Tufegdžić 2024). Similarly, AutoCAD Web has adopted WebAssembly to bring a native desktop CAD application to the web without losing computational precision or performance(He 2025). WebAssembly has been largely used in browser-based gaming, where game engines such as Unity or Unreal Engine compile their 

native ${ \mathsf { C } } { + } { + }$ code to WASM for efficient rendering performance (Kim and Khomtchouk 2021). These examples highlight WebAssembly’s potential in bringing near-native computation into the browser environment while maintaining compatibility with the existing web platforms. 

# 3.3 Gaps in research

Despite the increasing adoption, gaps remain in the practical study of WebAssembly’s performance characteristics. Most prior work has focused on synthetic benchmarks, while real-world data processing workloads have not yet been sufficiently compared. Existing research focuses on comparing two technologies statically, meaning that tests are executed in an isolated environment where data has already been put permanently in WebAssembly’s memory, and where there is no JavaScript integration overload. By providing a solution where the user can interact with the tests themselves and compare the real performances of JavaScript and WebAssembly, this gap in the research is addressed. Additionally, no study seems to have examined how the performance reacts with image data and how scalable and relevant the usage of WebAssembly or JavaScript is. 

# 4 RESEARCH DESIGN AND METHODOLOGY

# 4.1 Research approach

This study will employ a mixed exploratory and experimental approach to conduct practical benchmarking. The first stage of study involves a literature review to establish the theoretical framework for JavaScript and WASM’s processes concerning compilation and memory management on CPU-heavy workloads. The second phase involves reviewing existing use cases and industry implementations written in these languages. Real examples help determine applicable metrics and workload structures. The final phase is experimental, where the gathered data is applied to design and execute tests and benchmarks that help compare JavaScript and WebAssembly on practical, rational workloads and provide visible and interactive results. Most of the experiments are focused on realistic image manipulation tasks, also used to reflect heavy computations mainly. However, a few simple non-intensive workloads are chosen for comparison. This structure aims to provide a balanced foundation for the understanding and practical validations of the differences in performance between JavaScript and WebAssembly. 

# 4.2 Selection of workloads

The workloads used in the study are mainly focused on image processing as it is one of the most common and computationally demanding workloads on the web. The chosen tasks vary in complexity to capture a broad range of performance behaviors of both JavaScript and WebAssembly. 

For lightweight image manipulation, commonly used in social media platforms, performing color inversion is selected. This operation was chosen because its algorithm is very straightforward, and it does not require much computational power. For medium-weight image manipulation, Edge detection is selected. This operation requires slightly more computational power due to the matrix usage that enforces more arithmetical computations. For highintensity operation, which should stress the CPU, K-Means color quantization is selected, implemented using nested loops and matrix multiplication, which stresses the CPU due to its heavy computational requirements. 

# 4.3 Metrics for evaluation

In order to provide adequate comparisons, the same algorithms are implemented both in JavaScript and Rust compiled to WebAssembly. The study focuses on performance indicators that can be observed directly in the demo environment on the web. There are five distinct metrics to be measured: execution time (in milliseconds), cold start overhead (in milliseconds), pixel processing rate (megapixels per second), performance consistency, and image size impact. Execution time is the most direct performance indicator because it represents the raw computational speed. Cold start overhead measures the difference in performance between the first execution run and the following runs. The main reason to include this metric is the initialization costs involved in the first execution, such as JIT compilation overhead for JavaScript and module instantiation for WebAssembly. The pixel processing rate metric shows whether performance scales linearly with the input size by normalizing image dimensions. Performance consistency is another important metric measured in this study. It is intended to explore potential spikes in performance and the predictability of the performance. The last metric measured is the impact of the image size. This metric has been designed to determine whether image dimensions linearly impact the performance or not, and to answer the general question of how image dimensions affect performance. 

These metrics aim to capture both computational performance and behavioral characteristics of JavaScript and WebAssembly runtimes under image workloads that require varying levels of computational power, from high to low. 

# 4.4 Tools and environment

In order to achieve an adequate comparison of the results, all tests are run on the same browser, hardware, and image inputs at the same time, although for experimental usages, other browsers and hardware products might be examined as well. All experiments are conducted in Google Chrome on a Linux desktop, using the browser’s built-in V8 JavaScript engine and WebAssembly runtime. JavaScript is used for baseline implementation, and Rust compiled to WebAssembly is used via wasm-pack and wasm-bindgen, helping to generate optimized WASM modules. Performance API is used to track performance. Each test is run for multiple iterations, depending on image dimensions which heavily affect computational performance. Using multiple iterations helps minimize variance from garbage collection and system interruptions. These methods of tooling allow both runtime-level and browser-level measurements, since they are well-suited for this study. Additionally, the application is hosted on GitHub Pages and publicly available for testing and verification purposes. 

# 4.5 Methods of collecting data

In this study, several methods are used to collect data. Data is collected dynamically inside the web application. During execution using the browser’s Performance API, each experiment records all metrics defined in Section 4.3, execution time, cold start overhead, pixel processing rate, performance consistency and image size impact. After each execution run, measurements are taken, and iterations are repeated to help minimize the influence of background processes and other execution cycle noises. Measurements are automatically aggregated and analyzed. The use of these methods aims to ensure consistent and reliable data collection, allowing accurate performance comparisons. 

# 5 IMPLEMENTATION

This section introduces the performance comparison web application developed for this study. The application consists of three interactive test sections where the user can test comparisons on their own image examples using their own machine. Each test section 

provides two containers for displaying post-processed images, one for JavaScript and another for WebAssembly. Both containers take the uploaded image and process it using the same algorithm, implemented in different programming languages using different technologies. All test sections have different image processing algorithms to demonstrate the impact of the computational complexity on the performance. After execution, performance data is recorded in statistics, and visual feedback is calculated and provided through interactive metrics. The following sections further describe the application’s design choices, algorithm implementations, and technical decisions. 

# 5.1 Application concept

The core concept of this application is to provide users with the ability to test and compare the performance of WebAssembly and JavaScript using their own examples, while also being able to see the visual feedback and statistics, and observe and evaluate different metrics. The concept differs from the original way of benchmarking which outputs raw data; in that the application encourages users to observe the performance visually. The user decides what tests to conduct and what images to select for processing. The application is designed not to provide the user with an overwhelming amount of data, but rather to give the statistics and visualization, helping the user understand where WebAssembly outperforms JavaScript. 

The application was designed with several key principles in mind. Firstly, the clarity is important, and the user should always be able to understand what the application is doing at any given moment. When tests are executed, the application should clearly indicate what technology is currently in use and what progress has been made. Clarity helps users to interpret metrics better and be able to provide adequate feedback regarding the performance of the technologies. 

The second important principle is fairness; both WebAssembly and JavaScript should have implementations of identical algorithms with the same computational complexity. Additionally, to verify that implementations produce identical results, the application ensures that every pixel of output images is identical after each test. 

The third principle is the coloring theme that was designed to easily understand which color represents which technology. JavaScript is represented in golden yellow throughout the 

interface, while WebAssembly is represented in its original branding purple color. The use of a continuous theme helps users to stay engaged and follow the execution cycle. 

Fourth, the information that has been shown and gained throughout the execution process should be accessible and easily interpreted by the user. Therefore, all metrics and statistics are accompanied with thorough deep explanations of what they measure and why they are relevant for the technology performance comparisons. 

# 5.2 User Flow

The application's purpose becomes clear after understanding the typical user flow. When the application is opened, the heading and clear text formatting already communicate the application's concept to the user. 

The testing begins with the user selecting an image and uploading it to the application’s test section. After a successful image upload, the image dimensions are identified and compared to the predefined limitations to notify the user if the image is too large for test processing. These limitations vary by tests due to different test computational complexities; more lightweight operations can handle larger images, and heavier operations keep images smaller in order to keep execution times reasonably short. 

Once the image is uploaded and dimensions are verified, it is displayed with the dimensions shown. The limitations for the dimensions not only reject too large images but also select several runs per test to make execution speed reasonable. After every aspect of the test is determined, it is ready to be executed. When the user starts the test, an overlay appears on the top of the container that is currently being executed, displaying a countdown message. The overlay displays iteration progress throughout the testing process in order for the user to follow the execution cycle. This visual feedback helps to reassure the user that the application is actively working, and all iterations are being executed. After one container finishes, the next container is being prepared, and the execution begins immediately after preparation. The sequential approach is essential for maintaining adequate and systematic comparisons. 

After both operations have finished their execution, the results are verified for identicality. After verifying that JavaScript’s output is identical to WebAssembly’s output, the verification badge indicator is displayed, and the statistics and metrics are shown below the test. 

The detailed statistics include several metrics displayed through interactive line charts, and prior to the statistics, general execution performance is shown, after which the user can see which technology performed faster and how much the time difference was. The user can change metrics using metric tabs. Each metric contains a specifically configured line chart and description, of its usage and purpose. In the broad range of statistics section, users will find different statistical measurements such as median, mean, minimum, maximum, and standard deviation for both technologies. Together, all this data provides valuable insights into the comparison of the performances of WebAssembly and JavaScript. 

# 5.3 Browser Environment and Execution

Unlike the traditional approach of utilizing the server’s computational power, all operations in the application are executed on the user's machine directly in the browser. This decision was made because the server's computational load would be overwhelmed if numerous users performed heavy operations simultaneously. 

In order to function properly, the application must be run in the browser with full support of WebAssembly. While the application specifically targets Google Chrome with the V8 JavaScript engine, it can also be opened and utilized in other browsers. The application utilizes multiple browser APIs. For example, the performance API is used to measure timing throughout the test iterations. The Canvas API is largely used on image loading operations for converting displayable images into operable image data for processing and back. The File API enables users to be able to select files from their local file system. Additionally, the browser’s session and local storage are utilized to cache test statistics. 

# 5.4 Architecture and Feature Implementation

The structure chosen for the application is modular, separating functionality into distinct components. The structure was chosen because it made the development lifecycle manageable, given the constraint of using pure JavaScript without frameworks. The codebase is divided into five main modules: app controller, benchmark module, UI (user interface) module, utilities module, and configuration module. Each module serves a specific purpose and communicates with other modules. The first module loaded in the application is the app controller module which has actions for triggering tests and file upload functions, and perform 

metric tab changes. The application controller module is the main unit of the application that provides connections between other modules. When a test is selected, the app controller module calls the benchmark module which is responsible for executing each test. After the execution of each test, the UI module is called, and the results from the benchmark module and statistics are displayed in UI. The UI module is responsible for any UI change, such as displaying metrics, statistics, badges, and other visualizations. The fifth module is the utilization module which is processing all additional functionality, for example image conversions. 

The application contains various important features. The first essential feature is sequential test run execution. The decision to run tests sequentially rather than concurrently was not obvious, since the concurrent approach of having two operations simultaneously would allow the user to see which technology is faster by observing the user interface of the execution. Although this concurrent approach was appealing from a visual perspective, running JavaScript and WebAssembly simultaneously would make both technologies compete for memory bandwidth, cache space, and CPU resources, making the results of performance ambiguous. In contrast, the sequential execution ensures that each technology is provided with an exclusive opportunity to access system resources for the time of execution, producing precise measurements of the execution. 

The second critical feature is the delay before starting a new test and the delay before starting a new iteration of the test. A preparation delay is necessary in order to allow the system to stabilize. Without the delay, previously run computations could persist and affect the performance of subsequent iterations, skewing the results of the comparison. The delay between iterations within a test execution prevents one iteration environment from influencing the next. During all delays, the browser can process pending additional tasks, such as UI changes, and JavaScript’s garbage collector can clear up the space. 

The third important implementation feature is the fetching and caching of modules. The first time a test executes, the application must fetch the WebAssembly processing module and JavaScript processing module. Even though the JavaScript module is ready to be executed immediately, the WebAssembly module must request and fetch WebAssembly binary files, instantiate them, and compile them to machine code. The difference between the cycles of fetching these operations can affect the performance during the first run. In order to achieve 

realistic performance, the benchmark module caches initialized WebAssembly modules after its first usage in order to exclude the need to fetch and initialize the same module again. 

# 5.5 Selected workloads implemented

There are three tests in the application, each corresponding to a certain computational complexity. Color inversion is the most trivial operation tested in the application. The logic behind the algorithm is to invert each color channel by subtracting each current color value from the maximum color value, which is 255 in RGB format. For example, for a pixel with RGB values (200, 150, 100), the inversion produces values (55, 105, 155). The effect is that light pixels become dark and vice versa. The alpha channel, which is the channel corresponding to transparency of the pixel, stays intact. The computational complexity of color inversion is linear O(n), where n is the pixel count. 

For the second test, edge detection with Sobel operators was chosen. It is a more computationally heavy algorithm commonly used in computer vision to identify boundaries of regions. It was discovered later during the implementation that merely the usage of Sobel operators was not sufficient to produce adequate results. Therefore, Gaussian blur was added before applying the Sobel operators and the threshold after, which helped to reject falsely selected edges. The Gaussian blur is the algorithm that slides a 3x3 kernel to reduce noise and to make pixels look smoother by normalizing pixel values inside the kernel. After applying blur, the algorithm uses two kernels that are responsible for edge detection, called Sobel kernels. The Sobel horizontal kernel detects vertical edges, and the vertical kernel detects horizontal edges. For example, when a horizontal kernel is applied to a pixel, it multiplies all nearby pixels by the weights of the kernel, and if the changes in pixels occurring from left to right of the kernel are significant, then the vertical edge is detected. This detection is made using a horizontal gradient. When a horizontal gradient is produced after applying the horizontal kernel, the value of the gradient indicates how rapidly brightness changes horizontally, and the same method is relevant to the vertical kernel. After receiving gradients indicating whether there is a horizontal or vertical edge, the gradient magnitude is calculated using Equation 1, which shows whether a certain area has edges and how strong the edges are. The final stage of the algorithm is applying the threshold which converts pixels with a magnitude higher than the threshold to a 255 value, or white, and gradients below the threshold to black. The computational complexity remains O(n), although this algorithm contains significantly more arithmetic operations, increasing computational demands. 

$$
G = \sqrt {G _ {x} ^ {2} + G _ {y} ^ {2}} \tag {1}
$$

where 

G gradient magnitude [-] 

$G _ { x }$ horizontal gradient [-] 

G y vertical gradient [-] 

For the third test, K-Means quantization was chosen. It is a heavy computation algorithm that reduces the number of distinct colors in the image by finding which colors are sufficiently similar to be represented by a single replacement color. In order to achieve the desired result, the algorithm uses RGB as a 3-dimensional space, putting each pixel by using its RGB color values into the space. After all pixels in an image point inside the RGB dimensional space, the algorithm attempts to find K representative points or centroids in the space, each centroid seeking to replace as many nearby points as possible. The process of finding the correct centroids is executed iteratively by optimizing the distances to the nearest points. Initially, K centroids should be selected. There are several ways of doing so. It is possible to randomly select K values or use intelligent K-Means $^ { + + }$ initialization. A random selection of K values often results in poor results, whereas K-Means $^ { + + }$ initialization deliberately spreads centroids across the color space, by choosing sequentially each from what location of an original image where the centroid should be taken. For example, the first centroid can be taken from the middle of the image, the second centroid from as far as possible from the first on, and the third centroid from as far a possible from the first and the second ones. The process continues until all the centroids are assigned. After the initialization is complete, the algorithm iterates the loop, executing one of operations: assignment or update. When the assignment operation is executed, all the image pixels are assigned to take the value of the nearest centroid in the RGB dimensional space. After assigning all pixels to their nearest centroids, new centroids are calculated. This is the update process. The new pixels assigning and updating centroids can be repeated multiple times until there are no more significant changes in the centroids, which indicates that the most stable clusters of colors have been defined. After the discovery of the most stable centroids, every original pixel in the image is replaced by the nearest centroid’s color value, reducing the number of colors throughout the image. The computational complexity of this algorithm is high, calculated as $\mathsf { O } ( \mathsf { n } ^ { \star } \mathsf { k } ^ { \star } \mathsf { i } )$ , where n is the pixel count, k is the centroid count, and i is the iteration count. 

# 5.6 Implementations in JavaScript

As noted before, the application uses pure JavaScript, ensuring simplicity and comparability. This section describes specific details related to JavaScript implementations. 

Color inversion algorithm for the first test has a straightforward implementation. A For loop that iterates through each pixel by accessing a pixel data array which is stored as a Uint8ClampedArray. Each loop iteration modifies RGBA (red, green, blue, alpha) values of each pixel by subtracting them from 255, while leaving the alpha channel unchanged. The alpha channel is not modified as it is responsible for transparency. Originally the loop receives a fresh ImageData object, and it can modify this object directly without the need to make a deep copy of the object, saving space and time of execution. A modified ImageData object is returned to the caller. Because of the simplicity of the implementation, the JIT compiler should be able to optimize it significantly, theoretically making the performance comparable to WebAssembly’s implementation. 

Edge Detection implementation follows a more complicated approach. Firstly, a Gaussian blur is applied, the grayscale is produced, and pixels are smoothed out. After the blur, two Sobel kernels are introduced for both horizontal detection (SobelY) and vertical detection (SobelX). They are introduced sequentially, which is most likely not the most efficient way, but the code is readable and sufficiently manageable. Both kernels are applied in the nested loops. The outer loop scans across pixels, excluding borders, due to the need for a 3x3 space, and the inner loop iterates through the kernel positions. For every pixel, the code must analyze 8 adjacent pixels and the center pixel itself, average the related RGB values, multiply all 9 pixels by specific kernel weights, and add everything up in order to achieve horizontal or vertical gradients depending onthe kernel that is used. After gradients are calculated, the magnitude is calculated using equation 1, which indicates the overall strength of the edge. Each magnitude goes through the threshold, and if the value is higher than the threshold, the pixel is replaced by white color. Otherwise it stays black. The results are written to a new array as a grayscale value. 

The K-Means implementation is the heaviest operation implemented in the study. It starts with extracting all pixels into an array of [r, g, b] triplets. For initializing the centroids, not all the pixels of the image are used, but only a subset of them, as was explained in the K-Means++ method in the Section 5.5. The logic for the centroids can be implemented in nested loops. 

After initialization, the main iteration loop is executed. Every iteration of the loop performs an assignment and an update. During the assignment phase, for every pixel, the distance to each centroid is calculated using the 3D Euclidean distance formula Equation 2, and the pixel value is assigned to the nearest centroid. During the update phase, the operation of selecting new centroids is repeated, and the assignment starts execution again. After all centroids have been calculated, and converged to their final version, all pixels go through the algorithm to be replaced with the nearest centroids. The implementation uses JavaScript methods such as reduce() for calculating means, which makes the code more manageable and shorter, but might not be the fastest option. However, this can be neglected because in a real-world project, standard expressions and shorter definitions are common, which makes the algorithm practical. 

$$
d = \sqrt {\left(R _ {1} - R _ {2}\right) ^ {2} + \left(G _ {1} - G _ {2}\right) ^ {2} + \left(B _ {1} - B _ {2}\right) ^ {2}} \tag {2}
$$

where 

d Euclidean distance [-] 

R, G, B color channel values [-] 

# 5.7 Implementation in Rust to WASM

The implementation of Rust to WebAssembly in the testing web framework originally had the goal of making algorithms equivalent to JavaScript, rather than implementing Rust-specific optimizations that would create different comparisons. In Rust to WebAssembly, implementation pipeline is significantly different from JavaScript’s implementation pipeline. The Rust source code compiles to WebAssembly through wasm-pack. Wasm-pack is a tool that is used for building and generating all the necessary files for JavaScript integration. After this building, the output directory has JavaScript glue code that can be integrated into a JavaScript project. Glue code handles calling WebAssembly functions and type conversions between WebAssembly and JavaScript, accessing a WebAssembly binary file. A binary file is significantly smaller than JavaScript modules, making it faster for the browser to download, and faster to parse because it is structured in a binary format. Although file parsing is rapid, the significant difference between JavaScript and Rust to Wasm implementations heavily affects execution. The difference is WebAssembly’s memory space. JavaScript has its own heap where it stores objects, and its garbage collector automatically frees memory when it is not needed. WebAssembly, on the other hand, has a separate linear memory that is a large 

array of bytes. If to be described simply, Rust manages that memory using its ownership system. Different memory systems create issues when WebAssembly is being integrated in JavaScript, because when JavaScript wants to pass an image to WebAssembly for processing, it can not pass a pointer as WebAssembly will not be able to access the section to which the pointer belongs. Instead, the pixel data has to be copied from JavaScript’s heap into WebAssembly’s linear memory. After result has been achieved in WebAssembly, it should be copied back to JavaScript’s memory. The difference mainly refers to significant because for fast computation operations, the overhead time might be larger than the actual operation, making WebAssembly irrelevant. 

The Rust version of the color inversion implementation directly translates the JavaScript loop structure with a for loop iterating through the pixel vector. The logic is identical as was described in Section 5.6, only the result in Rust should be wrapped back into an ImageData object, using the new u8 clamped array constructor. 

Edge detection in Rust has the same loop structure as JavaScript. At first, Gaussian blur is applied and implemented exactly the same way as in JavaScript. Only types were adjusted in order to match JavaScript implementation. The Sobel kernels are defined, and the main loops iterate through pixels and kernel positions the same way as in JavaScript’s implementation, and later on, exactly as in JavaScript’s implementation, each calculated magnitude goes through the threshold in order to become either white or black. The grayscale calculation could not be easily made to match JavaScript’s version, and an integer 32 conversion had to be made in order to match JavaScript’s Math.round() behavior. The same problem occurred with gradient magnitude calculation due to the need for JavaScript type matching. Small differences in round types or the types of variables that were used would have resulted in verification failures. Therefore, it was important to use the same variable types in the implementations. 

The K-Means quantization implementation in Rust required a most careful approach to match certain types in JavaScript implementation. Initial implementations using random centroid initialization produced different output with each execution, complicating the process of verifying that WebAssembly and JavaScript had identical results. The final implementation employs K-Means $^ { + + }$ initialization which selects centroids at evenly spaced intervals through the pixel array rather than at random. This approach guarantees an identical outputs while maintaining the algorithm’s effectiveness. Overall, the Rust implementation aims to 

completely mirror JavaScript’s implementation structure with pixel extraction into RGB triplets, iterative assignment and update phases. The primary challenge related to this the matching of JavaScript’s floating point arithmetic behavior with other algorithms. Precise Euclidean distance calculations had to be performed to ensure that rounding matched JavaScript’s implementation. During the development stage, the previous stage results were verified in order to identify the exact occurrence of type mismatch. 

# 6 EVALUATION

In order to make an adequate performance comparison of three image processing algorithms, appropriate test datasets were determined. In total, four distinct datasets were utilized. The first dataset consisted of 10 different images, where each image had different dimensions, ranging from small to large width and heights. This dataset enabled the assessment of general performance across varied images with different aspect ratios, simulating a real case scenario. The second dataset contained 10 different images with equal width and height dimensions, which enabled comparison without the impact of the variable of aspect ratio. The third dataset contained 10 equal images saved in different file formats to investigate whether image formats affect the performance. The fourth dataset contained 100 instances of the same image scaled to different sizes, ranging from small 0.01 megapixels to large 30 megapixels. This dataset helped to analyze how performance scales with image dimensions and whether certain ranges had better optimization characteristics. 

All experiments were conducted on a single hardware configuration: CPU - AMD Ryzen 7 5700U with Radeon Graphics, RAM - 10 GB, OS - Arch Linux x86_64, Browser - Google Chrome 134.0.6998.165 with V8 JavaScript engine. Each test ran multiple iterations to ensure sufficient amount of data for analysis. During the tests, median values were used concerning robustness against outliers. Performance consistency was measured using coefficient of variation, calculated as ( standard deviation / mean) $\star 1 0 0 \%$ , where lower values indicate more predictable performance. 

# 6.1 Color inversion performance analysis

The analysis of the first dataset with 10 random images of different sizes made on color inversion showed that WebAssembly consistently outperformed JavaScript regardless of 

image dimensions or image content. The speedup factor varied between 1.31 and 1.67 as shown in the Table 1, with most measurements settling at approximately 1.35. The consistency metric revealed that WebAssembly performed stably and predictably throughout the test iterations, showing a lower coefficient of variation than the majority of JavaScript runs. The cold start overhead metric revealed that WebAssembly’s initialization process had a significantly higher first-run initialization time, measuring up to 465.6ms compared to JavaScript’s 236.3ms, shown in Table 1. This difference in initialization cost is due to WebAssembly module instantiation combined with linear memory allocation and its initial data transfer from JavaScript’s heap into WebAssembly’s memory space. However, this significant time delay occured once, during initialization in the first run, indicating that if multipleoperation execution occurs, they will amortize the initialization expense, and the utilization of WebAssembly will still be valid. Additionally, some measurements in cold start metric showed negative values, which indicates that the first run was marginally faster than the median. This is completely normal if module instantiation and memory allocation have already been performed. Such an event frequently occurs if after the first run there is the system load or garbage collection, which slows down the following runs, making the median slower than the first run. 


Table 1. Color Inversion measurements on the first dataset (10 different images with different dimensions)


<table><tr><td>Run</td><td>JS Execution Time (ms)</td><td>WASM Execution Time (ms)</td><td>JS Cold Start Overhead (ms)</td><td>WASM Cold Start Overhead (ms)</td><td>JS Consistency (CV %)</td><td>WASM Consistency (CV %)</td><td>Speedup</td></tr><tr><td>1</td><td>0.6</td><td>0.4</td><td>236.3</td><td>465.6</td><td>499.18</td><td>524.53</td><td>1.5</td></tr><tr><td>2</td><td>4.4</td><td>3.3</td><td>2.6</td><td>0.8</td><td>58.75</td><td>29.67</td><td>1.33</td></tr><tr><td>3</td><td>1.7</td><td>1.3</td><td>0</td><td>-0.5</td><td>15.48</td><td>11.9</td><td>1.31</td></tr><tr><td>4</td><td>1</td><td>0.7</td><td>-0.1</td><td>0</td><td>41.93</td><td>23.01</td><td>1.43</td></tr><tr><td>5</td><td>2.5</td><td>1.8</td><td>0.1</td><td>-0.3</td><td>32.55</td><td>50.58</td><td>1.39</td></tr><tr><td>6</td><td>6.2</td><td>4.6</td><td>-0.9</td><td>0.5</td><td>23</td><td>21.75</td><td>1.35</td></tr><tr><td>7</td><td>6.8</td><td>5</td><td>-0.7</td><td>-0.1</td><td>23.6</td><td>20.88</td><td>1.36</td></tr><tr><td>8</td><td>7.5</td><td>5.5</td><td>1</td><td>0.2</td><td>25.29</td><td>8.68</td><td>1.36</td></tr><tr><td>9</td><td>18.8</td><td>14.3</td><td>0.8</td><td>6.4</td><td>7.78</td><td>15.51</td><td>1.31</td></tr><tr><td>10</td><td>0.5</td><td>0.3</td><td>-0.1</td><td>0</td><td>45</td><td>34.39</td><td>1.67</td></tr></table>

The second dataset, with 10 different images of identical dimensions, produced median execution times of 11.4 ms for JavaScript and 7.9 ms for WebAssembly, revealing that WebAssembly outperformed JavaScript by 1.44 speedup, shown in Table 2. When the 

dimension variability is eliminated, this controlled comparison confirms that the performance advantage is produced from execution efficiency rather than scale-dependent factors. The consistency metric showed that during almost all 10 runs, WebAssembly performed more stably and predictably by showing lower consistency values than JavaScript. The elimination of dimensions strongly suggests that WebAssembly is significantly more consistent in performance. 


Table 2. Color Inversion measurements on the second dataset (10 different images with identical dimensions)


<table><tr><td>Run</td><td>JS Execution Time (ms)</td><td>WASM Execution Time (ms)</td><td>JS Consistency (CV %)</td><td>WASM Consistency (CV %)</td><td>Speedup</td></tr><tr><td>1</td><td>11.3</td><td>7.9</td><td>22.7</td><td>32.19</td><td>1.43</td></tr><tr><td>2</td><td>11.4</td><td>7.9</td><td>15.74</td><td>12.86</td><td>1.44</td></tr><tr><td>3</td><td>11.4</td><td>7.9</td><td>20.34</td><td>14.84</td><td>1.44</td></tr><tr><td>4</td><td>11.5</td><td>7.9</td><td>13.08</td><td>12.8</td><td>1.46</td></tr><tr><td>5</td><td>11.4</td><td>7.9</td><td>21.71</td><td>9.08</td><td>1.44</td></tr><tr><td>6</td><td>11.4</td><td>7.9</td><td>19.9</td><td>16.22</td><td>1.44</td></tr><tr><td>7</td><td>11.4</td><td>7.9</td><td>22.02</td><td>10.79</td><td>1.44</td></tr><tr><td>8</td><td>11.3</td><td>7.9</td><td>19.82</td><td>12.27</td><td>1.43</td></tr><tr><td>9</td><td>11.5</td><td>7.9</td><td>20.66</td><td>16.56</td><td>1.46</td></tr><tr><td>10</td><td>11.4</td><td>7.2</td><td>17.06</td><td>16.76</td><td>1.58</td></tr></table>

The third dataset, with 100 images, acquired by downscaling one image to different sizes, showed that the execution stayed linear, having acceptable variance due to different reasons such as JIT optimizations, system load, garbage collection, and external factors coming from the execution environment, shown in Figure 1. 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-02/7c362c03-7d21-43f2-863b-71a9aa90e2ce/f73182a2ce0d9b62c896a445c5c509a72190407a1943be9c84d4704e6713b807.jpg)



Figure 1. Color Inversion image scaling impact graph view


The speedup factor remained relatively stable across the entire size range, averaging values between 1.4 to 1.5. This indicates that for color inversion in WebAssembly, data transfer into memory overhead scales proportionally with the computational workload. 

Additionally, another dataset was run on this algorithm with eight identical images saved in different image formats, such as JPEG, PNG, GIF, and multiple others. The hypothesis arose that, due to different methods of compression and storage structures, different file formats might affect the performance. The comparison showed minimal variation in performance, indicating that image formats do not significantly impact performance, and any insignificant variations could correspond to different factors of the environment. This finding confirms that performance does not depend on source format as browsers convert all formats to standardized pixel arrays. Hence, developers can utilize their preferred format without performance concerns, at least with these algorithms and within this application. 

# 6.2 Edge detection performance analysis

The first dataset utilized on the edge detection algorithm with 10 random images with different dimensions showed that JavaScript execution time ranged from 10.1ms for small images to 921.9ms for large images, being twice as slow as WebAssembly, scoring from 4.7ms on small images to 502.2ms on larger images, shown in Table 3. The advantage of WebAssembly during this practical dataset has been clear and stronger compared to the color inversion 

operation. The increase in performance can be attributed to increase arithmetical intensity, because each pixel in edge detection requires numerous operations, such as nine multiplying and accumulating operations per channel during Guassian blur, and 18 multiply accumulation operations per pixel in Sobel kernels, additionally, square root, complex multiplications and threshold comparison are required. WebAssembly’s static typing eliminates type checks on every arithmetic operation providing execute performance advantage, while JavaScript’s dynamic type system requires additional verifications making overhead significantly stronger. 


Table 3. Edge detection measurements on the first dataset (10 different images with different dimensions)


<table><tr><td>Run</td><td>JS Execution Time (ms)</td><td>WASM Execution Time (ms)</td><td>JS Cold Start Overhead (ms)</td><td>WASM Cold Start Overhead (ms)</td><td>JS Consistency (CV %)</td><td>WASM Consistency (CV %)</td><td>Speedup</td></tr><tr><td>1</td><td>17.7</td><td>8.1</td><td>168</td><td>349</td><td>150.21</td><td>304.32</td><td>2.19</td></tr><tr><td>2</td><td>156</td><td>89.7</td><td>83.9</td><td>1.1</td><td>18.5</td><td>1.38</td><td>1.74</td></tr><tr><td>3</td><td>60.8</td><td>33.5</td><td>5.9</td><td>-0.2</td><td>3.61</td><td>4.18</td><td>1.81</td></tr><tr><td>4</td><td>34.9</td><td>19.7</td><td>-1.1</td><td>-0.4</td><td>4.97</td><td>6.84</td><td>1.77</td></tr><tr><td>5</td><td>100</td><td>52.1</td><td>-0.8</td><td>-0.1</td><td>1.09</td><td>0.87</td><td>1.92</td></tr><tr><td>6</td><td>267.7</td><td>126.2</td><td>-1.3</td><td>1.4</td><td>0.65</td><td>0.59</td><td>2.12</td></tr><tr><td>7</td><td>231.9</td><td>138.8</td><td>0</td><td>1.8</td><td>0.16</td><td>0.76</td><td>1.67</td></tr><tr><td>8</td><td>315.5</td><td>155.7</td><td>1.3</td><td>-1.6</td><td>0.3</td><td>0.49</td><td>2.03</td></tr><tr><td>9</td><td>921.9</td><td>502.2</td><td>0</td><td>3.7</td><td>0.06</td><td>0.71</td><td>1.84</td></tr><tr><td>10</td><td>10.1</td><td>4.7</td><td>-0.5</td><td>-0.7</td><td>3.12</td><td>9.04</td><td>2.15</td></tr></table>

As for WebAssembly’s consistency in color inversion during the first dataset, no significant advantage was observed. WebAssembly did not show constant performance stability compared to JavaScript across most runs. This suggests that for this specific implementation, either JavaScript’s JIT optimizations matched WebAssembly’s execution to a certain degree, or that both implementations had been affected by external system performance variations equally while processing images, such as CPU thermal states, cache effects or background system noise. The lack of stability in the consistency metric shows that despite clear speed advantages, the execution time heavily depends not only on technology and implementation, but also on the external state of the execution environment. 

The second dataset with identical image dimensions, created to observe pure performance on the algorithm, showed that execution times produced by WebAssembly were 1.92 times faster than JavaScript’s execution times, shown in Table 4, confirming WebAssembly’s overall 

superiority for the edge detection algorithm. During this dataset, WebAssembly was not only faster in execution, but its standard deviation of 5.8ms was significantly smaller than 47.3ms of JavaScript, indicating that performance has been 8 times more stable than JavaScript’s performance. 


Table 4. Edge detection measurements on the second dataset (10 different images with identical dimensions)


<table><tr><td>Run</td><td>JS Execution Time (ms)</td><td>WASM Execution Time (ms)</td><td>JS Cold Start Overhead (ms)</td><td>WASM Cold Start Overhead (ms)</td><td>JS Consistency (CV %)</td><td>WASM Consistency (CV %)</td><td>Speedup</td></tr><tr><td>1</td><td>432.3</td><td>225.2</td><td>0</td><td>16.9</td><td>1.05</td><td>3.66</td><td>1.92</td></tr><tr><td>2</td><td>456.4</td><td>222.2</td><td>0</td><td>-0.3</td><td>0.34</td><td>0.23</td><td>2.05</td></tr><tr><td>3</td><td>466.2</td><td>224.2</td><td>0</td><td>0</td><td>1.06</td><td>0.74</td><td>2.08</td></tr><tr><td>4</td><td>523.5</td><td>223.1</td><td>0</td><td>0</td><td>0.28</td><td>1.16</td><td>2.35</td></tr><tr><td>5</td><td>365.9</td><td>223.3</td><td>1.8</td><td>0</td><td>0.39</td><td>0.86</td><td>1.64</td></tr><tr><td>6</td><td>387.4</td><td>224.3</td><td>0</td><td>-2</td><td>1.16</td><td>0.46</td><td>1.73</td></tr><tr><td>7</td><td>394.7</td><td>223</td><td>0</td><td>0</td><td>1.83</td><td>0.18</td><td>1.77</td></tr><tr><td>8</td><td>496.9</td><td>224.9</td><td>0</td><td>1</td><td>4.42</td><td>0.72</td><td>2.21</td></tr><tr><td>9</td><td>362.9</td><td>226.9</td><td>-4</td><td>0</td><td>0.54</td><td>0.25</td><td>1.6</td></tr><tr><td>10</td><td>418.6</td><td>226.8</td><td>-1.1</td><td>0</td><td>0.86</td><td>1.18</td><td>1.85</td></tr></table>

The third dataset was utilized to examine the performance scales, and they revealed an interesting non-linear pattern in WebAssembly’s performance advantage. Rather than maintaining a constant linear speedup variable across all image sizes, the data showed a curve. With the minimal images, the speedup factor was 1.7 at 0.1 megapixel images, shown in Figure 2. As image size grew slightly, speedup factor started to improve, growing nearly to 2.0 at relatively small images with 0.8 megapixels, representing the peak performance difference. The largest speedup factor appearing at small to medium images started to gradually decrease when image sizes grew larger, plateauing at approximately 1.45 advantage by WebAssembly for very large images, of 31 megapixels, visible in Figure 2. The performance can be described by three factors: memory transfer overhead, computational complexity of the algorithm and cache efficiency. For example, for very small images, WebAssembly’s linear memory image data transfer and lack of computational complexity of the algorithm represent a large portion of total execution time, slightly reducing WebAssembly’s performance advantage. As images grow to 0.8 megapixels, where WebAssembly has its best performance advantage, the impact of data transfer becomes negligible, and computational workload dominates execution time. At the large images, a 

different constraint arises, due to CPU cache limit, when working image becomes larger it might exceed cache capacity, forcing more frequent main memory access. WebAssembly might experience greater cache efficiency degradation due to its linear memory. Additionally, the overhead of transferring image data back and forth into WebAssembly’s memory becomes more significant and has larger impact on the execution times. 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-02/7c362c03-7d21-43f2-863b-71a9aa90e2ce/c7b0f8ab8064fbeb5a611e1d1b985c21f278ecdfa8b7c8b84151a575804efebc.jpg)



Figure 2. Edge detection image scaling impact graph view


# 6.3 K-Means Color Quantization Performance Analysis

K-Means color quantization is the most computationally intensive algorithm that was evaluated, and its complexity depends on the K variable, which is responsible for the number of colors outputted in the resulting image. Because this variable affects the performance, additional analysis were be made, examining how the performance scales with different K variable values. It was important to note that during all tests’ execution in this algorithm, the color output value remained constant at 24 colors in order to ensure fair comparison and eliminate variability. 

When the dataset with 10 random images of different sizes was utilized on the algorithm, WebAssembly outperformed JavaScript by a substantial factor, with a seedup variable ranging from 1.81 to 3.69 being the highest value over all three algorithms, visible in Table 5. This suggests a significantly higher computational complexity of the algorithm, as well as WebAssembly’s advantages related to heavy computational demand. With the algorithm’s complexity, the size of WebAssembly’s binary representations and modules grew, making its 

cold start coefficient the worst compared to other algorithms. Even though WebAssembly significantly underperformed with cold start, it managed to maintain a considerable lead in performance consistency, having a coefficient of approximately 3 times smaller than that of JavaScript’s. 


Table 5. K-Means color quantization measurements on the first dataset (10 different images with different dimensions)


<table><tr><td>Run</td><td>JS Execution Time (ms)</td><td>WASM Execution Time (ms)</td><td>JS Cold Start Overhead (ms)</td><td>WASM Cold Start Overhead (ms)</td><td>JS Consistency (CV %)</td><td>WASM Consistency (CV %)</td><td>Speedup</td></tr><tr><td>1</td><td>31.5</td><td>14.3</td><td>189</td><td>426.4</td><td>94.92</td><td>265.76</td><td>2.2</td></tr><tr><td>2</td><td>396.4</td><td>133.1</td><td>0</td><td>5.1</td><td>10.25</td><td>1.78</td><td>2.98</td></tr><tr><td>3</td><td>146</td><td>54.9</td><td>48.1</td><td>-0.2</td><td>28.7</td><td>1.88</td><td>2.66</td></tr><tr><td>4</td><td>57.1</td><td>26.7</td><td>-1.5</td><td>0.5</td><td>4.54</td><td>2.29</td><td>2.14</td></tr><tr><td>5</td><td>188.8</td><td>67.4</td><td>7.3</td><td>0</td><td>11.48</td><td>0.73</td><td>2.8</td></tr><tr><td>6</td><td>507.7</td><td>175.7</td><td>0</td><td>3.2</td><td>4.52</td><td>0.9</td><td>2.89</td></tr><tr><td>7</td><td>654.6</td><td>177.6</td><td>36.8</td><td>1.1</td><td>3.43</td><td>0.36</td><td>3.69</td></tr><tr><td>8</td><td>749.9</td><td>227.4</td><td>33.4</td><td>0.2</td><td>2.51</td><td>0.17</td><td>3.3</td></tr><tr><td>9</td><td>2498.1</td><td>718.5</td><td>0</td><td>14.6</td><td>2.13</td><td>1.03</td><td>3.48</td></tr><tr><td>10</td><td>17.4</td><td>9.6</td><td>22.4</td><td>-0.1</td><td>42.12</td><td>10.08</td><td>1.81</td></tr></table>

In order to completely evaluate the performance of the technologies over the K-means algorithm, the same dataset with 10 different images of the same size was utilized as in the other test cases. Results showed a stable advantage in favor of WebAssembly with 3.76 times higher execution time, shown in Table 6. In addition to this impressive result, WebAssembly’s performance stability had been also remarkable averaging at 0.2 excluding cold start, while JavaScript averaged 2.4, making WebAssembly 12 times more stable than JavaScript, displayed in Table 6. This extreme consistency difference can be explained by the K-Mean’s algorithm structure as it executes multiple convergence iterations, and each iteration allocates temporary data structures. In contrast, JavaScript’s garbage collector is triggered periodically during these allocations, introducing spontaneous delays. 


Table 6. K-Means color quantization measurements on the second dataset (10 different images with identical dimensions)


<table><tr><td>Run</td><td>JS Execution Time (ms)</td><td>WASM Execution Time (ms)</td><td>JS Cold Start Overhead (ms)</td><td>WASM Cold Start Overhead (ms)</td><td>JS Consistency (CV %)</td><td>WASM Consistency (CV %)</td><td>Speedup</td></tr><tr><td>1</td><td>828.2</td><td>306.4</td><td>0</td><td>179.3</td><td>5.72</td><td>23.85</td><td>2.7</td></tr><tr><td>2</td><td>1119.7</td><td>299.4</td><td>19.4</td><td>-0.3</td><td>3.4</td><td>0.11</td><td>3.74</td></tr><tr><td>3</td><td>1098.7</td><td>308.4</td><td>-8.4</td><td>-3.8</td><td>4.25</td><td>0.61</td><td>3.56</td></tr><tr><td>4</td><td>1061.6</td><td>289.7</td><td>0</td><td>0.7</td><td>9.81</td><td>0.14</td><td>3.66</td></tr><tr><td>5</td><td>1127.1</td><td>299.6</td><td>-0.1</td><td>0</td><td>0.16</td><td>0.11</td><td>3.76</td></tr><tr><td>6</td><td>1154.2</td><td>318</td><td>47.4</td><td>-0.5</td><td>2.93</td><td>0.15</td><td>3.63</td></tr><tr><td>7</td><td>1148.4</td><td>305.6</td><td>0</td><td>-0.6</td><td>2.07</td><td>0.16</td><td>3.76</td></tr><tr><td>8</td><td>1060.2</td><td>282.6</td><td>5.7</td><td>0</td><td>0.78</td><td>0.49</td><td>3.75</td></tr><tr><td>9</td><td>1115.9</td><td>316.6</td><td>17.4</td><td>0</td><td>1.05</td><td>0.2</td><td>3.52</td></tr><tr><td>10</td><td>1104.9</td><td>308.2</td><td>4.2</td><td>0</td><td>2.09</td><td>0.15</td><td>3.59</td></tr></table>

The dataset to detect image size impact on performance revealed an interesting pattern, as well as the edge detection algorithm performance, and the result is surprisingly different from the other algorithms. As image size increased, the speedup factor grew substantially. For example, when the algorithm operated small images, the speedup factor was only 1.4, but already at 0.81 megapixel images, the speedup factor reached 3.29. Based on the graph view, the performance has achieved at this point its acceleration peak, and the growth from this point continued at a smaller rate. At 3 megapixels, the speedup measured 3.61 and peaked with a 7.7 megapixel image at 3.95, observed in Figure 3. Beyond this peak, the speedup factor stabilized at 3.9 for larger images, showing no significant decline in contrast to edge detection. This behavior might be explained by the fact that with images smaller than 0.8 megapixels, the initialization overhead and memory transfer cost a large portion of total execution time, as it was in the edge detection algorithm. When image sizes increase to the medium range past 0.8 megapixels, the iterative calculations start to dominate execution time. For example for each iteration for every pixel Euclidean distance must be calculated in RGB space to every centroid. These calculations involve intensive floating-point arithmetics and heavy array or vector indexing, allowing WebAssembly efficiency to spark. Additionally, due to large quantity of operations, JavaScript’s performance start to degrade because of significant number of type checks and array type validations. Each array access might trigger JIT optimizations or deoptimizations, and excessive manipulations on data types triggers large usage of garbage collection, contributing to worse JavaScript’s performance. 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-02/7c362c03-7d21-43f2-863b-71a9aa90e2ce/c3fb8d5d15c90db7418e06f21fc1bc50415052de03319f7ab4540210e16bc965.jpg)



Figure 3. K-Means color quantization image scaling impact graph view


As was mentioned before, this algorithm experienced an additional set of tests in order to examine how its JavaScript and WebAssembly performance varied with different output color counts due to algorithm computational correlation to the color variable. A specific image was selected for processing. During 10 runs, each run’s target output quantity of colors steadily declined from 256 colors down to the minimum of 2 colors. Because of the algorithm's computational dependency on the variable of the number of colors, it was expected that there would be a linear dependence and no significant differences in speedup factor. However, the evaluation revealed that the speedup factor of WebAssembly rapidly grew from 1.95 value at 256 colors to 7.84 value at 2 colors, shown seen in Table 7, which was not expected. This increase occurs because with just 2 colors, the algorithm needs more iterations to converge, producing more array manipulations and float divisions, necessitating more type and array checks, which heavily affects JavaScript performance. 


Table 7. K-Means color quantization measurements on the forth dataset (1 image, different amount of output colors, variable K)


<table><tr><td>Run</td><td>K (colors)</td><td>JS Execution Time (ms)</td><td>WASM Execution Time (ms)</td><td>JS Cold Start Overhead (ms)</td><td>WASM Cold Start Overhead (ms)</td><td>JS Consistency (CV %)</td><td>WASM Consistency (CV %)</td><td>Speedup</td></tr><tr><td>1</td><td>256</td><td>1127.3</td><td>576.9</td><td>1.6</td><td>-1.2</td><td>3.83</td><td>1.5</td><td>1.95</td></tr><tr><td>2</td><td>210</td><td>878.9</td><td>468.9</td><td>0</td><td>-0.4</td><td>2.86</td><td>0.11</td><td>1.87</td></tr><tr><td>3</td><td>180</td><td>737.3</td><td>364.4</td><td>9</td><td>-2.3</td><td>2.33</td><td>0.36</td><td>2.02</td></tr><tr><td>4</td><td>120</td><td>573.9</td><td>262.9</td><td>-7.4</td><td>-0.1</td><td>2.63</td><td>0.05</td><td>2.18</td></tr><tr><td>5</td><td>100</td><td>457.6</td><td>177.8</td><td>0</td><td>-0.1</td><td>5.17</td><td>1.04</td><td>2.57</td></tr><tr><td>6</td><td>80</td><td>288.5</td><td>96.8</td><td>0</td><td>0.3</td><td>6.2</td><td>0.18</td><td>2.98</td></tr><tr><td>7</td><td>20</td><td>237.5</td><td>57.8</td><td>0</td><td>-0.1</td><td>15.04</td><td>0.14</td><td>4.11</td></tr><tr><td>8</td><td>10</td><td>163.6</td><td>38.6</td><td>8</td><td>0.1</td><td>4.04</td><td>0.12</td><td>4.24</td></tr><tr><td>9</td><td>4</td><td>237.2</td><td>31</td><td>28.1</td><td>-0.1</td><td>23.46</td><td>0.55</td><td>7.65</td></tr><tr><td>10</td><td>2</td><td>166.3</td><td>21.2</td><td>-9.6</td><td>-0.1</td><td>16.46</td><td>0.22</td><td>7.84</td></tr></table>

# 7 DISCUSSION

# 7.1 interpretation of results

The experimental comparison and evaluation of three image processing algorithms across multiple datasets illustrates the performance advantages of WebAssembly in certain conditions over JavaScript. WebAssembly demonstrated correlation between performance and the computational complexity of the algorithm by outperforming JavaScript with the speedup factors ranging from 1.3 for image detection to 4 for color quantization operation. 

Addressing the first research question related to common CPU-intensive workloads in realworld web applications, three algorithms were selected, and the results gathered during the analysis validated the selection. All three algorithms provided valuable insights into their performance and illustrated their computational complexity. 

Addressing the second research question of the study, the performance characteristics of JavaScript and WebAssembly had been determined after and during testings of three algorithms. WebAssembly consistently demonstrated superior raw execution speed, with great adaptation to algorithmic complexity. For example, for color inversion, the simplest perpixel operation, WebAssembly outscored JavaScript by 1.4 speedup factor. During edge detection the speedup factor rose to 1.8, and during the last and the most computational demanding algorithm WebAssembly outscored JavaScript by the speedup of 3.95. The performance consistency metric reveals an important characteristic of predictability, where WebAssembly demonstrates coefficient of variation typically lower than 2, while JavaScript fails to behave predictably and shows variation as high as from 3 to over 20. The difference is significant and it occurs due to JavaScript’s runtime optimizations or other additional 

operations such as garbage collection. The pauses differ significantly, making the technology less stable, whereas WebAssembly’s main factor of influence is its linear memory. 

The evaluation revealed a significant amount of trade-offs that developers must consider when choosing between JavaScript and WebAssembly for computational workloads, addressing research question 3 about trade-offs. The development cycle of JavaScript is significantly faster and simpler than WebAssembly’s. An implementation of JavaScript only required a text editor, browser and terminal for execution, and the cycle of JavaScript provided constant feedback either by console or in the browser, which facilitates code debugging. Browser developer tools and various extensions allow for smart debugging support, including potential breakpoints, variable inspections and performance measurements. Generally, all error messages received during the implementation of JavaScript have been clear and traceable. WebAssembly via Rust development introduced a large level of complexity, for example, developers must configure special third party tool such as wasm-pack for building for example, and manage the interfaces between Rust and JavaScript through wasm-bindgen. Debugging the Rust code or WebAssembly was tremendously difficult, even though there was understanding of how each algorithm should be implemented. Additionally, debugging becomes very difficult from the browser side, because browser developer tools can not directly influence or inspect WebAssembly execution, making it almost impossible to track possible errors. Due to the knowledge of how algorithms should be implemented, the largest issue occurred during implementing and introducing types to Rust. Because Rust and JavaScript have different types for similar operations, it was difficult to understand where algorithms differ, especially for operations involving rounding behavior or floating-point precision. However, these development costs are only one-time expenses, and as soon as the algorithms were matched, WebAssembly proved to be a reasonable option. 

The cold start overhead metric showed that WebAssembly has high first run overhead due to its initialization costs, such as fetching the binary file, instantiating the module, allocation linear memory, and with images copying image data into WebAssembly memory space. For applications that perform a single image processing operation, for example high compression, applying AI algorithm or any other single operation, the cold start might outweigh the savings in execution time, particularly for small images or simple operations. Therefore, the usage of WebAssembly in these cases would not be recommended, or at least additional prefetching or partial parallel initialization of WebAssembly would be required in order to gain performance advantage during the first run. However, the analysis shows that after the first 

run, WebAssembly performs more stably and predictably than JavaScript. With superior results in performance, the usage of WebAssembly for repetitive operations is recommended. 

Scalability characteristics play an important role on the web and during the evaluation WebAssembly and JavaScript showed valuable insights into performance. During the first operation, the linear scaling took place, which confirms that for operations with low computational demand per pixel, the performance remains constant regardless of scale. Although WebAssembly remains superior in performance, JavaScript is competitive. Also, the difficulties during development stage of WebAssembly discourage implementation of simple algorithms if scaling is the main concern. Edge detection exhibited different behavior. WebAssembly advantage peaked at medium image sizes before declining gradually at large sizes. The pattern suggests that memory bandwidth or cache efficiency starts to constrain the performance at larger images. The decline from 2.0 speedup at 0.8 megapixels image to 1.5 at 31 megapixels images indicates that during large image sizes the algorithm’s computational demands start to vanish in front of demand for memory spaces and the speedup coefficient becomes similar to what the color inversion has shown. Evaluation on K-Means quantization, however, demonstrated an opposite pattern. During the initial stage of the algorithm, the performance have been similar of in edge detection algorithm in Section 6.2, and WebAssembly appeared to reach its peak at 0.8 megapixel image, although the speedup factor did not start to decline but rather slowly plateau increased. This suggests that even with larger images, the computational complexity stays the main cost factor, allowing WebAssembly to maintain its advantage. For the developers, if the scaling factor at the stake it would be wise to consider the computational complexity of the algorithm, if the computational complexity is not that high, WebAssembly will perform better, but the advantage might not worth the cycle of the implementation, although simpler algorithms require less effort in implementation. However, if scalability is the main factor during the implementation of highly demanding algorithm, then WebAssembly is definitely a favorite choice, because there will be significant outperformance of WebAssembly if computation stays the main demand rather than memory. 

# 7.2 Synthesis of Findings

The data from evaluation suggests existence of a computational intensity threshold below which JavaScript remains competitive, in the values of the threshold WebAssembly has its biggest overall advantages and above where WebAssembly becomes increasingly 

advantageous or the performance degrades depending on the algorithm computational complexity. For example, during Edge detection WebAssembly archives its peak advantage with the speedup factor of almost 2 when 0.8 megapixels images are being tested, and after the speedup factor degrades, due to algorithms computational simplicity. In K-Means quantization, speedup factor as well accelerated and finished its significant acceleration at the point of 0.8 megapixels, starting plateauing or slowly increasing after, signalling that WebAssembly has the most advantageous at some point of different size images. At the case of testing it performed best testing on 0.8 megapixels, although on different architecture or with different current CPU load the point of the performance can be different. It is recommended for the developers to realize common CPU load of the users during execution of the operation and optimize algorithm complexity to this point, if the goal is to achieve the biggest advantage of WebAssembly over JavaScript usage. 

Real time applications, such as video filters, interactive image manipulation, or browser based games require predictable execution for smoother user experience. A common filter that executes in 15ms but occasionally spikes to 50ms due to garbage collection will cause visible stuttering. Therefore, it is recommended to use WebAssembly during the execution of similar objects. 

# 7.3 Practical Implications for Developers

The evaluations and results provide clear guidance for technology selection and the way of utilization. JavaScript remains the appropriate choice for simple, single execution operations on small images, where development simplicity is important or development time is restricted. The cold start overhead of 200-400 ms makes WebAssembly unsuitable for one-time operations unless the execution time exceeds several seconds, or the module with WebAssembly has been preinitialized. Although, in this scenario WebAssembly doesn't look that appealing due to its development complexity, WebAssembly becomes compelling in these three scenarios: repeated operations, medium to large images operations, and highly complex algorithms where large computational complexity allows for 3 to 4 speedup and 20 times higher stability by WebAssembly. For the most smooth experience for the user, for applications processing user-uploaded images of unknown sizes, a hybrid approach would be optimal, - utilizing JavaScript for quick processing of small images, while asynchronously load and initialize WebAssembly modules for larger and further images. This strategy would avoid 

cold start overhead, while slowly become optimized by utilizing the general advantage of WebAssembly over JavaScript. 

# 7.4 Limitations of the study

All experiments were conducted exclusively in Google Chrome 134.0.6998.165 on Linux, using the V8 JavaScript engine and chrome’s WebAssembly runtime implementation. Different browsers implement different JavaScript engines with varying optimizations, therefore the performance might differ, and the findings might not transfer directly to other browsers. Cross browser study would better validate and strengthen confidence in the reliability of findings. 

All tests executed on a single hardware configuration: An Arch Linux desktop with CPU - AMD Ryzen 7 5700U with Radeon Graphics, RAM - 10 GB. 

The study examined the performance only on three image processing algorithms, other algorithms or other categories of CPU intensive web workloads might have different performance. 

The study compiled Rust to WebAssembly, although other sources languages such as C or ${ \mathsf { C } } { + } { + }$ are supported for compilation to WebAssembly. Different source languages might produce WebAssembly modules with different performance characteristics. The study specifically characterizes Rust to WebAssembly performance, not general WebAssembly’s theoretical capabilities. 

The study didn’t utilize specific characteristic of WebAssembly specifically meant to score the highest during the performance, for example SIMD, parallelism or other things, this was used in order to match exactly JavaScript implementation execution under the hood, in order to see general performance difference. 

# 8 CONCLUSIONS

This study compared JavaScript and WebAssembly performance for medium, small, large computational image workloads. The first research question asked which CPU-intensive workloads are common in real-world web applications. Image processing operations 

represent a large portion of these workloads, being used in photo editors, computer vision, and largely in social media. The second research question examined the performance characteristics of both technologies. After tests and analysis, it became clear that WebAssembly consistently outperformed JavaScript across all tested scenarios, with different speedup factors: 1.4 for simple color inversion, 1.9 for edge detection, and 3.5 for K-Means quantization. WebAssembly demonstrated consistent advantage over JavaScript in execution and consistency, but JavaScript has smaller cold start overhead, which can be a significant limitation for single operation use cases with WebAssembly. The third research question examined trade-offs between the technologies. The most significant trade off is development complexity versus runtime performance. WebAssembly requires various tooling, significantly more complex debugging. For the algorithms in this study, WebAssembly development took approximately 2 to 3 times longer than JavaScript implementation. The development cost should be weighed against the 1.4 execution speed advantage, superior consistency and stable performance versus dynamic flexibility. 

A key finding of the study is the identification of nonlinearity in scaling patterns. For simple algorithm, WebAssembly maintained its advantage regardless of scale, but the difference in the performance was not significant. For algorithms with higher computational demands, the linearity was broken, and there were spikes or increase in the performance advantages. For example, for edge detection, WebAssembly had its most advantage over JavaScript in 0.8 megapixels images. In color quantization algorithm, the advantage accelerated, stopped in 0.8 megapixels images and started to plateau. Even if the study found non-linear correlations between performance and image scaling, the practical impact of the application extends beyond provided test results. Since it allows developers to test and gather results about their images, helping them to see whether WebAssembly is a useful tool for their project. 

The web application and the study offer developers the flexibility to choose between JavaScript’s rapid development cycle and WebAssembly’s superior performance characteristics by introducing decision framework. There are defined factors in the study and in the web application that could help users to understand the need to make choice towards certain technology. The factors are: algorithmic complexity, data scalability, performance consistency, execution speedup factor and other optional, but useful factors. Additionally, as WebAssembly tooling becomes mature, the development cost disadvantage will likely decrease, further expanding its practical potential in the applicability in modern web development. 

The complete application is publicly available at https://andebugulin.github.io/js-wasm-vis, allowing everybody to interact with the benchmarks. 

# 9 FUTURE PERSPECTIVES

The study identifies several directions for future investigation that would potentially address current limitations and extend findings to a broader context. One of these interesting potentials is advanced WebAssembly features set. Because the implementations test deliberately avoided WebAssembly’s advanced features, to measure pure WebAssembly performance versus JavaScript performance. There are numerous features potentially making WebAssembly even faster in its execution, such as: SIMD (single Instruction, Multiple Data) instructions that enable processing multiple values simultaneously, Threading support through Web Workers could enable multicore utilization larger, and streaming compilation that could potentially compile WebAssembly modules during their download. Large amount of modern browsers support WebAssembly’s SIMD, running multiple values simultaneously would enable even larger speedups for WebAssembly. Threading would utilize multiple core utilization at the same time, making possible to processes different not dependent on each other regions at the same time, and streaming compilation would allow reducing the cold start penalty of WebAssembly, that limits single-operation cases due to long initialization. 

All experiments were run in Chrome’s V8 engine on Linux desktop hardware, utilizing application on different browsers and different hardware would strengthen confidence in the results. Additionally, the tests on mobile devices could be implemented where mobile thermal throttling, battery constraints and limited memory are introduced. 

WebAssembly’s debugging complexity arises from the loss of source-level code in the browser developer tools. Whenever feedback is received, it is difficult to quickly see where the error occurred in the code. An interesting approach of hybrid compilation might be possible, where a majority of tests is made with asm.js as compilation target. Because asm.js remains JavaScript, it could be fully debuggable while still providing performance patterns. It should be studied whether development and debugging in asm.js, and compilation to WebAssembly for production would reduce development time. Additionally, modern tooling might automate this dual-compilation workflow while maintaining performance benefits. 

# REFERENCES



Haas, A. et al. 2017. Bringing the web up to speed with WebAssembly. Conference on Programming Language Design and Implementation, pp. 185–200. Available at: https://doi.org/10.1145/3062341.3062363 [Accessed 25 November 2025]. 





He, N. et al. 2025. The Promise and Pitfalls of WebAssembly: Perspectives from the Industry. International Conference on the Foundations of Software Engineering, pp. 480–490. Available at: https://doi.org/10.1145/3696630.3728570 [Accessed 14 November 2025]. 





Jiang, C. and Jin, X. 2017. Quick Way to Port Existing $\complement / \complement { + + }$ Chemoinformatics Toolkits to the Web Using Emscripten. Journal of Chemical Information and Modeling, 57(10), pp. 2407– 2412. Available at: https://doi.org/10.1021/acs.jcim.7b00434 [Accessed 27 October 2025]. 





Kedlaya, M.N. et al. 2014. Deoptimization for dynamic language JITs on typed, stack-based virtual machines. International Conference on Virtual Execution Environments, pp. 103–114. Available at: https://doi.org/10.1145/2576195.2576209 [Accessed 10 November 2025]. 





Kim, W.J. and Khomtchouk, B.B. 2021. WebAssembly enables low latency interoperable augmented and virtual reality software. Available at: https://doi.org/10.48550/ARXIV.2110.07128 [Accessed 13 November 2025]. 





Krylov, G. et al. 2020. The Evolution of Garbage Collection in V8: Google’s JavaScript Engine. 9th Mediterranean Conference on Embedded Computing (MECO), pp. 1–6. Available at: https://doi.org/10.1109/MECO49872.2020.9134326 [Accessed 16 November 2025]. 





Li, S., Cheng, B. and Li, X.-F. 2011. TypeCastor: demystify dynamic typing of JavaScript applications. International Conference on High-Performance and Embedded Architectures and Compilers, pp. 55–65. Available at: https://doi.org/10.1145/1944862.1944873 [Accessed 18 November 2025]. 





Rajani, V. et al. 2015. Information Flow Control for Event Handling and the DOM in Web Browsers. Computer Security Foundations Symposium (CSF), pp. 366–379. Available at: https://doi.org/10.1109/CSF.2015.32 [Accessed 27 November 2025] 





Svensson, G. 2001. Just‐in‐time: the reincarnation of past theory and practice. Management Decision, pp. 866–879. Available at: https://doi.org/10.1108/EUM0000000006526 [Accessed 2 October 2025]. 





Ţălu, M. 2025. A Comparative Study of WebAssembly Runtimes: Performance Metrics, Integration Challenges, Application Domains, and Security Features. Archives of Advanced Engineering Science, pp. 1–13. Available at: https://doi.org/10.47852/bonviewAAES52024965 [Accessed 13 November 2025]. 





Tufegdžić, J. et al. 2024. Application of WebAssembly Technology in High-Performance Web Applications. International Conference on Electrical, Electronic and Computing Engineering, pp. 1–6. Available at: https://doi.org/10.1109/IcETRAN62308.2024.10645198 [Accessed 25 November 2025] 





Wagner, L. 2015. asm.js author’s blog. Available at: https://blog.mozilla.org/luke/ (Accessed: October 14, 2025). 





Wang, E. et al. 2022. Juicing V8: A primary account for the memory forensics of the V8 JavaScript engine. Forensic Science International: Digital Investigation, 42, p. 301400. Available at: https://doi.org/10.1016/j.fsidi.2022.301400 [Accessed 4 October 2025]. 





Yan, Y. et al. 2021. Understanding the performance of webassembly applications. Internet Measurement Conference, pp. 533–549. Available at: https://doi.org/10.1145/3487552.3487827 [Accessed 6 October 2025]. 





Zakai, A. 2018. Fast Physics on the Web Using ${ \mathsf { C } } { + } { + }$ , JavaScript, and Emscripten. Computing in Science & Engineering, 20(1), pp. 11–19. Available at: https://doi.org/10.1109/MCSE.2018.110150345 [Accessed 19 October 2025]. 

