set -e
source /root/miniconda3/bin/activate base
conda create -n py39 'python=3.9.2'
echo 'source /root/miniconda3/bin/activate py39' >> "/root/.bashrc"
source /root/miniconda3/bin/activate py39
conda install -y gcc_linux-64=9 gxx_linux-64=9 cmake=3.26 git

ln -s $GCC /usr/local/bin/gcc
ln -s $GXX /usr/local/bin/g++


pip3 install attrs numpy decorator sympy cffi pyyaml pathlib2 psutil protobuf scipy requests absl-py wheel typing_extensions --no-cache-dir

git clone https://github.com/ggerganov/llama.cpp.git
