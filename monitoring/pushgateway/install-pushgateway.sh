#!/bin/bash

sudo useradd --no-create-home pushgateway

wget https://github.com/prometheus/pushgateway/releases/download/v1.4.2/pushgateway-1.4.2.linux-amd64.tar.gz
tar xvfz pushgateway-1.4.2.linux-amd64.tar.gz

sudo cp pushgateway-1.4.2.linux-amd64/pushgateway /usr/local/bin/

sudo chown pushgateway:pushgateway /usr/local/bin/pushgateway

sudo systemctl daemon-reload
sudo systemctl enable pushgateway
sudo systemctl start pushgateway
