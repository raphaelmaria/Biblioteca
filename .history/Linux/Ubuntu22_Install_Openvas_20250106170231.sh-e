#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt -y install wget apt-transport-https gnupg2 software-properties-common

# Instalando Repositorio e o OpenVAS
sudo add-apt-repository ppa:mrazavi/gvm -y
sudo apt update
#
sudo apt -y install postgresql gvm
#
# Configurando o OpenVAS
sudo apt -y autoremove
sudo mkddir /var/lib/notus
sudo chown gvm:gvm /var/lib/notus
sudo -u gvm -g gvm greenbone-nvt-sync




sudo openvas-setup