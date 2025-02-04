#!/bin/sh
sudo apt-get install python3-dev python3-pip python3-distutils wget vim
cd /tmp
wget https://github.com/morpheus65535/bazarr/releases/latest/download/bazarr.zip
sudo unzip bazarr.zip -d /opt/bazarr
cd /opt/bazarr
python3 -m pip install -r requirements.txt
sudo chown -R  root:root /opt/bazarr

# Criar Service para iniciar automaticamente com a maquina
echo"[Unit]
Description=Bazarr Daemon
After=syslog.target network.target

# After=syslog.target network.target sonarr.service radarr.service

[Service]
WorkingDirectory=/opt/bazarr/
User=root
Group=root
UMask=0002
Restart=on-failure
RestartSec=5
Type=simple
ExecStart=/usr/bin/python3 /opt/bazarr/bazarr.py
KillSignal=SIGINT
TimeoutStopSec=20
SyslogIdentifier=bazarr
ExecStartPre=/bin/sleep 30

[Install]
WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/bazarr.service

sudo systemctl daemon-reload
sudo systemctl enable bazarr.service
sudo systemctl start bazarr.service
