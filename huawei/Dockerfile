FROM ubuntu:18.04

ARG HOST_ASCEND_BASE=/usr/local/Ascend
ARG INSTALL_ASCEND_PKGS_SH=install_ascend_pkgs.sh
ARG TOOLKIT_PATH=/usr/local/Ascend/ascend-toolkit/latest 
# ARG MINDSPORE_PKG=mindspore-2.2.14-cp37-cp37m-linux_aarch64.whl
# ARG PREBUILD_SH=prebuild.sh
# ARG POSTBUILD_SH=postbuild.sh
WORKDIR /tmp
COPY . ./

# 触发prebuild.sh
# RUN bash -c "test -f $PREBUILD_SH && bash $PREBUILD_SH"

# ENV http_proxy http://xxx.xxx.xxx.xxx:xxx
# ENV https_proxy http://xxx.xxx.xxx.xxx:xxx

# 系统包
RUN apt update && \
    apt install --no-install-recommends python3.7 python3.7-dev curl g++ pkg-config unzip \
        libblas3 liblapack3 liblapack-dev libblas-dev gfortran libhdf5-dev libffi-dev libicu60 libxml2 \ 
            libgmp-dev -y

# 建立Python软链接
RUN ln -s /usr/bin/python3.7 /usr/bin/python

# 配置Python pip源
RUN mkdir -p ~/.pip \
&& echo '[global] \n\
index-url=https://pypi.doubanio.com/simple/\n\
trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf

# pip3.7
RUN curl -k https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    cd /tmp && \
    apt-get download python3-distutils && \
    dpkg-deb -x python3-distutils_*.deb / && \
    rm python3-distutils_*.deb && \
    cd - && \
    python3.7 get-pip.py && \
    rm get-pip.py

# 创建HwHiAiUser用户和属主，UID和GID请与物理机保持一致避免出现无属主文件。示例中会自动创建user和对应的group，UID和GID都为1000
RUN useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser

 # 用户需根据实际情况修改PYTHONPATH的路径
ENV PYTHONPATH=/usr/local/python3.7.5/lib/python3.7/site-packages:$PYTHONPATH 

# Python包
RUN pip3.7 install numpy && \
    pip3.7 install decorator && \
    pip3.7 install sympy==1.4 && \
    pip3.7 install cffi==1.12.3 && \
    pip3.7 install pyyaml && \
    pip3.7 install pathlib2 && \
    pip3.7 install grpcio && \
    pip3.7 install grpcio-tools && \
    pip3.7 install protobuf && \
    pip3.7 install scipy && \
    pip3.7 install requests && \
    pip3.7 install easydict && \
    pip3.7 install attrs && \
    pip3.7 install psutil && \
    pip3.7 install absl-py

# Ascend包
RUN umask 0022 && bash $INSTALL_ASCEND_PKGS_SH

# MindSpore安装
RUN pip3.7 install https://ms-release.obs.cn-north-4.myhuaweicloud.com/2.2.14/MindSpore/unified/aarch64/mindspore-2.2.14-cp37-cp37m-linux_aarch64.whl

# 创建/lib64/ld-linux-aarch64.so.1
RUN umask 0022 && \
    if [ ! -d "/lib64" ]; \
    then \
        mkdir /lib64 && ln -sf /lib/ld-linux-aarch64.so.1 /lib64/ld-linux-aarch64.so.1; \
    fi

# ENV http_proxy ""
# ENV https_proxy ""

# 触发postbuild.sh
# RUN bash -c "test -f $POSTBUILD_SH && bash $POSTBUILD_SH" && \
#     rm $POSTBUILD_SH