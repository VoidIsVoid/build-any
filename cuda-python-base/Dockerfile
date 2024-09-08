FROM ubuntu:22.04 AS base
ENV TZ=Asia/Shanghai
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y curl kmod libxml2 python3.10 python3-pip && \
    rm -rf /var/lib/apt/lists/*

ARG nvidia_binary_version="550.90.07"
ARG nvidia_binary="NVIDIA-Linux-x86_64-${nvidia_binary_version}.run"

WORKDIR /tmp
RUN curl -o driver_installer.run https://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_binary_version}/${nvidia_binary} && \ 
    sh ./driver_installer.run --accept-license --ui=none --no-kernel-module --no-questions && \
    rm ./driver_installer.run