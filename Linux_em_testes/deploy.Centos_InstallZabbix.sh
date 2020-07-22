#!/bin/sh
# DESCRICAO: EFETUADO INSTALAÇÃO DO STORAGE EM SAMBA COM IPA
# SINOPSE: 
# USO/EXEMPLO: .\Install_SFZ.sh
#
# OPCOES: NÃO POSSUI OPÇÃO
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>


######### INSTALAÇÃO ZABBIX VIA DOCKER
timedatectl set-timezone America/Sao_Paulo

# Instalação de softwares básicos.
yum -y install dialog wget tar unzip vim make gcc dnf epel-release ipa-client
yum -y install net-tools tcpdump nano curl 

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)

hostnamectl set-hostname $VARHOSTNAME
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli con up $VARINTERFACE

# Instalação do Ansible
yum -y install ansible  epel-release
yum provides pip
yum install python2-pip -y
pip2 install pip --upgrade
pip2 install ansible
pip2 install ansible --upgrade

# Setup SELINUX
setenforce 0
getenforce
sestatus

# 
# https://download.docker.com/linux/centos/7/x86_64/stable/Packages/
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf clean all
dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
dnf install -y docker-ce 
systemctl enable -now docker-ce

docker swarm init
docker container ls
docker node ls
docker node update --availability drain [host]
docker network rm ingress
docker network create \
--driver overlay \
--subnet=192.168.0.0/16 \
--gateway=192.168.8.1 \
--opt com.docker.network.driver.mtu=1500 \
ingress

docker node ls


firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd reload

zabbix-get -s [ip] -p 10050 -k "name"





