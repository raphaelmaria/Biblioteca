#!/bin/sh

# Registrar o Ubuntu PRO
sudo pro attach C12wuWBwsaqFpf636EhNB61H9wkmQy

# Aplicativos Essenciais
sudo apt-add-repository universe
sudo apt update
sudp apt upgrade -y

sudo apt install python2-minimal
sudo apt -y install vim git terminator glances gcc unzip wget dkms git vim ansible curl openssh-server make
sudo apt -y install arqiver tar unzip dialog vim wget git gcc sshpass xz-utils
sudo apt -y install gpg curl dnsutils net-tools software-properties-common python-minimal
sudo apt-get -y install build-essential debhelper bison check cmake flex groff libbsd-dev \
      libcurl4-openssl-dev libmaxminddb-dev libgtk-3-dev libltdl-dev libluajit-5.1-dev \
      libncurses5-dev libnet1-dev libpcap-dev libpcre2-dev libssl-dev

sudo apt autoremove -y
sudo apt clean
export FONTCONFIG_PATH=/etc/fonts

# Adicionando Repo Kali no Ubuntu
wget -q -O - archive.kali.org/archive-key.asc | sudo  apt-key add
sudo apt update
cd ~/Downloads
sudo git clone https://github.com/LionSec/katoolin.git
sudo cp katoolin/katoolin.py /usr/bin/katoolin
sudo chmod +x /usr/bin/katoolin
sudo katoolin
