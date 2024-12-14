#!/usr/bin/bash

# TESTE DE CPU - YES 
 for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & done
