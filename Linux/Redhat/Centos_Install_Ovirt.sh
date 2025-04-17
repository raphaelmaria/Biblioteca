#!/bin/bash

# Script de instalação interativo do oVirt

# Define cores para saída do terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]
  then echo -e "${RED}Por favor, execute como root ou com sudo.${NC}"
  exit
fi

# Define algumas variáveis para uso posterior
OVRT_ENGINE_PASS=""
HOST_FQDN=""
EMAIL_ADDR=""
SMTP_HOST=""
SMTP_PORT=""
SMTP_USER=""
SMTP_PASS=""
IS_FIREWALLD_INSTALLED=$(systemctl is-enabled firewalld &> /dev/null && echo true || echo false)

# Função para validar entrada de e-mail
function validate_email {
  local email="$1"
  if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
  then
    echo -e "${RED}Endereço de e-mail inválido. Por favor, tente novamente.${NC}"
    return 1
  fi
}

# Função para validar entrada de porta SMTP
function validate_smtp_port {
  local port="$1"
  if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]
  then
    echo -e "${RED}Porta inválida. Por favor, tente novamente.${NC}"
    return 1
  fi
}

# Função para validar entrada de senha SMTP
function validate_smtp_pass {
  local pass="$1"
  if [ -z "$pass" ]
  then
    echo -e "${RED}Senha não pode estar vazia. Por favor, tente novamente.${NC}"
    return 1
  fi
}

# Função para validar entrada de senha do engine
function validate_ovrt_engine_pass {
  local pass="$1"
  if [ -z "$pass" ]
  then
    echo -e "${RED}Senha não pode estar vazia. Por favor, tente novamente.${NC}"
    return 1
  fi
}

# Verifica se o hostname está definido corretamente
while [ -z "$HOST_FQDN" ]
do
  read -p "Por favor, insira o FQDN do host oVirt: " HOST_FQDN
done

# Verifica se o endereço de e-mail do administrador está definido corretamente
while [ -z "$EMAIL_ADDR" ] || ! validate_email "$EMAIL_ADDR"
do
  read -p "Por favor, insira o endereço de e-mail do administrador: " EMAIL_ADDR
done

# Verifica se o firewall está habilitado e abre as portas necessárias
if [ "$IS_FIREWALLD_INSTALLED" = true ]
then
  firewall-cmd --add-port=80/tcp --add-port=443/tcp --permanent &> /dev/null
  firewall-cmd --reload &> /dev/null
fi

# Instala os pacotes necessários para o oVirt
yum -y install https://resources.ovirt.org/pub/yum-repo/ovirt-release44.rpm &> /dev/null
yum -y install ovirt-engine &> /dev/null

# Define a senha
