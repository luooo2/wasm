# 直接用官方 WASI SDK 镜像（内置 wasi-sdk-clang，不用自己装）
FROM ghcr.io/webassembly/wasi-sdk

# 1. 安装原生 clang（用于编译原生可执行文件）
RUN apt update && apt install -y curl clang xz-utils

# 2. 安装 wasmtime（用于运行 wasm）
RUN curl https://wasmtime.dev/install.sh -sSf | bash

# 1. 为 WASI SDK 创建别名
RUN ln -s /opt/wasi-sdk/bin/clang /usr/local/bin/wasi-clang \
    && ln -s /opt/wasi-sdk/bin/clang++ /usr/local/bin/wasi-clang++

# 2. 为系统原生 clang 创建别名（注意：系统 clang 在 /usr/bin/clang）
RUN ln -s /usr/bin/clang /usr/local/bin/native-clang \
    && ln -s /usr/bin/clang++ /usr/local/bin/native-clang++

# 设置 PATH，让 /usr/local/bin 优先（包含我们的别名）
# 但不让 WASI SDK 的 clang 覆盖默认 clang
ENV PATH="/usr/local/bin:/root/.wasmtime/bin:$PATH"

# 设置默认使用 wasip1 目标（可选）
ENV WASI_SDK_TARGET="wasm32-wasip1"

# 工作目录
WORKDIR /code