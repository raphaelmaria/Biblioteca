#!/bin/sh
#Fonte: https://docs.docker.com/engine/install/ubuntu/
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

#apt-cache madison docker-ce

sudo apt-get install docker-ce=5:20.10.14~3-0~ubuntu-focal docker-ce-cli=5:20.10.14~3-0~ubuntu-focal containerd.io docker-compose-plugin