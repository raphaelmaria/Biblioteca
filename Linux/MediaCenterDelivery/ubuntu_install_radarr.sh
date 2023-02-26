#!/usr/bin/env bash
sudo apt install curl sqlite3
cd /tmp
wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
tar -xvzf Radarr*.linux*.tar.gz
sudo mv Radarr /opt/
sudo chown root:root -R /opt/Radarr

cat << EOF | sudo tee /etc/systemd/system/radarr.service > /dev/null
[Unit]
Description=Radarr Daemon
After=syslog.target network.target
[Service]
User=root
Group=root
Type=simple

ExecStart=/opt/Radarr/Radarr -nobrowser -data=/var/lib/radarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl -q daemon-reload
sudo systemctl enable --now -q radarr
