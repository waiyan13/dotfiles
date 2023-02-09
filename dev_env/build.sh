#! /bin/sh

DOCKER_BUILDKIT=1 docker build \
  -t dev_env:latest \
  $(for i in `cat .env`; \
  do out+="--build-arg $i " ; \
  done; echo $out;out="") \
  .
