arch=$(uname -m) && \
    if [ "$arch" = "x86_64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"; \
    elif [ "$arch" = "arm64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"; \
    else \
    echo "Unsupported architecture: $arch"; \
    exit 1; \
    fi && \
    echo wget $MINICONDA_URL -O miniconda.sh --quiet && \
    echo mkdir -p /root/conda && \
    echo bash miniconda.sh -b -p /root/miniconda3 && \
    echo rm -f miniconda.sh