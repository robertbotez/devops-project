#!/bin/bash

sudo docker service create \
  --mode=global \
  --publish=9100:9100 \
  --detach=true \
  --name=node-exporter \
  prom/node-exporter
