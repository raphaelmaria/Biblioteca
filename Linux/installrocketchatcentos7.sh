#!/bin/sh
# Script de instalacao das VMs Rocket Chat.
# Baseado em CentOS 7
# Criado e documentado por Raphael Maria
# Em 18 de Maio de 2020
# Fonte: https://tidahora.com.br/instalando-o-rocket-chat-no-centos-7/
################################################################
##### VARIAVEIS ################################################

sed -i "s/^SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
systemctl disable firewalld
reboot

yum -y update
yum -y install epel-release
yum -y install vim htop wget curl make gcc g++ gcc-c++ libgcc

cat << EOF | sudo tee -a /etc/yum.repos.d/mongodb-org-4.0.repo
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
EOF

yum -y install mongodb-org nodejs

curl -sL https://rpm.nodesource.com/setup_8.x