#!/usr/bin/bash

sudo apt update
sudo apt -y install htop stress memtester 

# TESTE DE CPU - YES STRESS TEST
 for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & done
echo 'TESTE FINALIZADO'


nohup stress --cpu 8 
nohup htop
sleep 1800s

echo 'TESTE CPU DE 30 MINUTOS FINALIZADO'



echo 'TESTE CPU DE 30 MINUTOS FINALIZADO'

pip install s-tui --user

VARMEMORY=$(dialog --stdout --inputbox 'Insira o tamanho da MEMORIA: ' 0 0)
sudo memtester $VARMEMORY 


