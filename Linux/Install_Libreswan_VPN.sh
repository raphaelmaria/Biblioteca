#!/bin/sh
#
# Instalacao pacote L2TP para uso da VPN no Fedora
# Criado por Raphael Maria em 07 de Novembro de 2019
# versao 1.0 testada

apt-get -y install epel-release
apt-get -y install NetworkManager-l2tp-gnome
reboot