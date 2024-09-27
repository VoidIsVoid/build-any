#!/bin/bash
set -e 
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp
tag=$(git describe --tags $(git rev-list --tags --max-count=1))
cd ..
docker buildx build --push -t ${DOCKER_USERNAME}/$(cat docker-name.txt):$tag .
