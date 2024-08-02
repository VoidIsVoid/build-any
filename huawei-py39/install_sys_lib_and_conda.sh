set -e 


apt install -y git make

apt-get update -y
apt-get install software-properties-common -y
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update -y
apt-get install gcc-9 g++-9 -y
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9
update-alternatives --config gcc



curl -O -L https://github.com/Kitware/CMake/releases/download/v3.30.1/cmake-3.30.1-linux-aarch64.tar.gz
tar xzf cmake-3.30.1-linux-aarch64.tar.gz
echo 'export PATH=$PATH:/tmp/cmake-3.30.1-linux-aarch64/bin' >> "/root/.bashrc"

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