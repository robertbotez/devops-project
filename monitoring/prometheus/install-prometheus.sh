#!/bin/bash

sudo useradd --no-create-home prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz
tar -xvf prometheus-2.30.3.linux-amd64.tar.gz

sudo cp prometheus-2.30.3.linux-amd64/prometheus /usr/local/bin
sudo cp prometheus-2.30.3.linux-amd64/promtool /usr/local/bin
sudo cp -r prometheus-2.30.3.linux-amd64/consoles /etc/prometheus/
sudo cp -r prometheus-2.30.3.linux-amd64/console_libraries /etc/prometheus
sudo cp prometheus-2.30.3.linux-amd64/promtool /usr/local/bin/

sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus/



