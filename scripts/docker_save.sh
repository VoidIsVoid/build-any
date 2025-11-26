set -eo
function docker_save(){
  sudo docker run \
    -i --rm \
    -v /var/run/docker.sock:/var/run/docker.sock -v .:/app -w /app \
    shinomineko/skopeo:latest \
    copy docker://$1 docker-archive:$2:$1
  gzip $2
}

docker_image_name=$DOKCER_IMAGE
docker_image_file=$DOCKER_TARGET

cd /mnt
GIT_LFS_SKIP_SMUDGE=1 git clone "https://oauth2:${MODELSCOPE_TOKEN}@www.modelscope.cn/datasets/gimling/test.git"
cd test
git lfs install
mkdir -p $(dirname "$docker_image_file")
docker_save "$docker_image_name" "$docker_image_file"
git commit -am "add $docker_image_name" .
git push