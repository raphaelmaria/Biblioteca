#!/bin/sh
# DESCRICAO: Instala uma versão estavel do AWX no CentOS 7 e 8
# SINOPSE: Plataforma que gerencia o Ansible e Playbooks
# USO/EXEMPLO: .\setup.Centos_InstallAWX.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.1.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>
# Fontes:
'''
https://dataunique.com.br/blog/instalando-o-awx-para-gerenciamento-de-playbooks-ansible/
'''

# Variaveis
# Configurar o horario e timezone da maquina
timedatectl set-timezone America/Sao_Paulo

# Instalação de softwares básicos.
yum -y install dialog wget tar unzip vim make gcc epel-release ipa-client
yum -y install net-tools tcpdump nano curl 

##### VARIAVEIS
VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
#VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)

hostnamectl set-hostname $VARHOSTNAME.o2pos.com.br

# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli con up $VARINTERFACE

# Instalação ansible
yum -y install ansible
yum provides pip
yum install python2-pip -y
pip2 install pip --upgrade
pip2 install ansible
pip2 install ansible --upgrade

# Setup de Ansible
wget 
mv /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg_original
wget http://192.168.8.7/app/scripts/ansible/ansible.cfg
mv ansible.cfg /etc/ansible

# Setup de diretorios
mkdir -p /AWXREPO/{role,handlers,vars,meta,host_vars,group_vars,roles,templates,files}
mkdir -p /AWXREPO/role/defaults
mkdir -p /AWXREPO/roles/vars

# Setup de hosts
touch /AWXREPO/hosts
cd /etc/ansible
ln -s hosts /ansible/hosts

# Requisitos para Instalar o AWX Tower Community
yum install -y yum-utils device-mapper-persistent-data lvm2 python-devel python-pip python-docker-py vim-enhanced
yum-config-manager –add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
systemctl start Docker
systemctl enable Docker

# Deploy AWX 
git clone https://github.com/ansible/awx.git
cd awx/
git clone https://github.com/ansible/awx-logos.git
pwd
/root/awx
cd installer/
vim inventory
sed -i 's/^awx_official=false/awx_official=true' inventory
ansible-playbook -i inventory install.yml -vv

