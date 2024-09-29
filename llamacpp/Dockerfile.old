FROM ubuntu:20.04 as base
ENV TZ=Asia/Shanghai
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y curl git make gcc g++ kmod libxml2 && \
    rm -rf /var/lib/apt/lists/*


ARG cuda_version=12.2.0
ARG cuda_buildin_driver_version=535.54.03

WORKDIR /tmp
RUN curl -o cuda_toolkit_installer.run https://developer.download.nvidia.com/compute/cuda/${cuda_version}/local_installers/cuda_${cuda_version}_${cuda_buildin_driver_version}_linux.run && \
    sh ./cuda_toolkit_installer.run --silent --toolkit --no-drm && \
    rm ./cuda_toolkit_installer.run && \
    echo 'export PATH=$PATH:/usr/local/cuda/bin' >> /env.sh && \
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> /env.sh && \
    echo 'source /env.sh' >> /root/.bashrc && \
    echo 'export PATH=$PATH:/app/cmake/bin:/app/llama.cpp/build/bin' >> /env.sh

WORKDIR /app/
RUN curl -s -L -O https://github.com/Kitware/CMake/releases/download/v3.30.1/cmake-3.30.1-linux-x86_64.tar.gz && \
    tar xzf cmake-3.30.1-linux-x86_64.tar.gz && \
    mv cmake-3.30.1-linux-x86_64 cmake && \
    rm -f cmake-3.30.1-linux-x86_64.tar.gz

COPY llama.cpp /app/llama.cpp
RUN cd llama.cpp && \
   . /env.sh && \
   cmake -B build -DGGML_CUDA=ON \
      '-DCMAKE_CUDA_ARCHITECTURES=60;61;70;72;75;80;86;87' \
      -DGGML_CUDA_F16=ON && \
      cmake --build build --config Release -j