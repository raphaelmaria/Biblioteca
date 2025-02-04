#!/usr/bin/env bash

varCylance="[URL PARA DOWNLOAD]"
varOptics="[URL PARA DOWNLOAD]"

# PRE REQUISITOS
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get -y install libxml2-utils make gcc bzip2 linux-headers-generic curl vim gnome-tweak-tool
sudo apt -y autoremove


sudo mkdir -p /opt/cylance
sudo mkdir -p /tmp/cylance
sudo echo InstallToken=[TOKEN] > /opt/cylance/config_defaults.txt
sudo echo SelfProtectionLevel=2 >> /opt/cylance/config_defaults.txt
sudo echo VenueZone="[NOME DO TENANT]" >> /opt/cylance/config_defaults.txt
sudo echo LogLevel=2 >> /opt/cylance/config_defaults.txt
sudo add-apt-repository universe

# INICIA O DOWNLOAD
cd /tmp/cylance
sudo curl -O $varCylance 
sudo curl -O $varOptics

# EFETUAR A INSTALACAO, SUBSTITUA A VERSÃO DESCRITA ABAIXO
sudo tar -xvzf cylance-protect.ubuntu2004.tar
sudo dpkg -i /tmp/cylance/cylance-optics_2.5.3000.8502-release_amd64.deb
sudo dpkg -i /tmp/cylance/cylance-protect-open-driver_3.0.1000.2911_amd64.deb
sudo dpkg -i /tmp/cylance/cylance-protect-driver_3.0.1000.2911_amd64
sudo dpkg -i /tmp/cylance/cylance-protect.deb
sudo dpkg -i /tmp/cylance/cylance-protect-ui.deb
dpkg --configure -a
apt-get update
apt-get -y install -f
apt-get -y autoremove


