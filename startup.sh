#!/usr/bin/zsh
dir="/home/waiyan/Projects"

if [ ! -d $dir/$1 ]; then
  path_dir="$dir/Frontiir/$1"
else
  path_dir="$dir/$1"
fi

docker run \
  -it \
  --mount type=bind,source=$path_dir,target=/home/dev/app \
  --name dev_$1 \
  --network host \
  --hostname $1 \
  --entrypoint /usr/bin/zsh \
  dev_env_${2}:latest
