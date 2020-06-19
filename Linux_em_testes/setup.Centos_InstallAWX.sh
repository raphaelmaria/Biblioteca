#!/bin/sh
# DESCRICAO: Instala uma versão estavel do AWX 
# SINOPSE: Plataforma que gerencia o Ansible e Playbooks
# USO/EXEMPLO: .\setup.Centos_InstallAWX.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 0.0.1
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>
# Fontes:
'''
https://dataunique.com.br/blog/instalando-o-awx-para-gerenciamento-de-playbooks-ansible/
'''

# Variaveis

# Deploy AWX 
git clone https://github.com/ansible/awx.git
cd awx/
git clone https://github.com/ansible/awx-logos.git
pwd
/root/awx
cd installer/
vim inventory
sed -i 's/^# DebugLevel=3/DebugLevel=3/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^awx_official=false/awx_official=true' inventory
ansible-playbook -i inventory install.yml -vv