# A Systematic Review of WebAssembly VS Javascript Performance Comparison

Joshua Wenata Sunarto 

Computer Science Department, 

School of Computer Science 

Bina Nusantara University 

Jakarta, Indonesia 11480 

joshua.sunarto@binus.ac.id 

Quesynovich Denis Al Hafizh 

Computer Science Department, 

School of Computer Science 

Bina Nusantara University 

Jakarta, Indonesia 11480 

quesynovich.hafizh@binus.ac.id 

Angelina Quincy 

Computer Science Department, 

School of Computer Science 

Bina Nusantara University 

Jakarta, Indonesia 11480 

angelina.quincy@binus.ac.id 

Melanie Gabriela Tjandrasubrata 

Computer Science Department, 

School of Computer Science 

Bina Nusantara University 

Jakarta, Indonesia 11480 

melanie.tjandrasubrata@binus.ac.id 

Fakhira Shafa Maheswari 

Computer Science Department, 

School of Computer Science 

Bina Nusantara University 

Jakarta, Indonesia 11480 

fakhira.maheswari@binus.ac.id 

Mochammad Haldi Widianto 

Computer Science Department, 

School of Computer Science 

Bina Nusantara University 

Jakarta, Indonesia 11480 

mochamad.widianto@binus.ac.id 

Abstract—Web Assembly is one of brand-new programming languages on the web, it is equipped with complex binary format features so that it is more sophisticated and fast to load. In this paper, we collect material to compare quality performance of WASM and JS in various aspects (Runtime, Energy, Memory Usage). The performance hypothesis between WASM VS JS is depends on the type of web application you want to build. If the application requires very high performance and requires processing large data, then WASM may be a better choice. However, if the app is more focused on user interaction and view manipulation then JS may be a better fit. But after the authors do some systematic review of WASM and JS performance comparison, the authors conclude that WASM win in light application because it’s faster and use less energy, but for heavy application, the authors conclude that JS is more convenient because it’s significantly less memory needed than WASM, also it’s unexpectedly more faster than WASM. 

Keywords—energy, JS, memory, performance comparison, runtime, systematic literature review, WASM 

# I. INTRODUCTION

At first, the web was just a network for exchanging simple documents, but now the web has grown to become the most extensive application platform available on various type of operating systems and device types [1], [2]. Traditionally, the primary programming language for web development is JS because of its ability to run natively in the browser. Java Script used for techstack on many websites developing. Some big technology brand like Google, Yahoo, and Facebook also used JS. The reason is JS have ability to make developer works easier by create web applications become dynamic, interesting, and responsive. Because JS used in many software developments now and in the future web 2.0 era, the JS quality and performance as biggest techstack is now become a big concern for all service provider especially browser, including big brands like Mozilla Firefox and Google Chrome [3]. In search of a way retaining faster techstack, WASM is fresh technology for low-level code format that gives the web nearnative performance that can acts as a compiler for typed languages like C and $\mathrm { C } { + } { + }$ [4]. The resulting WASM code, often known as Wasm code, is subsequently run on a virtual machine with a stack-based architecture. The vision of 

WASM is to facilitate some programming language as a universal compiler target so that programming language can be execute in a browser [5]. Although WASM offers many profitable opportunities in improving web application performance, few people are aware of this technology and how they use it in web development. Therefore, in this paper we will explain about the comparison of JS and WASM performance on website development. Especially comparisons on speed, memory usage, and energy usage. With this paper, it is expected to help developers understand new technologies in web development and determine or use which technologies are better in their website development. The resulting WASM code, often known as Wasm code, is subsequently run on a virtual machine with a stack-based architecture. Owing to its low-level nature, the code may operate at almost native speed while still being memory-safe, sandboxed, and subject to security measures like the sameorigin policy in the browser [6]. 

# II. METHODOLOGY

