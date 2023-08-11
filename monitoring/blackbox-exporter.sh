#!/bin/bash

#sudo docker run -d -p 9115:9115 prom/blackbox-exporter

sudo docker service create \
  --mode=global \
  --publish=9115:9115 \
  --detach=true \
  --name=blackbox-exporter \
  prom/blackbox-exporter

