#!/bin/sh
# Fonte de estudo: https://cockpit-project.org/running#debian
# 
PS1=">_"
echo 'deb http://deb.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/backports.list
apt-get update
sudo apt-get install cockpit

