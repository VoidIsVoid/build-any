FROM ubuntu:20.04 as base
ENV TZ=Asia/Shanghai
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y curl git make gcc g++ kmod libxml2 && \
    rm -rf /var/lib/apt/lists/*


ARG nvidia_binary_version="470.57.02"
ARG nvidia_binary="NVIDIA-Linux-x86_64-${nvidia_binary_version}.run"
ARG cuda_version=12.2.0
ARG cuda_buildin_driver_version=535.54.03


WORKDIR /tmp
RUN curl -o driver_installer.run https://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_binary_version}/${nvidia_binary}
RUN curl -o cuda_toolkit_installer.run https://developer.download.nvidia.com/compute/cuda/${cuda_version}/local_installers/cuda_${cuda_version}_${cuda_buildin_driver_version}_linux.run
RUN cd /tmp && \
    sh ./driver_installer.run --accept-license --ui=none --no-kernel-module --no-questions && \
    sh ./cuda_toolkit_installer.run --silent --toolkit --no-drm && \
    rm ./driver_installer.run ./cuda_toolkit_installer.run && \
    echo 'export PATH=$PATH:/usr/local/cuda/bin' >> /env.sh && \
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> /env.sh && \
    echo 'source /env.sh' >> /root/.bashrc && \
    echo 'export PATH=$PATH:/app/cmake/bin:/app/llama.cpp/build/bin' >> /env.sh

WORKDIR /app/
RUN curl -O https://github.com/Kitware/CMake/releases/download/v3.30.1/cmake-3.30.1-linux-x86_64.tar.gz && \
    tar xvf cmake-3.30.1-linux-x86_64.tar.gz && \
    mv cmake-3.30.1-linux-x86_64 cmake && \
    rm -f cmake-3.30.1-linux-x86_64.tar.gz

FROM scratch
COPY --from=base / /