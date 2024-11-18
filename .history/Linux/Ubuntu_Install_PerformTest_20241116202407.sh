#!/usr/bin/bash

sudo apt update
sudo apt -y install htop

# TESTE DE CPU - YES STRESS TEST
 for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & done

sleep 1800s



nohup stress --cpu 8 --timeout 60s &
nohup htop

