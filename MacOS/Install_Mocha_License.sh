#!/bin/bash
##########
#
# SCRIPT DE INSTALACAO DE LICENCA DO MOCHA PRO FOR ADOBE PLUGIN
# 
# CRIADO POR RAPHAEL MARIA
# EM 02 DE MARCO DE 2020
# VERSAO 1.0

sudo mkdir -p "/Library/Application Support/GenArts/rlm" << EOF
O22013M@c
EOF

cd "/Library/Application Support/GenArts/rlm" 
sudo curl -O http://192.168.8.7/app/plugins/Boris/Mocha2020/Client_Float/floating-client.lic
