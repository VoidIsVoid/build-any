FROM ubuntu:18.04
WORKDIR /tmp
COPY install_sys_lib_and_conda.sh ./
RUN chmod +x ./install_sys_lib_and_conda.sh && bash install_sys_lib_and_conda.sh
# COPY after_conda.sh ./
# RUN chmod +x ./after_conda.sh && bash after_conda.sh