#!/usr/bin/zsh
dir="/home/waiyan/Projects"

docker run \
  -it \
  --mount type=bind,source=$dir,target=/home/dev/Projects \
  --name dev_$1 \
  --network dockerize_nw_network \
  --hostname $1 \
  --entrypoint /usr/bin/zsh \
  -p ${3}:${3}/tcp \
  dev_env_${2}:latest
