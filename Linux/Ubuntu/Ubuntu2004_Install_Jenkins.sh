#!/bin/sh
# Fonte: https://www.jenkins.io/doc/book/installing/linux/#debianubuntu

sudo apt update
sudo apt -y upgrade

# Porta de start, como se muda:
'''
systemctl edit jenkins
'''

sudo apt update
sudo apt install fontconfig openjdk-11-jre

# Aqui inicia a instalação do Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get -y install jenkins

sudo systemctl enable jenkins --now

echo ">_ A Instalação do Jenkins concluida!"