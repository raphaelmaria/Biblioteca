#!/bin/bash
# Script para instalação do Autodesk Maya 2017 Service Pack 5
# Criado por Raphael Maria
# Versão 1.0
# Data de 25 de Março de 2019

echo "Iniciando processo de Instalação Local"

umount -a

echo "removendo arquivos do maya instalado"
rpm -qa | egrep "adlm|Maya"
rpm -e adlmflexnetserver-12.0.34-0.x86_64
rpm -e adlmflexnetclient-12.0.32-0.x86_64
rpm -e Maya2017_64-2017.0-1720.x86_64
rpm -e mentalrayForMaya2015_0-2015.0-19.x86_64
rpm -e adlmapps9-9.0.23-0.x86_64
rpm -e adlmapps12 
rpm -e Maya2015_64 
rpm -e adlmapps12 
rpm -qa |egrep 'adlm|Maya'
rm -rf /usr/autodesk
rm -rf /usr/autodesk.disabled


echo "Número de série / chave"
echo "561-74540031 / 657I1"

export LD_LIBRARY_PATH=/opt/Autodesk/Adlm/R14/lib64/
cd /root/Downloads
wget http://192.168.8.7/app/Autodesk_Maya_2017_EN_JP_ZH_Linux_64bit.tgz
tar -xvf Autodesk_Maya_2017_EN_JP_ZH_Linux_64bit.tgz
./setup
rm -rf *
wget http://192.168.8.7/app/Autodesk_Maya_2017_Update5_Linux_64bit.tgz
tar -xvf Autodesk_Maya_2017_Update5_Linux_64bit.tgz
./setup
rm -rf *
ls