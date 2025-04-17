#!/bin/sh
# DESCRICAO: Instalador do Jitsi Meet
# SINOPSE: Script faz a instalacaodo Jitsi e seu prerequisitos na maquina.
# USO/EXEMPLO: .\install_jitsi_ubuntu18lts.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>
# FONTE: https://www.osradar.com/how-to-install-glpi-on-debian-10-buster/

#REQUISITOS
# TYPE: VIRTUAL MACHINE
# OS: Debian 8 / 9
# PROCESSADORES: 2 NUCLEOS
# MEMORIA: 4096 MB
# NETWORK: 1000 Gbps
# STORAGE: DISK #1 30GB / DISK #2 500GB

'''
https://jitsi.github.io/handbook/docs/devops-guide/devops-guide-quickstart
https://jitsi.org/downloads/ubuntu-debian-installations-instructions/
'''
#################################################################
# Instalação de softwares básicos.
apt -y install dialog wget tar unzip vim make gcc dnf autoconf automake

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)

hostnamectl set-hostname $VARHOSTNAME.o2pos.com.br

# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli con up $VARINTERFACE

# Instala o Dashboard WEB Red Hat Cockpit
echo 'deb http://deb.debian.org/debian stretch-backports main' > \
 /etc/apt/sources.list.d/backports.list

apt-get update -y
apt-get install cockpit
systemctl enable --now cockpit.socket

# Fazendo update de todo os sistema operacional
apt -y upgrade
apt -y update


dialog --msgbox "Sua configuração iniciar foi concluida \nAcesse este dispositivo através do endereço \nhttps://$VARIPADDRESS:9090  \nusando o usuário de logado desta sessão do shell" 0 0

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
sudo apt -y install jitsi-meet
sudo /usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh
sudo mv /etc/jitsi/videobridge/sip-communicator.properties /etc/jitsi/videobridge/sip-communicator.properties.bkps
sudo cat << EOF | see -t /etc/jitsi/videobridge/sip-communicator.properties
org.ice4j.ice.harvest.NAT_HARVESTER_LOCAL_ADDRESS='$VARIP'
org.ice4j.ice.harvest.NAT_HARVESTER_PUBLIC_ADDRESS="VARWAN"
org.ice4j.ice.harvest.DISABLE_AWS_HARVESTER=true
#org.ice4j.ice.harvest.STUN_MAPPING_HARVESTER_ADDRESSES=meet-jit-si-turnrelay.jitsi.net:443
org.jitsi.videobridge.ENABLE_STATISTICS=true
org.jitsi.videobridge.STATISTICS_TRANSPORT=muc
org.jitsi.videobridge.xmpp.user.shard.HOSTNAME=localhost
org.jitsi.videobridge.xmpp.user.shard.DOMAIN=auth.meet.o2pos.com.br
org.jitsi.videobridge.xmpp.user.shard.USERNAME=jvb
org.jitsi.videobridge.xmpp.user.shard.PASSWORD=QVCA2Np2
org.jitsi.videobridge.xmpp.user.shard.MUC_JIDS=JvbBrewery@internal.auth.meet.o2pos.com.br
org.jitsi.videobridge.xmpp.user.shard.MUC_NICKNAME=57380cc9-6346-4545-9bb4-e17a3a54e105
EOF

sed -i 's/^#DefaultLimitNOFILE=/#DefaultLimitNOFILE=65000' /etc/systemd/system.conf 
sed -i 's/^#DefaultLimitNPROC=/#DefaultLimitNPROC=65000' /etc/systemd/system.conf
sed -i 's/^#DefaultTasksMax=/#DefaultTasksMax=65000' /etc/systemd/system.conf
 
sudo apt install jigasi

systemctl show --property DefaultLimitNPROC
systemctl show --property DefaultLimitNOFILE
systemctl show --property DefaultTasksMax