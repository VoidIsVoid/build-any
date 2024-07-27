#!/bin/bash
#--------------------------------------------------------------------------------
# 请在此处使用bash语法编写脚本代码，安装昇腾软件包
#
# 注：本脚本运行结束后不会被自动清除，若无需保留在镜像中请在postbuild.sh脚本中清除
#--------------------------------------------------------------------------------
# 构建之前把host上的/etc/ascend_install.info拷贝一份到当前目录
set -e
cp ascend_install.info /etc/
mkdir -p /usr/local/Ascend/driver/
cp version.info /usr/local/Ascend/driver/

# Ascend-cann-toolkit_{version}_linux-{arch}.run
curl -k -o Ascend-cann-toolkit_8.0.RC3.alpha001_linux-aarch64.run https://ascend-repo.obs.cn-east-2.myhuaweicloud.com/Milan-ASL/Milan-ASL%20V100R001C19SPC802/Ascend-cann-toolkit_8.0.RC3.alpha001_linux-aarch64.run?response-content-type=application/octet-stream
chmod +x Ascend-cann-toolkit_8.0.RC3.alpha001_linux-aarch64.run
./Ascend-cann-toolkit_8.0.RC3.alpha001_linux-aarch64.run --install-path=/usr/local/Ascend/ --install --quiet

rm Ascend-cann-toolkit_8.0.RC3.alpha001_linux-aarch64.run
# 只安装toolkit包，需要清理，容器启动时通过ascend docker挂载进来
# rm -f version.info
# rm -rf /usr/local/Ascend/driver/
