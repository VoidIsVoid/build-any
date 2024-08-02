FROM ubuntu:18.04
RUN apt update && apt install curl wget zlib1g zlib1g-dev openssl libsqlite3-dev libssl-dev libffi-dev unzip pciutils net-tools libblas-dev gfortran libblas3 -y
WORKDIR /tmp
COPY install_sys_lib_and_conda.sh ./
SHELL ["bash", "-c"]
RUN chmod +x ./install_sys_lib_and_conda.sh && bash install_sys_lib_and_conda.sh
COPY after_conda.sh ./
RUN chmod +x ./after_conda.sh && bash after_conda.sh