Many inspire scientific articles about WASM and JS performance comparison keep releasing and have been dropped on the internet by the end of this year in line with the development of WASM technology. This paper authors necessary to do a specific analysis from variegated viewpoint to see several models that fit for systematic literature review. We are doing an experiment here by comparing 3 methods, namely through runtime speed, through memory and through energy where the 3 methods are very important in testing a technology for web or application development. Our paper is aimed at comparing how website can perform with WASM or JS technology. 

The authors use PRISMA methodology as analytic framework to structuring the paper. PRISMA method is methodology for systematic review paper. 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-02/010a06ca-437d-476e-8087-421d5ee4248b/5c7609a2b51e3ff466b49e295b6b30eef53c5d28793e9ab032a557abc73c7912.jpg)



Fig. 1. Flowchart of PRISMA Methodology


The potential challenges of this methodology are hard to find good quality paper that discusses comparison of WASM and JS. 

# A. Research Strategy

Runtime speed on the browser is very important because it can affect the user experience in using the internet. The faster the browser runtime, the faster web pages can load, and the user can quickly navigate to other pages. We also calculate some of the energy used when using the two technologies in order to save a computer's power when accessing several websites at once. JS is very energy consuming compared to WASM. Memory is also affected by the problem of runtime speed. The more memory used, the slower the runtime speed of a website. This is due to the accumulation of data. In our paper, WASM uses a lot of memory compared to JS [7]. 

# B. Selection Criteria

We searched for several papers with keywords comparing runtime speed, memory and energy. We filter some of these papers whether the paper matches the paper we made or not. In that keyword, we are looking for information through documents, not from websites or the like [7]. 

# C. Quality Assessment

All the reference paper obtained resulted in 1339 documents. Next, we filter by looking at a few things. This process is continued with the screening stage. Found some suitable documents. Then we continue with eligibility and continue with included. After carrying out these steps, we immediately looked for information according to the paper we made. The results of these keywords will be explained in the next chapter [7]. 

# III. RESULT

The process for selecting the papers used as references in this systematic literature review paper is by the following methods: 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-02/010a06ca-437d-476e-8087-421d5ee4248b/433e075546ac6178d52ec8aa942795a98a3cc33d959fceb6668f599face69a01.jpg)



Fig. 2. Process and step by step selecting paper for reference [7]



TABLE I. THE YEAR OF PUBLICATION OF EACH PAPER USED AS A REFERENCE


<table><tr><td>Paper Year Publish</td><td>Result</td></tr><tr><td>2011</td><td>1</td></tr><tr><td>2012</td><td>1</td></tr><tr><td>2014</td><td>1</td></tr><tr><td>2015</td><td>1</td></tr><tr><td>2016</td><td>1</td></tr><tr><td>2017</td><td>3</td></tr><tr><td>2018</td><td>4</td></tr><tr><td>2021</td><td>1</td></tr><tr><td>2022</td><td>1</td></tr><tr><td>N/A</td><td>10</td></tr></table>

From evidence mapping to inform the state of evidence and evidence synthesis in the table above, most papers that used as references were published in 2017-2018. 

This prism method is suitable for literature review studies because these stages are very thorough in sorting out suitable papers in the keywords Systematic Review Comparison of WASM VS JS Performance [8], [9]. Like the first step, namely identification with keywords that are parsed again. There we got a number of papers that are included in the keyword earlier [10], [11]. Then in this screening stage the papers obtained earlier are seen in terms of their purpose, then what is the process of searching for literature. The eligibility stage carries out how to carry out the process of searching literature, explaining portal sources searching literature, describing inclusion and exclusion criteria from articles or studies. This methodological review assesses the specifications and application of eligibility criteria in a systematic review of the papers we make [12]. And the included stage, where we will make suitable papers a reference for a Systematic Review of Comparison of WASM VS JS Performance [13]. 


TABLE II. THE PAPERS USED AS REFERENCES IN AUTHORS PAPER AFTER TRACING CAME FROM SEVERAL COUNTRIES


