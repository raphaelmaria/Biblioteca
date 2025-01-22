#!/bin/sh  
# Script de Instalacao
# Python 2.7.16
# Solicitante: Marcelo Ferreira no Ticket 1999
###
#####
# Scritpt criado por Raphael Alan de Oliveira Maria
# Em 10 de Julho de 2019
# versao 0.1
# Fonte de pesquisa:
# https://tecadmin.net/install-python-2-7-on-centos-rhel/

apt-get install gcc openssl-devel bzip2-devel 
cd /usr/src
wget https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz
tar xzf Python-2.7.16.tgz
cd Python-2.7.16
./configure --enable-optimizations
make altinstall
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python2.7 get-pip.py