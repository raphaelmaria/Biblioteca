#!/bin/sh
# DESCRICAO: Instalador do Jitsi Meet
# SINOPSE: Script faz a instalacaodo Jitsi e seu prerequisitos na maquina.
# USO/EXEMPLO: .\install_jitsi_ubuntu18lts.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>
#################################################################
# Variaveis
DOMAIN=o2pos.com.br
HOSTNAME=meet
VARIP=192.168.8.68
GATEWAY=192.168.8.1
DNS1=192.168.8.100
DNS2=192.168.8.110
#################################################################
sudo hostnamectl set-hostname $HOSTNAME.$DOMAIN
sudo echo "127.0.0.1 localhost $HOSTNAME.$DOMAIN" >> /etc/hosts

nmcli con show
echo "Qual a placa de rede?"
read varinterface

nmcli con modify $varinterface ipv4.method manual ipv4.addresses $VARIP/16 ipv4.gateway $GATEWAY ipv4.dns $DNS1,$DNS2 ipv4.dns-search $DOMAIN
nmcli con up $varinterface
# Required packages and repository updates
echo "Required packages and repository updates"
sudo apt update
sudo apt -y install apt-transport-https nginx
sudo apt-add-repository universe
sudo apt list --upgradable
sudo apt upgrade -y

curl https://download.jitsi.org/jitsi-key.gpg.key | sudo sh -c 'gpg --dearmor > /usr/share/keyrings/jitsi-keyring.gpg'
echo 'deb [signed-by=/usr/share/keyrings/jitsi-keyring.gpg] https://download.jitsi.org stable/' | sudo tee /etc/apt/sources.list.d/jitsi-stable.list > /dev/null
sudo apt update

# Firewall - ACLs
echo "Configurando Portas de Firewall"
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 4443/tcp
sudo ufw allow 10000/udp
sudo ufw allow 22/tcp
sudo ufw enable
sudo ufw status verbose

# Basic Jitsi Meet install
echo "Basic Jitsi Meet install"
#wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | sudo apt-key add -
#sudo sh -c "echo 'deb https://download.jitsi.org stable/' > /etc/apt/sources.list.d/jitsi-stable.list"
#sudo apt-get -y update
#sudo apt-get -y install jitsi-meet
#sudo apt-get -y install jitsi-videobridge
#sudo apt-get -y install jicofo
#sudo apt-get -y install jigasi
sudo apt -y install jitsi-meet
sudo /usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh
sudo apt install jigasi

systemctl show --property DefaultLimitNPROC
systemctl show --property DefaultLimitNOFILE
systemctl show --property DefaultTasksMax