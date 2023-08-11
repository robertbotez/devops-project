#!/bin/bash

sudo apt-get install -y adduser libfontconfig1

wget https://dl.grafana.com/oss/release/grafana_8.2.2_amd64.deb
sudo dpkg -i grafana_8.2.2_amd64.deb

sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl enable grafana-server.service
