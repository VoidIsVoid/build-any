set -e
source /root/miniconda3/bin/activate base
conda create -n py39 'python=3.9' -y
echo 'source /root/miniconda3/bin/activate py39' >> "/root/.bashrc"
source /root/miniconda3/bin/activate py39

pip3 install attrs numpy decorator sympy cffi pyyaml pathlib2 psutil protobuf scipy requests absl-py wheel typing_extensions --no-cache-dir

git clone https://github.com/ggerganov/llama.cpp.git
rm -rf llama.cpp/.git