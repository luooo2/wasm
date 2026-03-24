# wasm
my graduation project： wasm vs native 性能分析


**项目运行说明**

- docker build -t wasm-dev .
构建容器
- docker run -it -v "%cd%":/code --name wasm-dev-container  wasm-dev
启动容器(不自动删除)
- exit
退出(容器仍在后台)
- docker start -ai wasm-dev-container
再次进入
- docker rm wasm-dev-container
彻底删除容器(当不再需要时)
> 若 wasmtime 安装失败，可手动执行 curl https://wasmtime.dev/install.sh -sSf | bash 进行安装


**环境说明**：
- clang 
Ubuntu clang version 18.1.3 (1ubuntu1)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
- wasi-sdk-clang
clang version 22.1.0-wasi-sdk (https://github.com/llvm/llvm-project 4434dabb69916856b824f68a64b029c67175e532)
Target: wasm32-unknown-wasip1
Thread model: posix
InstalledDir: /opt/wasi-sdk/bin
Configuration file: /opt/wasi-sdk/bin/clang.cfg
- wasmtime
wasmtime 43.0.0 (be23469ec 2026-03-20)