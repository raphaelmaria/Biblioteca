#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt -y install wget apt-transport-https gnupg2 software-properties-common

# Instalando Repositorio e o OpenVAS
sudo add-apt-repository ppa:mrazavi/openvas -y
sudo apt update
#
sudo apt -y install openvas
#
# Configurando o OpenVAS
sudo openvas-nvt-sync
sudo openvas-scapdata-sync



sudo openvas-setup