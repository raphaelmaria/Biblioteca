#!/usr/bin/bash

sudo apt update
sudo apt -y install htop

# TESTE DE CPU - YES STRESS TEST
 for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & done

sleep 1800s

echo 'TESTE CPU DE 30 MINUTOS FINALIZADO'



echo 'TESTE CPU DE 30 MINUTOS FINALIZADO
