FROM nvidia/cuda:11.3.1-devel-ubuntu20.04 AS build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y git curl
WORKDIR /app
RUN git clone https://github.com/ggerganov/llama.cpp.git
RUN curl -O -L https://github.com/Kitware/CMake/releases/download/v3.30.1/cmake-3.30.1-linux-x86_64.tar.gz
RUN tar xzf cmake-3.30.1-linux-x86_64.tar.gz
SHELL ["bash", "-c"]
RUN export PATH=$PATH:/app/cmake-3.30.1-linux-x86_64/bin && \
    export CMAKE_CUDA_ARCHITECTURES="50;52;61;70;75;80" && \
    cd llama.cpp && \
    cmake -B build -DGGML_CUDA=ON && \
    cmake --build build --config Release -j


FROM nvidia/cuda:11.3.1-runtime-ubuntu20.04 AS release
RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update -y && \
    apt-get install gcc-9 g++-9 -y && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9 && \
    update-alternatives --config gcc && \
    apt-get clean
COPY --from=build /app/llama.cpp /app/llama.cpp
