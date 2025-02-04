#!/bin/sh
# DESCRICAO: Instala de maneira estavel o Docker
# SINOPSE: Instala os requisitos e configurar o docker na maquina
# USO/EXEMPLO: .\setup.Centos_InstallDocker.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>

# Variaveis

# Deploy Install Docker
yum install -y epel-release
yum install -y yum-utils device-mapper-persistent-data lvm2 ansible git python-devel python-pip python-docker-py vim-enhanced
yum-config-manager –add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
systemctl start Docker
systemctl enable Docker
