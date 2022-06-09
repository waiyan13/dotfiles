#!/bin/bash
dir="/home/waiyan/projects"

if [ ! -d $dir/$1 ]
then
  dir="/home/waiyan/projects/frontiir/$1"
fi

docker run \
  -it \
  --mount type=bind,source=$dir,target=/home/dev/app \
  --name dev_$1 \
  --network host \
  --hostname $1 \
  dev_env:latest

