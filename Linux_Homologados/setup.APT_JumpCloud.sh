#!/bin/bash
# Empresa: Loft Tecnologia Ltdas
# Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
# Cargo: Analista de Suporte Pleno
# Versão 0.1
# Criado em 29/10/2020
# Ticket Origem:
# Solicitante:
# Descrição: Instala o Pacotes e a aplicação Jump Cloud em sistemas Linux com gerenciador APT da Familia Debian.
# Código com comentários:
sudo apt upgrade -y && sudo apt update -y
sudo apt -y install dialog ansible vim wget git gcc apt-rdepends apt-show-versions coreutils curl libc-bin lsb-release lsof mawk procps sysvinit-utils tar unzip gdebi-core

sudo apt --fix-broken install

PATRIMONIO=$(dialog --stdout --inputbox 'Insira o numero de PATRIMONIO desta maquina: ' 0 0)
sudo hostnamectl set-hostname LOFT-SPL-$PATRIMONIO

# Pacotes necessários:
sudo apt -y install dialog ansible vim wget git gcc apt-rdepends apt-show-versions coreutils curl libc-bin lsb-release lsof mawk procps sysvinit-utils tar unzip gdebi-core

# Instalacao Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

# Instalacao de Basicos
sudo snap install slack --classic
sudo snap install zoom-client
sudo snap install code --classic

sudo curl --tlsv1.2 --silent --show-error --header 'x-connect-key: ef10c8ee36a34a414100d8c1eb2d93f26464acc5' https://kickstart.jumpcloud.com/Kickstart | sudo bash | dialog -- Title "Instalando Jump Cloud" --gauge "Efetuando Instalacao..." 0 25 50 75 100
echo 'deb http://deb.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/backports.list
apt-get update
sudo apt-get install cockpit