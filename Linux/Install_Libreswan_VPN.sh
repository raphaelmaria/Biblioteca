#!/bin/sh
#
# Instalacao pacote L2TP para uso da VPN no Fedora
# Criado por Raphael Maria em 07 de Novembro de 2019
# versao 1.0 testada

yum -y install epel-release
yum -y install NetworkManager-l2tp-gnome
reboot