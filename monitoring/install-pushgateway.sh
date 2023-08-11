#!/bin/bash

sudo docker service create \
  --mode=global \
  --publish=9091:9091 \
  --detach=true \
  --name=pushgateway \
  prom/pushgateway
