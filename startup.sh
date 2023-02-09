#!/usr/bin/zsh
dir="/home/waiyan/Projects"

if [ ! -d $dir/$1 ]; then
  path="$dir/Frontiir/$1"
else
  path="$dir/$1"
fi

docker run \
  -it \
  --mount type=bind,source=$path,target=/home/dev/app \
  --name dev_$1 \
  --network host \
  --hostname $1 \
  dev_env:latest

