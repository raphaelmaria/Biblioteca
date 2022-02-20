#!/bin/bash
# Empresa: O2 Pos Producoes Ltda
# Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
# Cargo: Administrador de Redes
# Versão 0.1
# Criado em 08/10/2020
# Ticket Origem: 
# Solicitante: Paulo Barcellos
# Descrição: Executa a instalação do Tableau
# Código com comentários:

'''
Instalacao homologado para rodar em um VM com as seguintes caracteristicas:
OS: Linux CentOS 7
Disco: IDE - 200 Gb
Memoria: 16 GB
de CPU: 8:1:1
Placa de rede: VirtIO - 10000 Gbps
Hypervisor: Ovirt OpenSource

INSTALL GUIDE: https://help.tableau.com/current/server-linux/pt-br/setup.htm
PAG. DOWNLOAD: https://www.tableau.com/support/releases/server/
'''

# INSTALANDO REQUISITOS
yum -y install dialog wget tar unzip vim make gcc dnf epel-release
yum -y install net-tools tcpdump nano curl 

# VARIAVEIS
tableauversion=$(dialog --inputbox --stdout "Entre com a versão atual presente no site 'https://www.tableau.com/support/releases/server/' separada por "-":" 30 5 ;)

sudo yum check-update
sudo yum update -y
#sudo yum install httpd
#systemctl enable httpd
#systemctl start httpd


mkdir /tmp/tableau
cd /tmp/tableau
wget https://downloads.tableau.com/esdalt/2020.3.1/tableau-server-$tableauversion.x86_64.rpm
#https://downloads.tableau.com/esdalt/2020.3.1/tableau-server-2020-3-1.x86_64.rpm
sudo yum install tableau-server-$tableauversion.x86_64.rpm
useradd admin
passwd admin << EOF
admin   
admin
EOF


sudo /opt/tableau/tableau_server/packages/scripts.$tableauversion/initialize-tsm --accepteula -a admin -p admin


