FROM ubuntu:22.04 as base
ENV TZ=Asia/Shanghai
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y curl git make gcc g++ kmod libxml2 && \
    rm -rf /var/lib/apt/lists/*


ARG nvidia_binary_version="550.90.07"
ARG nvidia_binary="NVIDIA-Linux-x86_64-${nvidia_binary_version}.run"
ARG cuda_version=12.4.1
ARG cuda_buildin_driver_version=550.54.15

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


FROM scratch
COPY --from=base / /

RUN . /env.sh