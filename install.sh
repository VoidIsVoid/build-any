apt update -y
apt install -y curl zip unzip
curl -s "https://get.sdkman.io" | bash
# source "/root/.sdkman/bin/sdkman-init.sh"
sdk install java 11.0.24-zulu

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
. /root/.bashrc

nvm install 20

cat << "EOF" > package.json
{
  "name": "gatling-js-demo",
  "version": "3.11.4",
  "private": true,
  "type": "module",
  "main": "target/bundle",
  "dependencies": {
    "@gatling.io/core": "3.11.5",
    "@gatling.io/http": "3.11.5"
  },
  "devDependencies": {
    "@gatling.io/cli": "3.11.5",
    "prettier": "3.2.5",
    "rimraf": "5.0.7"
  },
  "scripts": {
    "clean": "rimraf target",
    "format": "prettier --write \"**/*.js\"",
    "build": "gatling build",
    "recorder": "gatling recorder",
    "computerdatabase": "gatling run --simulation computerdatabase"
  }
}
EOF
npm_config_registry=http://mirrors.cloud.tencent.com/npm npm i
npx gatling install