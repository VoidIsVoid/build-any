set -eo
function docker_save(){
  skopeo copy docker://$1 docker-archive:$2:$1
  echo "docker images download finished. start gzip"
  pigz $2
}

docker_image_name=$DOKCER_IMAGE
docker_image_file=$DOCKER_TARGET

cd /mnt
GIT_LFS_SKIP_SMUDGE=1 git clone "https://oauth2:${MODELSCOPE_TOKEN}@www.modelscope.cn/datasets/gimling/my-ms-repo.git"
cd my-ms-repo
git lfs install
mkdir -p $(dirname "$docker_image_file")
docker_save "$docker_image_name" "$docker_image_file"
git add .
git commit -m "add $docker_image_name"
git push