#! /bin/sh

docker build \
  -t dev_env:latest \
  $(for i in `cat .env`; \
  do out+="--build-arg $i " ; \
  done; echo $out;out="") \
  .