<table><tr><td>Country</td><td>Result</td></tr><tr><td>USA</td><td>11</td></tr><tr><td>Canada</td><td>2</td></tr><tr><td>Germany</td><td>2</td></tr><tr><td>Brazil</td><td>2</td></tr><tr><td>Thailand</td><td>1</td></tr><tr><td>Switzerland</td><td>1</td></tr><tr><td>Greece</td><td>1</td></tr><tr><td>United Kingdom</td><td>1</td></tr><tr><td>China</td><td>1</td></tr><tr><td>Hong Kong</td><td>1</td></tr><tr><td>India</td><td>1</td></tr><tr><td>Czech Republic</td><td>1</td></tr><tr><td>Portugal</td><td>1</td></tr></table>

Most of the papers used as references come from the USA [7]. 

# IV. DISCUSSION

This paper does not use graphical explanation because graphics are not effective for representing data from various types of research. 

# A. Runtime


TABLE III. SUMMARIZE OF SEVERAL PAPERS THAT COMPARING OF WASM AND JS SPEED PERFORMANCE WITH THE FOLLOWING COMPARISONS AND CONCLUSIONS


<table><tr><td>Comparison</td><td>Conclusion</td></tr><tr><td>WASM speed performance (C language) vs JS in heavy applications (games and pdf processors) and lightweight applications (fasta, fannkuch-reflux, and sorting) [14]</td><td>In light applications, WASM excels in some browsers, but in heavy applications, JS is faster.</td></tr><tr><td>WASM speed performance (C language) vs JS in light applications. [15]</td><td>In light applications, WASM excels over JS</td></tr><tr><td>WASM vs JS speed performance on ioT (Raspberry Pi) devices using simple algorithms such as chess move calculation and comparison of 2 protein sequences. [16]</td><td>JS is 39% slower when compared to WASM.</td></tr><tr><td>WASM vs JS speed performance in Numerical calculations [4]</td><td>WASM is faster in processing numerical calculations than JS</td></tr></table>

In testing, of course, several external factors that influence the speed of running a website, especially WASM or what is commonly called WASM, are latency, programming language, and type of compilers. [6]. 

1) Test for heavy and light weight application runtime comparison between JS and WASM 

The first test was carried out using the C language for WASM, carried out using a device with similar specifications 

[2]. so that device performance is balanced and the influence of external factors can be minimized. Testing was also carried out on the three most popular browsers today, namely Google Chrome with 92.0.4515.107 version (64-bit), Mozilla Firefox with 90.0 version (64-bit), and Microsoft Edge with 92.0.902.55 version beta (64). -bit). The tests were carried out on two types of applications, namely heavy applications such as games and PSPDFKit applications, and light applications (micro-benchmarks) in the three browsers. The following is a Comparison Chart for runtime comparison: 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-02/010a06ca-437d-476e-8087-421d5ee4248b/60a66894a9c4fd75bad49acd3e6fa19cb2597e0340c99a1354260593d3f37109.jpg)



Fig. 3. Heavy Application Comparison Average Runtime [14]


![image](https://cdn-mineru.openxlab.org.cn/result/2026-04-02/010a06ca-437d-476e-8087-421d5ee4248b/f50c39bbab76bab409073470435ef149eb5187507f9bfcba08ba7fc9d6948221.jpg)



Fig. 4. Light Application Comparison Average Runtime [14]


From testing on heavy applications such as Super Mario, Back To Color, and Pokemon and PSPDFKit, it can be concluded that for heavy applications such as games and PSPDFKit, JS has better performance than WASM. However, it can be concluded that for light applications such as sorting, Fannkuch-redux (a simple input output program for mathematical problems such as calculating permutations), and Fasta (a program for analyzing DNA sequences), the performance, especially the speed of WASM, can compete, even superior to some cases and browsers. Apart from that, another conclusion that can be drawn from some of the graphs above is that the stability level of WASM and JS is still very much affected by the performance of the browser used. 

2) Test for light algorithm runtime in IoT devices comparison between JS and WASM 

Then in the second test a comparison was made between JS and WASM speed performance on an IoT device, namely the Raspberry Pi with the Raspberry PI3 B model with specification 1.2GHz (64-bit) quad-core ARM Processor 1GB of RAM. Testing is carried out using a simple algorithm to compare its speed performance. The test is carried out 30 times for each of these simple algorithms [16]. With this, programmers who's using Javascript no longer have to worry 

