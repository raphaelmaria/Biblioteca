#!/usr/bin/env bash

# REFERENCIA: https://www.youtube.com/watch?v=7gW5pSM6dlU
# Install Prometheus ( https://vegastack.com/tutorials/how-to-install-prometheus-on-ubuntu-22-04/)
sudo apt update

sudo apt -y install wget vim curl tar unzip gzip apache2


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
cat > /etc/systemd/system/prometheus.service << EOF
[Unit]
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
WantedBy=multi-user.target
EOF

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
sudo cp node_exporter /usr/local/bin/
echo"[Init]
Description=Prometheus Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/node-exporter.service
sudo systemctl   daemon-reload
sudo systemctl start node-exporter.service
sudo systemctl enable node-exporter.service



wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.12.0/blackbox_exporter-0.12.0.linux-amd64.tar.gz
tar -xzf blackbox_exporter-*.linux-amd64.tar.gz
cd blackbox_exporter-*
sudo cp blackbox_exporter /usr/local/bin/
cat << 'EOF' >  /usr/local/bin/blackbox/blackbox.yml
modules:
  dns_rp_mx:
    prober: dns
    dns:
      query_name: "robustperception.io"
      query_type: "MX"
      validate_answer_rrs:
        fail_if_not_matches_regexp:
         - "robustperception.io.\t.*\tIN\tMX\t.*google.*"
EOF


cat << 'EOF'> /etc/systemd/system/blackbox_exporter.service
[Init]
Description=blackbox_exporter
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/blackbox/blackbox_exporter

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl   daemon-reload
sudo systemctl start blackbox_exporter.service
sudo systemctl enable blackbox_exporter.service

# Alert_Manager
wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
tar xvf alertmanager-0.27.0.linux-amd64.tar.gz
cd alertmanager-*/
cp -r . /usr/local/bin/alertmanager/
cat > /etc/systemd/system/alertmanager.service << EOF
[Init]
Description=Prometheus Alert Manager
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/alertmanager/alertmanager --config.file=/usr/local/bin/alertmanager/alertmanager.yml

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start alertmanager.service
sudo systemctl enable alertmanager.service