#!/bin/sh
# DESCRICAO: Instalação e Configuração de Ansible de Forma Automatizada
# SINOPSE:
# USO/EXEMPLO: ./Setup_Ansible.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>
# FONTE:
# 
#####################################################################
clear
PS3="> Selecione o gerenciador de pacote do seu OS:"
select OS APT YUM; do
echo "Instalacao e Configuracao de Ansible Server"
case $OS in
    # Instalacao em Sistema Operacionais Debian/Ubuntu/apt
    APT)
    sudo apt upgrade -y
    sudo apt update -y
    sudo apt -y install wget vim ansible git htop dstat unzip tar gcc
    cd ~
    git clone 
    break ;;

    # Instalacao em Sistema Operacionais RedHat/Centos/yum
    YUM)
    sudo yum update -y
    sudo yum upgrade -y
    sudo yum -y install wget vim ansible git htop dstat unzip tar gcc epel-release
    
    break ;;
done