about objects that need to be released or destroyed. Because when the value can no longer be used or reached, the interpreter knows that it already useless and will automatically reclaim the occupied memory [17]. 


TABLE IV. THE RESULTS OF EXPERIMENTS SIMPLE ALGORITHMS


<table><tr><td colspan="3">The results of the average time speed (sec) of the simple algorithm were run 30 times</td></tr><tr><td>Algorithm</td><td>JavaScript runtime (sec)</td><td>WASM runtime (sec)</td></tr><tr><td>Compute optimal alignment of two protein sequence</td><td>8.95</td><td>6.62</td></tr><tr><td>Detecting error in network transmission</td><td>10.35</td><td>7.86</td></tr><tr><td>Algorithm to compute how many combinations to wipe out n number of queen in n x n chess board</td><td>43.51</td><td>27.10</td></tr><tr><td>Algorithm to calculate LU decomposition in 1024 x 1024 random generated matrix</td><td>115.30</td><td>70.06</td></tr><tr><td>Breadth first search on random graph</td><td>7.79</td><td>2.24</td></tr><tr><td>Algorithm to calculate how much particle potential and relocation in 3D space</td><td>19.33</td><td>11.87</td></tr><tr><td>Fast fourier transform function on random data set</td><td>17.25</td><td>11.79</td></tr><tr><td>Diffusion way for ultrasonic and radar imaging apps</td><td>45.95</td><td>22.95</td></tr></table>

So, the conclusion is JS needs more time to run all the algorithm than WASM in raspberry pi [16]. Using JIT (Just-In-Time) Compilers can improve the performance speed of Javascript, by compiling bytecodes to native machine code during the execution. However, using Webassembly can see immediate increase in its performance from the beginning of running the code, because the code is statically typed, so the value of the variable is already known ahead of time [18]. 

# B. Energy

Looking at tables I – III in the results chapter, the results from testing the Chrome browser using WASM can be energy efficient by $2 0 . 8 8 \%$ compared to using JS. The next test is to execute WasmBoy and PSPDFKit using Chrome and Firefox, with summary that served in the results with table format below chapter showing that Chrome using WASM, which requires 5.1 joules of energy per second, can be energy efficient when using WasmBoy, compared to using JS, which requires energy of 7 joules per second [19]. According to the results of the comparison of browsers obtained, Chrome is more stable in terms of energy or time efficiency compared to Firefox [5], [20]. It can be concluded that using Chrome will help reduce energy usage. It can also be concluded that the use of WASM and JS produces quite a big difference [21], which can help developers in choosing a programming language for making web applications to save energy. 

Internet browsing is an activity that has been done by many people. With the various types of browsers that are available and can be used, such as Firefox, Chrome, Microsoft Edge, and many others, the differences are in the calculation of energy usage. Therefore, this paper will compare the results of calculations from tests of energy usage on two web browsers, namely Firefox and Chrome, using WASM and JS. 


TABLE V. WASMBOY ENERGY CONSUMED ON SEVERAL APPLICATION WITH EACH BROWSERS [19]


<table><tr><td colspan="5">Average energy that consumed on several games in various browsers.</td></tr><tr><td></td><td>WASM in Chrome</td><td>JS in Chrome</td><td>WASM in Firefox</td><td>JS in Firefox</td></tr><tr><td>Back to color</td><td>1100 Joules</td><td>800 Joules</td><td>1020 Joules</td><td>2800 Joules</td></tr><tr><td>Dinos Offline Adventure</td><td>42 Joules</td><td>56 Joules</td><td>59 Joules</td><td>102 Joules</td></tr><tr><td>Pokemon</td><td>260 Joules</td><td>370 Joules</td><td>380 Joules</td><td>875 Joules</td></tr><tr><td>Super Mario</td><td>250 Joules</td><td>370 Joules</td><td>400 Joules</td><td>850 Joules</td></tr><tr><td>Super Mario Land</td><td>260 Joules</td><td>375 Joules</td><td>400 Joules</td><td>870 Joules</td></tr><tr><td>Tobu Tobu Girl</td><td>80 Joules</td><td>124 Joules</td><td>120 Joules</td><td>247 Joules</td></tr></table>


