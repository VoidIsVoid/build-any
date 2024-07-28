FROM ubuntu:20.04 

ARG HOST_ASCEND_BASE=/usr/local/Ascend 
ARG INSTALL_ASCEND_PKGS_SH=install_ascend_pkgs.sh 
ARG TOOLKIT_PATH=/usr/local/Ascend/ascend-toolkit/latest 
ARG MINDSPORE_PKG=mindspore-{version}-cp39-cp39-linux_aarch64.whl
# ARG PREBUILD_SH=prebuild.sh 
# ARG POSTBUILD_SH=postbuild.sh 
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp 
COPY . ./ 

# 触发prebuild.sh 
# RUN bash -c "test -f $PREBUILD_SH && bash $PREBUILD_SH" 

# ENV http_proxy http://xxx
# ENV https_proxy http://xxx


# 系统包 
RUN apt update && \ 
    apt install --no-install-recommends curl g++ pkg-config unzip wget build-essential zlib1g-dev  \
        libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libblas3 liblapack3 liblapack-dev openssl libssl-dev libblas-dev gfortran libhdf5-dev libffi-dev  libxml2 libbz2-dev -y

# 根据实际mindspore软件包安装对应的python版本
RUN wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz --no-check-certificate
RUN tar -zxvf Python-3.9.2.tgz && cd Python-3.9.2 && ./configure --prefix=/usr/local/python3.9.2 --enable-shared && make && make install 

RUN ln -s /usr/local/python3.9.2/bin/python3.9 /usr/local/python3.9.2/bin/python && \
    ln -s /usr/local/python3.9.2/bin/pip3.9 /usr/local/python3.9.2/bin/pip


# 配置Python pip源 
# RUN mkdir -p ~/.pip \ 
# && echo '[global] \n\ 
# index-url=https://pypi.doubanio.com/simple/\n\ 
# trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf 

# 用户需根据实际情况修改PYTHONPATH的路径
ENV LD_LIBRARY_PATH=/usr/local/python3.9.2/lib:$LD_LIBRARY_PATH
ENV PATH=/usr/local/python3.9.2/bin:$PATH 
ENV PYTHONPATH=/usr/local/python3.9.2/lib/python3.9/site-packages:$PYTHONPATH   

# 创建HwHiAiUser用户和属主，UID和GID请与物理机保持一致避免出现无属主文件。示例中会自动创建user和对应的group，UID和GID都为1000
RUN useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser

# Python包 
RUN pip install --upgrade pip && \
    pip install numpy && \ 
    pip install decorator && \ 
    pip install sympy==1.4 && \ 
    pip install cffi==1.12.3 && \ 
    pip install pyyaml && \ 
    pip install pathlib2 && \ 
    pip install grpcio && \ 
    pip install grpcio-tools && \ 
    pip install protobuf && \ 
    pip install scipy && \ 
    pip install requests && \
    pip install kubernetes && \
    pip install attrs && \
    pip install psutil && \
    pip install absl-py

# Ascend包 
RUN umask 0022 && bash $INSTALL_ASCEND_PKGS_SH 

# MindSpore安装 
RUN pip install https://ms-release.obs.cn-north-4.myhuaweicloud.com/2.2.14/MindSpore/unified/aarch64/mindspore-2.2.14-cp39-cp39-linux_aarch64.whl mindnlp

# RUN pip install mindnlp

# RUN source /usr/local/Ascend/ascend-toolkit/set_env.sh
# ENV http_proxy "" 
# ENV https_proxy "" 

# # 触发postbuild.sh 
# RUN bash -c "test -f $POSTBUILD_SH && bash $POSTBUILD_SH" && \ 
#     rm $POSTBUILD_SH