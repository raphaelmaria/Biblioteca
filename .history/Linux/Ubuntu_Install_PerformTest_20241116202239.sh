#!/usr/bin/bash

sudo apt update
sudo apt 

# TESTE DE CPU - YES STRESS TEST
 for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & done


nohup stress --cpu 8 --timeout 60s &
nohup htop
