FROM ubuntu:22.04 as base
ENV TZ=Asia/Shanghai
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y curl git make gcc g++ kmod libxml2 nvidia-driver-535-server && \
    rm -rf /var/lib/apt/lists/*


ARG nvidia_binary_version="535.183.06"
ARG nvidia_binary="NVIDIA-Linux-x86_64-${nvidia_binary_version}.run"
ARG cuda_version=12.2.0
ARG cuda_buildin_driver_version=535.54.03

WORKDIR /tmp
RUN curl -o cuda_toolkit_installer.run https://developer.download.nvidia.com/compute/cuda/${cuda_version}/local_installers/cuda_${cuda_version}_${cuda_buildin_driver_version}_linux.run && \
    cd /tmp && \
    sh ./cuda_toolkit_installer.run --silent --toolkit --no-drm && \
    rm ./cuda_toolkit_installer.run && \
    echo 'export PATH=$PATH:/usr/local/cuda/bin' >> /env.sh && \
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> /env.sh && \
    echo 'source /env.sh' >> /root/.bashrc && \
    echo 'export PATH=$PATH:/app/cmake/bin:/app/llama.cpp/build/bin' >> /env.sh