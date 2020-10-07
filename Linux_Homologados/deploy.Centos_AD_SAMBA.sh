#!/bin/sh
# Script de configuração de servidor Active Directory com SAMBA
# Criado por Raphael Maria
# Em 20 de Dezembro de 2019
# Versao 1.0

'''
Requisitos - Maquinas Fisica
>> Processador:
>> Memoria:
>> HD:

Requisitos - Maquina Virtual
>> Processador:
>> Memoria:
>> HD:
'''
# variaveis e Chaves Fixas

VARREDE=$(nmcli con show | tail -1 | awk '{print $1,$2,$3}')
VARIP=$(dialog --stdout --inputbox "Insira o IP ESTATICO: " 0 0)
VARMASK=$(dialog --stdout --inputbox "Insira a sub-rede: " 0 0)
VARGTW=$(dialog --stdout --inputbox "Insita o Gateway Router: " 0 0 )
VARDOMAIN=$(dialog --stdout --inputbox "Insira do Dominio: " 0 0)

# CONFIGURANDO A REDE DA MAQUINA
nmcli con modify $VARREDE ipv4.method manual ipv4.addresses $VARIP/$VARMASK ipv4.gateway $VARGTW ipv4.dns 8.8.8.8,8.8.4.4
nmcli con up $VARREDE

# Escrevendo um novo repositorio
echo"
[tis-samba]
name=tis-samba
baseurl=http://samba.traquil.it/centos7/stable
gpgcheck=0" >> /etc/yum.repos.d/tissamba.repos

# Rodando UPDATE
yum update -y
yum upgrade -y


# Pacotes
yum install samba samba-winbind samba-winbind-clients samba-client krb5-workstation samba-tools -y

# CONFIGURANDO DOMINIO
mv /etc/krb5.conf /etc/krb5.conf.bkp
 echo "[libedefaults]
  dns_lookup_realm = false
  dns_lookup_kdc = true
  ....
  default_realm = $VARDOMAIN"

mv /etc/samba/smb.conf /etc/samba/smb.conf.bkp

samba-tools domain provision --realm="$VARDOMAIN" --DOMAIN "$VARDOMAIN" -server-role=dc

samba-tool user setpassword administrator
