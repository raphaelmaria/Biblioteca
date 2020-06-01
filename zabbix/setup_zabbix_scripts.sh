#!/bin/sh
# INSTALACAO DE LIBRARY PARA ZABBIX
# VERSAO ZABBIX 4.4
# CRIADO POR RAPHAEL MARIA.
# EM 01 DE JUNHO DE 2020.
# VERSAO 1.0

git clone https://github.com/raphaelmaria/deploy
cd deploy/zabbix
chmod 0755 script/*.sh
mv script/*  /usr/local/bin
mv userparameter/*  /etc/zabbix/zabbix_agentd.d