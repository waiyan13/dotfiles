#!/usr/bin/zsh
dir="/home/waiyan13/Projects"

docker run \
  -it \
  --mount type=bind,source=$dir,target=/home/dev/Projects \
  --name dev_$1 \
  --network dockerize_dockerize_network \
  --hostname $1 \
  --entrypoint /usr/bin/zsh \
  --expose 0.0.0.0:9000:9000/tcp \
  dev_env_${2}:latest
