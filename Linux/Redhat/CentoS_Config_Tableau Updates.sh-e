#!/bin/bash
# Empresa: O2 Pos Producoes Ltda
# Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
# Cargo: Administrador de Redes
# Versão 2020.3.1
# Criado em 08/10/2020
# Ticket Origem: 
# Solicitante: Paulo Barcellos
# Descrição: Executa a instalação do Tableau
# Código com comentários:
'''
UPDATE GUIDE: https://help.tableau.com/current/server-linux/pt-br/server-upgrade-baseline-singlenode-setup.htm
PAG. DOWNLOAD: https://www.tableau.com/support/releases/server/
'''
# INSTALANDO REQUISITOS
yum -y install dialog wget tar unzip vim make gcc dnf epel-release
yum -y install net-tools tcpdump nano curl 

# VARIAVEIS
tableauversion=$(dialog --inputbox --stdout "Entre com a versão atual presente no site 'https://www.tableau.com/support/releases/server/':" 30 0 ;)

# 
tsm maintenance backup -f <backup_file> -d
sudo yum update -y
wget https://downloads.tableau.com/esdalt/2020.3.1/tableau-server-$tableauversion.x86_64.rpm
sudo yum install tableau-server-$tableauversion.x86_64.rpm
sudo /opt/tableau/tableau_server/packages/scripts.$tableauversion/upgrade-tsm --accepteula
tsm start

echo "@reboot root tsm start" >> /etc/crontab
