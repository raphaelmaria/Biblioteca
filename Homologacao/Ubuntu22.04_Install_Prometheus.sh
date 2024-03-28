#!/usr/bin/env bash

# Install Prometheus ( https://vegastack.com/tutorials/how-to-install-prometheus-on-ubuntu-22-04/)
sudo apt update

sudo apt -y install wget vim curl tar unzip gzip


sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.51.1/prometheus-2.51.1.linux-amd64.tar.gz
tar xvf prometheus*.tar.gz
cd prometheus*/
sudo mv prometheus promtool /usr/local/bin/
prometheus --version
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo mv consoles/ console_libraries/ /etc/prometheus/
cd $HOME
#sudo vim /etc/prometheus/prometheus.yml
echo "[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/prometheus.service

sudo chmod -R 777 /var/lib/prometheus/
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus
sudo systemctl status prometheus
sudo ufw allow 9090/tcp

echo "ACESSE http://[IP ADDRESS]:9090"

# Install Node Explorer (https://prometheus.io/docs/guides/node-exporter/)
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
cd node_exporter-*.*-amd64
./node_exporter
