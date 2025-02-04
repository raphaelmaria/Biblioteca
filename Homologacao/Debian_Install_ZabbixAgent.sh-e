#!/bin/sh
PS1=">_"
##################################
## Script desenvolvido por Raphael Maria
## 
## INSTALACAO DE ZABBIX AGENT EM LINUX
##  
## Criado em 04/12/2019 as 15h23m
## Versao de 1.2
## Alterado em 03 DE MARÇO DE 2020
## Usado na O2 Pos Producoes Ltda.
##
'''
Manual para versão DEBIAN/UBUNTU:
1. Acesse a maquina via SSH com usuário de ROOT
2. Copie e cole a linha abaixo no terminar e logo em seguida pressione o Tecla ENTER

wget http://192.168.8.7/app/scripts/Install_Zabbix_Agent_4.4_Debian.sh

3. Execute o comando: chmod 777 *.sh
4. Execute o comando: chmod +X *.sh
5. Rode a linha de comando (pode copiar a linha abaixo e colocar no terminal):

./Install_Zabbix_Agent_4.4_Debian.sh

6. Aguarde a finalização deste Script
'''
HOST=$(hostname -f)

#echo "Qual o IP do servidor Zabbix: "
#read ZSRV

#Instalação Zabbix
echo "INICIANDO INSTALACAO DO ZABBIX"
echo " AGUARDE O PROCESSO"
service zabbix-agent stop
killall -TERM zabbix_agentd
apt autoremove -y
apt purge zabbix-agent -y
rm -rf /etc/zabbix
rm -rf /var/run/zabbix

apt install zabbix-agent -y
sed -i 's/^Server=127.0.0.1/Server='192.168.8.4'/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^Hostname=Zabbix server/Hostname='$HOST'/' /etc/zabbix/zabbix_agentd.conf
sudo ufw allow proto tcp from 192.168.8.4 to any port 10050

systemctl enable zabbix-agent
systemctl start zabbix-agent
service zabbix-agent restart
echo "INSTALACAO FINALIZADA COM SUCESSO"
echo " "
echo " "
echo "VERIFIQUE SE O SERVICO ESTA ATIVO: "
systemctl status zabbix-agent