TABLE VI. PSPDFKIT ENERGY CONSUMED WITH EACH BROWSER [19]


<table><tr><td colspan="5">Average energy that consumed on several light application in various browsers.</td></tr><tr><td></td><td>WASM in Chrome</td><td>JS in Chrome</td><td>WASM in Firefox</td><td>JS in Firefox</td></tr><tr><td>20 Pages Book</td><td>1250 Joules</td><td>1500 Joules</td><td>1125 Joules</td><td>2010 Joules</td></tr><tr><td>40 Pages Book</td><td>2480 Joules</td><td>2500 Joules</td><td>2200 Joules</td><td>3750 Joules</td></tr><tr><td>80 Pages Book</td><td>4200 Joules</td><td>4700 Joules</td><td>3800 Joules</td><td>6200 Joules</td></tr><tr><td>Paper</td><td>2000 Joules</td><td>1900 Joules</td><td>1600 Joules</td><td>2500 Joules</td></tr><tr><td>Powerpoint</td><td>2500 Joules</td><td>2800 Joules</td><td>2300 Joules</td><td>4000 Joules</td></tr></table>


TABLE VII. COMPARISON ENERGY BETWEEN SOME BROWSER EXAMPLE (CHROME AND FIREFOX) [22], [23]


<table><tr><td colspan="3">Average energy that consumed on several application to comparing Chrome andfirefox browser.</td></tr><tr><td></td><td>Chrome</td><td>Firefox</td></tr><tr><td>Youtube</td><td>2266 Joules</td><td>2110 Joules</td></tr><tr><td>Search Engine</td><td>937 Joules</td><td>949 Joules</td></tr><tr><td>Social Media</td><td>496 Joules</td><td>530 Joules</td></tr></table>

Table V is a comparison of energy use for WasmBoy, where comparisons are made in certain games using various browsers. In Table VI is a comparison of energy use in executing PSPDFKit where comparisons are made from various browsers using a certain number of pages, papers, and PowerPoint, and in Table VII is a comparison of energy use in executing various types of websites where comparisons are made from various browsers. 

# C. Memory


TABLE VIII. COMPARISON AVERAGE MEMORY USAGE BETWEEN POLYBENCHC [15]


<table><tr><td colspan="3">Average memory usage in PolyBenchC program (Kilo bytes)</td></tr><tr><td>Input Size</td><td>JS</td><td>WASM</td></tr><tr><td>Tiny</td><td>885.5</td><td>2020.1</td></tr><tr><td>Less Tiny</td><td>883.5</td><td>2123.7</td></tr><tr><td>Medium</td><td>883.7</td><td>3363.1</td></tr><tr><td>Less big</td><td>884.3</td><td>36168.3</td></tr><tr><td>Big</td><td>885.1</td><td>143899.5</td></tr><tr><td colspan="3">Average memory usage Firefox (Kilo bytes)</td></tr><tr><td>Input Size</td><td>JS</td><td>WASM</td></tr><tr><td>Tiny</td><td>508.67</td><td>1600.31</td></tr><tr><td>Less Tiny</td><td>492.02</td><td>1674.03</td></tr><tr><td>Medium</td><td>525.02</td><td>2583.72</td></tr><tr><td>Less big</td><td>517.88</td><td>26594.05</td></tr><tr><td>Big</td><td>511.26</td><td>103982.74</td></tr></table>


TABLE IX. FIREFOX AVERAGE MEMORY USAGE [24]



TABLE X. CHROME AVERAGE MEMORY USAGE [24]


