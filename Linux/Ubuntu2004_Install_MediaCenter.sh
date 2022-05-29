#!/bin/sh

'''
Instalacao do essenciais
'''
sudo apt install dialog tree wget tar unzip vim make gcc autoconf automake git -y
sudo apt autoremove
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install build-essential checkinstall -y
sudo apt-get install software-properties-common -y
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y
sudo apt-get install python3-pip -y
sudo apt-get install build-essential python-dev git scons swig -y
sudo apt-get install python3-pip python3-setuptools python3-psutil python3-bottle python3-requests -y
sudo apt-get install python3-pip -y
pip install --no-deps -U news-please

# LXML (link: https://lxml.de/installation.html)
sudo apt autoremove
sudo apt-get install python3-lxml -y
sudo apt-get install libxml2-dev libxslt-dev python-dev -y
sudo apt-get build-dep python3-lxml -y
sudo pip install lxml
pip install lxml==3.4.2
'''
Instalacao do Plex Media Center
'''
wget https://downloads.plex.tv/plex-media-server-new/1.24.5.5173-8dcc73a59/debian/plexmediaserver_1.24.5.5173-8dcc73a59_amd64.deb
sudo chmod 777 plexmediaserver_1.24.5.5173-8dcc73a59_amd64.deb
sudo dpkg -i plexmediaserver_1.24.5.5173-8dcc73a59_amd64.deb

'''
Instalacao do Sickrage
'''
git https://git.sickrage.ca/SiCKRAGE/sickrage.git


'''
Instalacao do Couch Potato
'''
docker pull couchpotato/couchpotato
docker run --name couchpotato -v <datadir path>:/datadir -v <media path>:/multimidia/movies -p 5050:5050 couchpotato/couchpotato



sudo apt-add-repository universe
sudo apt update
sudo apt install python2-minimal
sudo apt install git
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
cd /opt
sudo git clone https://github.com/RuudBurger/CouchPotatoServer.git ./couchpotato
cd couchpotato
sudo cp ./init/ubuntu /etc/init.d/couchpotato
sudo chmod +x /etc/init.d/couchpotato
sudo mv /etc/default/couchpotato /etc/default/couchpotato.bkp
sudo cat<< EOF | sudo tee /etc/default/couchpotato > /dev/null
# COPY THIS FILE TO /etc/default/couchpotato
# Accepted variables with default values -if any- in parentheses:

# username to run couchpotato under (couchpotato)
#CP_USER=couchpotato
CP_USER=raphaelmaria
# directory of CouchPotato.py (/opt/couchpotato)
CP_HOME=/opt/couchpotato/CouchPotatoServer

# directory of couchpotato's db, cache and logs (/var/opt/couchpotato)
CP_DATA=/home/raphaelmaria/couchpotato
# full path of couchpotato.pid (/var/run/couchpotato/couchpotato.pid)
CP_PIDFILE=
# full path of the python binary (/usr/bin/python)
PYTHON_BIN=

# extra cli options for couchpotato, see 'CouchPotato.py --help'
CP_OPTS=
# extra options for start-stop-daemon, see 'man start-stop-daemon'
SSD_OPTS=
EOF

sudo update-rc.d couchpotato defaults
sudo systemctl start couchpotato
sudo systemctl enable couchpotato

'''
Instalacao do Gerecinador WEB
'''
apt-get update -y
apt-get install cockpit
systemctl enable --now cockpit.socket

sudo ufw disable
