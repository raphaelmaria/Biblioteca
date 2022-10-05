#!/usr/bin/env bash
# DEPLOY VMware CARBON BLACK

# VARIVEIS
chaveInstalacao='[ TOKEN ID]'

# REQUISITOS
# FONTE: https://docs.vmware.com/en/VMware-Carbon-Black-Cloud/services/cbc-sensor-installation-guide/GUID-11F7F7A9-9F85-473F-9C09-430F332F8870.html
sudo apt list linux-headers-$(uname -r)
sudo apt -y install linux-headers-$(uname -r)

# FAZENDO DOWNLOAD DO CLIENT ATUALIZADO ATE 09/05/2022 as 11h59
sudo mkdir -p /tmp/vmwareCarbon
cd /tmp/vmwareCarbon/
sudo wget "[ URL DE DOWNLOAD ]"

# PREPARANDO A INSTALACAO
sudo tar -xvf cb-psc-sensor-ubuntu-2.13.1.933911.tar

# INICIANDO INSTALACAO
sudo chmod -R 777 /tmp/vmwareCarbon
sudo /tmp/vmwareCarbon/install.sh -r $chaveInstalacao