#!
set -e
cd $(cat current)
sudo sed -i -z 's/\(.*\)}\(.*\)/\1,"data-root":"\/mnt\/docker" }\2/' /etc/docker/daemon.json
sudo systemctl restart docker

FILE="run.sh"

if [ -f "$FILE" ]; then
    exec "$FILE"
else
    docker buildx build --push -t ${DOCKER_USERNAME}/$(cat docker-name.txt):$(cat docker-tag.txt) .
fi