<table><tr><td colspan="3">Average memory usage Chrome (Kilo bytes)</td></tr><tr><td>Input Size</td><td>JS</td><td>WASM</td></tr><tr><td>Tiny</td><td>879.41</td><td>2001.54</td></tr><tr><td>Less Tiny</td><td>878.73</td><td>2077.27</td></tr><tr><td>Medium</td><td>880.54</td><td>2985.78</td></tr><tr><td>Less big</td><td>883.10</td><td>26991.05</td></tr><tr><td>Big</td><td>889.20</td><td>100943.88</td></tr></table>

Through information from Table I, Table II and Table III have several input sizes, namely tiny (XS), less tiny (S), medium (M), less big (L), and big (XL). According to table I, PolyBenchC's benchmark program, memory usage in JS is almost entirely unchanged from input (between 883.5KB and 885.5KB). Likewise, WASM needs to take up plenty memory for bigger inputs. WASM uses approximately ${ \approx } 3 6 \mathrm { M B }$ of memory in the L size and about ${ \approx } 1 4 4 \mathrm { M B }$ of the XL size. From table I, WASM does not use a garbage collector system so most linear memory is initialized for simulated memory usage only if the WASM module is used. Its linear memory will also expand to a larger size when the first memory is exhausted rather than refactoring its memory unused. Conversely, JS is consistent in using a garbage collector that functions to monitor dynamically. Then based on table II and table III regarding Firefox and Chrome, overall, the memory usage is not unstable (between 492.02KB and 517.88KB) with several type of input size. On the other hand, WASM programs need much more memory usage as the time when the input size increases from M to L (increased by ${ \approx } 2 4 \mathrm { M B }$ ) and increased rapidly from L to XL (increased by ${ \approx } 7 7 \mathrm { M B }$ ). In addition, memory usage in Firefox is noticeably more efficient than Chrome for every kind of input size. 

JS has managed to become more efficient in memory management because JS has a garbage collector and uses dynamic programming to store its data [16]. 

To overcome the problem of large memory requirements, we can send some data through the API with the WASM module. This is the solution to the problem provided by WASM [25]. 


TABLE XI. THE RESEARCH QUESTION AND AIMS AS KEY QUESTION FORMULATION [15]


<table><tr><td>Research Questions (RQ)</td><td>Aims</td></tr><tr><td>What is WebAssembly and how does it improve the performance of web application?</td><td>To define WebAssembly and its function in increasing web application performance</td></tr><tr><td>How can developers determine which technology is better for website development (JavaScript vs WebAssembly)?</td><td>To assist developers in selecting the best technology (JavaScript or WebAssembly) for website development.</td></tr><tr><td>What are the performance differences between JavaScript and WebAssembly?</td><td>To compare the speed, memory usage, and energy consumption of JavaScript and WebAssembly.</td></tr></table>

# V. CONCLUSION

Based on our systematic review, we can conclude that WASM and JS are technologies used in web development. In 

this review, we perform a comparison based on runtime speed and stability, energy usage, and memory usage. This comparison is influenced by several aspects, such as device specifications, browsers, and the programming language used. In the comparison of speed performance for light applications, WASM is superior to JS, but for heavy applications, it is the other way around. However, compared to JS, WASM is superior for speed, performance, and stability for IoT devices. The stability level of WASM and JS is still influential on the performance of the browser used. Then, for a comparison of energy usage, the results of calculating memory usage for both have significant differences in numbers. Judging from the results obtained, WASM is proven to be a programming language that uses less energy than JS. Also, with different types of browsers, using Chrome can also help with energy efficiency. Lastly, compared to JS, WASM uses significantly more memory. It can be concluded that WASM is a good choice for use in web development because it has relatively high speed and stability performance and uses less energy. However, the choice between these two technologies must still be considered in light of what web needs will be developed. WASM will be more suitable for web applications that require high performance and complexity, while for webs that are simpler, interactive, and easy to develop, JS is the solution. The weakness of this study is that we did not make a test based on datasets, it is possible that future research can use datasets to compare these two methods to make them more reliable. 

# REFERENCES



