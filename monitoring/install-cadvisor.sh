#!/bin/bash

sudo docker service create \
  --mode=global \
  --mount type=bind,source=/,target=/rootfs,readonly=true \
  --mount type=bind,source=/var/run,target=/var/run \
  --mount type=bind,source=/sys,target=/sys,readonly=true \
  --mount type=bind,source=/var/lib/docker,target=/var/lib/docker,readonly=true \
  --publish=8081:8081 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:latest
