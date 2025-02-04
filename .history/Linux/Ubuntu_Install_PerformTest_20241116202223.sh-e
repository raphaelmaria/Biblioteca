#!/usr/bin/bash

# TESTE DE CPU - YES STRESS TEST
 for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & done


nohup stress --cpu 8 --timeout 60s &
no