[1] M. Reiser and L. Bläser, “Accelerate javascript applications by crosscompiling towebassembly,” in VMIL 2017 - Proceedings of the 9th ACM SIGPLAN International Workshop on Virtual Machines and Intermediate Languages, co-located with SPLASH 2017, Association for Computing Machinery, Inc, Oct. 2017, pp. 10–17. doi: 10.1145/3141871.3141873. 





[2] A. Haas et al., “Bringing the web up to speed with WebAssembly,” ACM SIGPLAN Notices, vol. 52, no. 6, pp. 185–200, Jun. 2017, doi: 10.1145/3062341.3062363. 





[3] P. Ratanaworabhan, B. Livshits, and B. G. Zorn, “JSMeter: Comparing the Behavior of JavaScript Benchmarks with Real Web Applications,” in Proceedings of the USENIX Conference on Web Application Development, 2010, pp. 1–12. 





[4] D. Herrera, H. Chen, E. Lavoie, and L. Hendren, “WebAssembly and JavaScript Challenge: Numerical program performance using modern browser technologies and devices,” 2018. 





[5] A. Jangda, B. Powers, E. D. Berger, and A. Guha, “Not So Fast: Analyzing the Performance of WebAssembly vs. Native Code,” in Proceedings of the 2019 USENIX Annual Technical Conference., 2019, pp. 1–15. 





[6] M. Musch, C. Wressnegger, M. Johns, and K. Rieck, “New Kid on the Web: A Study on the Prevalence of WebAssembly in the Wild,” in Detection of Intrusions and Malware, and Vulnerability Assessment, 16th International Conference, DIMVA 2019, Gothenburg, Sweden, June 19–20, 2019, Proceedings, 2019, pp. 1–20. doi: 10.1007/978-3- 030-22038-9_2. 





[7] M. H. Widianto, A. Sinaga, and M. A. Ginting, “A Systematic Review of LPWAN and Short-Range Network using AI to Enhance Internet of Things,” Journal of Robotics and Control (JRC), vol. 3, no. 4, pp. 505– 518, Jul. 2022, doi: 10.18196/jrc.v3i4.15419. 





[8] E. A. Cahyono, Sutomo, and A. Hartono, “LITERATUR REVIEW PANDUAN PENULISAN DAN PENYUSUNAN,” Jurnal Keperawatan, vol. XII, no. Vol. 12 No. 2 (2019): Jurnal Keperawatan, Volume XII, Nomor 2, Juli 2019, pp. 1–12, 2019. 





[9] M. Ridwan, B. Ulum, F. Muhammad, I. Indragiri, and U. Sulthan Thaha Saifuddin Jambi, “Pentingnya Penerapan Literature Review 





pada Penelitian Ilmiah (The Importance Of Application Of Literature Review In Scientific Research),” Jurnal Masohi, vol. 2, no. Vol 2 No 1 (2021): Jurnal Masohi, 2021, doi: 10.36339/jmas.v2i1.427. 





[10] L. Latifah and I. Ritonga, “Systematic Literature Review (SLR): Kompetensi Sumber Daya Insani Bagi Perkembangan Perbankan Syariah Di Indonesia,” Al Maal: Journal of Islamic Economics and Banking, vol. 2, no. 1, p. 63, Jul. 2020, doi: 10.31000/almaal.v2i1.2763. 





