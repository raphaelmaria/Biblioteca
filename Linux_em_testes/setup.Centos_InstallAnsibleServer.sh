#!/bin/bash
# DESCRICAO: Instalação automatizada do Ansible como Servidor. 
# SINOPSE: Responsavel por enviar os comandos ansible as demais maquinas.
# USO/EXEMPLO: .\setup.Centos_InstallAnsibleServer.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>
# Fontes:
'''
https://dataunique.com.br/blog/instalando-o-awx-para-gerenciamento-de-playbooks-ansible/
'''

# Instalação ansible
yum -y install ansible  epel-release
yum provides pip
yum install python2-pip -y
pip install pip --upgrade
pip install ansible
pip install ansible --upgrade

# Setup de Ansible
wget 
mv /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg_original
wget http://192.168.8.7/app/scripts/ansible/ansible.cfg
mv ansible.cfg /etc/ansible
mv /etc/ansible/hosts /etc/ansible/hosts_original

# Setup de diretorios
mkdir /AnsibleRepo/common/{tasks, handlers,files,templates,vars,defaults,meta} -p

# Setup de hosts
touch /AnsibleRepo/hosts
cd /etc/ansible
ln -s hosts /AnsibleRepo/hosts
