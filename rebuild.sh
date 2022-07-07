#!/bin/bash

dcp stop $1 \
  && dcp build $1 \
  && dcp up -d $1 \
  && dcp exec $1 bash

