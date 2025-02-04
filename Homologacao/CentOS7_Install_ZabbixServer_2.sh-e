#!/bin/bash
# Empresa: 
# Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
# Cargo: Administrador de Redes
# Versão 0.1
# Criado em 06/01/2021
# Ticket Origem:
# Solicitante:
# Descrição:
# Código com comentários:

#
vim /etc/selinux/config
# Mude SELINUX=disabled
setenforce 0
systemctl disable firewalld
systemctl stop firewalld
yum install -y vim wget epel-release
rpm -i https://repo.zabbix.com/zabbix/5.2/rhel/7/x86_64/zabbix-release-5.2-1.el7.noarch.rpm 