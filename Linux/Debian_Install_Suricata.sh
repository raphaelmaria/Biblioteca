#!/usr/bin/env bash

echo "deb http://deb.debian.org/debian bullseye-blackports main" > /etc/apt/source.list.d/backports.list

sudo apt update

sudo apt -y install suricata suricata-update -t bullseye-backports
