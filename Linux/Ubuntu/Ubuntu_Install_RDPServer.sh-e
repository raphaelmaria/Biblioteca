#!/bin/bash

sudo apt update
sudo apt autoclean
sudo apt upgrade -y
sudo apt upgrade --fix-missing
sudo apt install --fix-broken

sudo apt -y install xfce4 xfce4-goodies xrdp
cd ~
echo "xfce4-session" | tee .xsession
sudo systemctl start xrdp
sudo systemctl enable xrdp
sudo reboot