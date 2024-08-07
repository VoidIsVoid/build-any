FROM ubuntu:18.04 as base

RUN apt-get update -y && \
    apt-get install -y zlib1g zlib1g-dev openssl libsqlite3-dev libssl-dev libffi-dev unzip pciutils net-tools libblas-dev gfortran libblas3 && \
    apt-get clean


FROM base as build
WORKDIR /tmp
COPY . .
RUN chmod +x ./install.sh && bash install.sh


# FROM base

# COPY --from=build /tmp/llama.cpp /app/llama.cpp
# COPY --from=build /tmp/python /app/python
# COPY --from=build /tmp/env.sh /app/env.sh

# ENV START_SHELL python3 -m llama_cpp.server --model /qwen2-7b-instruct-q4_0.gguf --host 0.0.0.0 --port 9000 --model_alias qwen

# CMD source /app/env.sh && \
#     bash -c "$START_SHELL"