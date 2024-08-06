set -e 

apt-get update -y
apt-get install -y git make curl wget

apt-get install software-properties-common -y
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y
apt-get install gcc-9 g++-9 -y

update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9
update-alternatives --config gcc

curl -O -L https://github.com/Kitware/CMake/releases/download/v3.30.1/cmake-3.30.1-linux-aarch64.tar.gz
tar xzf cmake-3.30.1-linux-aarch64.tar.gz
rm -rf cmake-3.30.1-linux-aarch64.tar.gz

export PATH=$PATH:/tmp/cmake-3.30.1-linux-aarch64/bin

arch=$(uname -m) 
echo "arch $arch"
if [ "$arch" = "x86_64" ]; then 
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"; 
elif [ "$arch" = "aarch64" ]; then 
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"; \
else 
    echo "Unsupported architecture: $arch"; 
    exit 1; 
fi 
wget $MINICONDA_URL -O miniconda.sh --quiet
mkdir -p /root/conda
bash miniconda.sh -b -p /root/miniconda3
rm -f miniconda.sh

/root/miniconda3/bin/conda init bash

source /root/miniconda3/bin/activate base
conda create -n py39 'python=3.9' -y
echo 'source /root/miniconda3/bin/activate py39' >> "/root/.bashrc"
source /root/miniconda3/bin/activate py39
pip3 install attrs numpy decorator sympy cffi pyyaml pathlib2 psutil protobuf scipy requests absl-py wheel typing_extensions --no-cache-dir

git clone https://github.com/ggerganov/llama.cpp.git

cp ascend_install.info /etc/
mkdir -p /usr/local/Ascend/driver/
cp version.info /usr/local/Ascend/driver/


CANN_CATEGORY="CANN%208.0.RC1"
CANN_VERSION="8.0.RC1"
curl -k -o toolkit.run https://ascend-repo.obs.cn-east-2.myhuaweicloud.com/CANN/${CANN_CATEGORY}/Ascend-cann-toolkit_${CANN_VERSION}_linux-aarch64.run?response-content-type=application/octet-stream
chmod +x toolkit.run
./toolkit.run --install-path=/usr/local/Ascend/ --install --quiet

source /usr/local/Ascend/ascend-toolkit/set_env.sh

curl -k -o kernels.run https://ascend-repo.obs.cn-east-2.myhuaweicloud.com/CANN/CANN%208.0.RC1/Ascend-cann-kernels-910_${CANN_VERSION}_linux.run?response-content-type=application/octet-stream
chmod +x kernels.run
./kernels.run --install-path=/usr/local/Ascend/ --install --quiet


cd /tmp/llama.cpp
cmake -B build -DGGML_CANN=ON -DBUILD_SHARED_LIBS=OFF -DCMAKE_LIBRARY_PATH=${ASCEND_TOOLKIT_HOME}\lib64
cmake --build build --config Release --target llama-cli -j


CMAKE_ARGS="-DLLAMA_BUILD=OFF" pip install llama-cpp-python --no-cache-dir
pip install llama-cpp-python[server] --no-cache-dir

cd /tmp
conda install conda-pack
conda pack -o venv.tar.gz
mkdir /tmp/python
mv venv.tar.gz /tmp/python/
cd /tmp/python/ 
tar xzf venv.tar.gz


echo 'source /usr/local/Ascend/ascend-toolkit/set_env.sh' >> /tmp/env.sh 
echo 'source /app/python/bin/activate' >> /tmp/env.sh 
echo 'export LLAMA_CPP_LIB=/app/llama.cpp/build/src/libllama.so' >> /tmp/env.sh 
