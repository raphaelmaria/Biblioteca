#!/bin/sh
SERVER_NAME=$(hostname | cut -d' ' -f1)
SERVER_IP=$(hostname -I | cut -d' ' -f1)
DEBIAN_FRONTEND="noninteractive"

# CONFIG DE DB
function db_root() {
  echo "Digite uma senha para o usuário root do banco de dados:"
    read -ers SENHA_dbROOT
  echo "Digite sua senha novamente para confirma:"
    read -ers SENHA_dbROOT1
      if [[ $SENHA_dbROOT != $SENHA_dbROOT1 ]]; then
        echo "Senhas não coincidem, tente novamente." && db_root
      fi
}

# SENHA DB ZABBIX
function db_zabbix() {
  echo "Digite uma senha para o usuário zabbix do banco de dados:"
    read -ers SENHA_dbZABBIX
  echo "Digite sua senha novamente para confirma:"
    read -ers SENHA_dbZABBIX1
      if [[ $SENHA_dbZABBIX != $SENHA_dbZABBIX1 ]]; then
        echo "Senhas não coincidem, tente novamente." && db_zabbix
      fi
}

source /etc/os-release


# Armazenando senha do banco de dados
db_root # Chama a função para digitar a senha de root do banco de dados
sleep 1
db_zabbix # Chama a função para digitar a senha do usuário zabbix do banco de dados
sleep 1

