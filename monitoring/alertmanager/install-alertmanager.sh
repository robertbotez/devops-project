#!/bin/bash

sudo useradd --no-create-home alertmanager
wget https://github.com/prometheus/alertmanager/releases/download/v0.23.0/alertmanager-0.23.0.linux-amd64.tar.gz
tar xvfz alertmanager-0.23.0.linux-amd64.tar.gz

sudo mkdir -p /var/lib/alertmanager
sudo mkdir -p /etc/alertmanager

sudo cp alertmanager-0.23.0.linux-amd64/alertmanager /usr/local/bin/
sudo cp alertmanager-0.23.0.linux-amd64/alertmanager.yml  /etc/alertmanager

sudo chown alertmanager:alertmanager /usr/local/bin/alertmanager
sudo chown -R alertmanager:alertmanager /etc/alertmanage

sudo systemctl daemon-reload
sudo systemctl enable alertmanager
sudo systemctl start alertmanager
