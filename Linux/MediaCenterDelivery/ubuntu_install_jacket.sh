#!/usr/bin/env bash

cd /tmp
wget https://github.com/Jackett/Jackett/releases/download/v0.20.3366/Jackett.Binaries.LinuxAMDx64.tar.gz
tar -xf Jackett.Binaries.LinuxAMDx64.tar.gz -C /opt/jackett
cd /opt/jackett
sudo ./install_service_systemd.sh
sudo systemctl enable jackett.service
sudo systemctl start jackett.service