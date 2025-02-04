#!/bin/sh

# Instalação de Repositorio
sudo apt-get install software-properties-common wget
sudo add-apt-repository universe
wget https://packages.ntop.org/apt-stable/22.04/all/apt-ntop-stable.deb
sudo apt -y install ./apt-ntop-stable.deb

# Instalação de NTOP-ng
sudo apt-get clean all
sudo apt-get update
sudo apt-get -y install pfring-dkms nprobe ntopng n2disk cento

# Instalação de pacote complementar
sudo apt-get -y install pfring-drivers-zc-dkms
sudo apt-get -y install nedge

sudo apt-get update
sudo apt-get upgrade -y

sudo systemctl enable ntopng.service --now

