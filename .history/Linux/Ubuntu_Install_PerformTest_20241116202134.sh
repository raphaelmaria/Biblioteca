#!/usr/bin/bash

 for i in $(seq $(getconf _NPROCESSORS_ONLN)); do yes > /dev/null & done