[11] E. Triandini et al., “Metode Systematic Literature Review untuk Identifikasi Platform dan Metode Pengembangan Sistem Informasi di Indonesia,” Indonesian Journal of Information Systems (IJIS, vol. 1, no. 2, pp. 1–15, 2019, doi: 10.24002/ijis.v1i2.1916. 





[12] Y. Wahyudin and D. N. Rahayu, “Analisis Metode Pengembangan Sistem Informasi Berbasis Website: A Literatur Review,” Jurnal Interkom: Jurnal Publikasi Ilmiah Bidang Teknologi Informasi dan Komunikasi, vol. 15, no. 3, pp. 26–40, Oct. 2020, doi: 10.35969/interkom.v15i3.74. 





[13] Siswanto, “SYSTEMATIC REVIEW SEBAGAI METODE PENELITIAN UNTUK MENSINTESIS HASIL-HASIL PENELITIAN (SEBUAH PENGANTAR),” Journal Neliti, vol. 13, no. 4, pp. 1–8, 2010, doi: 10.22435/bpsk.v13i4. 





[14] J. Teknologi, A. Bartuskova, O. Krejcar, T. Sabbah, A. Selamat, and J. Bahru, “WEBSITE SPEED TESTING ANALYSIS USING SPEEDTESTING MODEL,” Jurnal Teknologi 78(12):121-134, vol. 78, no. Vol. 78 No. 12-3: Towards Advancement of Sustainable Computational Technology, pp. 2180–3722, 2016, doi: 10.11113/jt.v78.10028. 





[15] W. Wang, “Empowering Web Applications with WebAssembly: Are We There Yet?,” in 2021 36th IEEE/ACM International Conference on Automated Software Engineering (ASE), 2021, pp. 1–5. doi: 10.1109/ASE51524.2021.9678831. 





[16] F. L. Oliveira and J. C. B. Mattos, “Analysis of WebAssembly as a Strategy to Improve JavaScript Performance on IoT Environments,” in Anais Estendidos do Simpósio Brasileiro de Engenharia de Sistemas Computacionais, 2020, pp. 1–6. doi: 10.5753/sbesc_estendido.2020.13102. 





[17] D. Flanagan, JavaScript: The Definitive Guide, 7th Edition, vol. 5673. 2020. 





[18] G. Gallant, WebAssembly in Action: With examples using $C + +$ and Emscripten, vol. 1. 2019. 





[19] J. De MacEdo, R. Abreu, R. Pereira, and J. Saraiva, “WebAssembly versus JavaScript: Energy and Runtime Performance,” in Proceedings - 2022 International Conference on ICT for Sustainability, ICT4S 2022, Institute of Electrical and Electronics Engineers Inc., 2022, pp. 24–34. doi: 10.1109/ICT4S55073.2022.00014. 





[20] J. Lourenço et al., “WebAssembly potentials: A performance analysis on desktop environment and opportunities for discussions to its application on CPS environment,” in Anais Estendidos do Simpósio Brasileiro de Engenharia de Sistemas Computacionais, 2020, pp. 1–6. doi: 10.5753/sbesc_estendido.2020.13104. 





[21] M. Van Hasselt, K. Huijzendveld, N. Noort, S. De Ruijter, T. Islam, and I. Malavolta, “Comparing the Energy Efficiency of WebAssembly and JavaScript in Web Applications on Android Mobile Devices,” in ACM International Conference Proceeding Series, Association for Computing Machinery, Jun. 2022, pp. 140–149. doi: 10.1145/3530019.3530034. 





[22] J. De MacEdo, J. Aloisio, N. Goncalves, R. Pereira, and J. Saraiva, “Energy Wars-Chrome vs. Firefox: Which browser is more energy efficient?,” in Proceedings - 2020 35th IEEE/ACM International Conference on Automated Software Engineering Workshops, ASEW 2020, Institute of Electrical and Electronics Engineers Inc., Sep. 2020, pp. 159–165. doi: 10.1145/3417113.3423000. 





[23] N. Gonçalves, R. Rua, J. Cunha, R. Pereira, and J. Saraiva, “Energy Efficiency of Web Browsers in the Android Ecosystem,” May 2022. doi: 10.48550/arXiv.2205.11399. 





[24] Y. Yan, T. Tu, L. Zhao, Y. Zhou, and W. Wang, “Understanding the performance of webassembly applications,” in Proceedings of the ACM SIGCOMM Internet Measurement Conference, IMC, Association for Computing Machinery, Nov. 2021, pp. 533–549. doi: 10.1145/3487552.3487827. 





[25] N. Mäkitalo, V. Bankowski, P. Daubaris, R. Mikkola, O. Beletski, and T. Mikkonen, “Bringing WebAssembly Up to Speed with Dynamic Linking,” in SAC ’21: The 36th ACM/SIGAPP Symposium on Applied Computing, 2021, p. 22. doi: 10.1145/34. 

