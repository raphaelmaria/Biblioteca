#!/bin/sh
'''
Link de Como instalar o Docker: https://phoenixnap.com/kb/install-docker-on-ubuntu-20-04

'''

sudo apt update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
sudo apt update
sudo apt-get install docker-ce

# Configurando o System.d para iniciar o Docker no Boot da maquina
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

# Adicionando User como SUDO para Docker
sudo groupadd docker
sudo usermod -aG docker $whoami
su - $whoami

# Instalar o Docker do Couch Potato para baixar filmes
sudo mkdir /opt/couchpotato
docker pull couchpotato/couchpotato
docker run couchpotato -v <datadir path>:/datadir -v <media path>:/multimidia/movies -p 5050:5050 couchpotato/couchpotato

# Instalar o Docker do Sickrage para baixar series
sudo mkdir /opt/sickrage
docker pull sickrage/sickrage
docker run -d --name="sickrage" -v /path/to/sickrage/data:/data -v /path/to/downloads:/temp -v /path/to/tv:/multimidia/tv -v /path/to/anime:/multimidia/anime -v /path/to/series:/multimidia/series -e TZ=Canada/Pacific -p 8081:8081 sickrage/sickrage:latest
