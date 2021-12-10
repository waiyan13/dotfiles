#! /bin/sh

docker build \
  -t dev_py:latest \
  $(for i in `cat .env`; \
  do out+="--build-arg $i " ; \
  done; echo $out;out="") \
  .
