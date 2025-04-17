#!/bin/bash

#Variaveis
$VMwareWorkstationPro = "https://www.vmware.com/go/getworkstation-linux"
$REPOSITORYVM = 
$VMwareModules = 

#INICIANDO INSTALACAO DE REQUISITOS
sudo yum -y groupinstall "Development Tools"
sudo yum -y install elfutils-libelf-devel

#INICIANDO DOWNLOAD E INSTALACAO DO VM WARE
xdg-open $VMwareWorkstationPro
sleep 20
cd Downloads/
chmod +x VMware-Workstation-Full-*.*.*-*.x86_64.bundle
sudo ./VMware-Workstation-Full-*.*.*-*.x86_64.bundle

git clone $REPOSITORYVM

#INICIANDO INSTALACAO DE MODULOS
cd /tmp
git clone $REPOSITORYVM
cd 




