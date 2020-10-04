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
#VARIAVEIS
GitRepo="https://github.com/raphaelmaria/deploy.git"
AnsibleDIR= "/etc/ansible"
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
    sudo apt -y install dialog wget vim ansible git htop dstat unzip tar gcc python
    cd ~
    git clone $GitRepo
    sudo mv $AnsibleDIR/ansible.conf $AnsibleDIR/ansible.conf.bak
    sudo mv $AnsibleDIR/hosts $AnsibleDIR/hosts.bak
    sudo mv deploy/ansible/ansible.conf $AnsibleDIR
    sudo apt-get install python-pip -y
    sudo pip2 install pip --upgrade
    sudo pip2 install ansible
    sudo pip2 install ansible --upgrade
    sudo touch $AnsibleDIR/hosts

    break ;;

    # Instalacao em Sistema Operacionais RedHat/Centos/yum
    YUM)
    sudo yum update -y
    sudo yum upgrade -y
    sudo yum -y install dialog wget vim ansible git htop dstat unzip tar gcc epel-release python
    cd ~
    git clone $GitRepo
    sudo mv $AnsibleDIR/ansible.conf $AnsibleDIR/ansible.conf.bak
    sudo mv $AnsibleDIR/hosts $AnsibleDIR/hosts.bak
    sudo mv deploy/ansible/ansible.conf $AnsibleDIR
    sudo yum provides pip
    sudo yum install python2-pip -y
    sudo pip2 install pip --upgrade
    sudo pip2 install ansible
    sudo pip2 install ansible --upgrade
    sudo touch $AnsibleDIR/hosts

    
    break ;;
dialog --tittle "Sucesso" --infobox "Operação Concluida com Sucesso" 5 35; sleep 4;
clear
done



