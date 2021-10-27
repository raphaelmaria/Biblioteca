#!/bin/sh
'''
Links usados para a pesquisa:
Install Docker: https://www.smarthomebeginner.com/install-docker-on-ubuntu-1604/
Install Sick Rage: https://www.smarthomebeginner.com/install-couchpotato-using-docker/
Install Couch Potato: https://couchpota.to/#
'''
# REMOVE PYTHON VERSION
$pythonversion = python3 --version
IF($pythonversion -eq "Python 3.4.10")
sudo apt purge python3.* 

# INSTALL PYTHON
sudo apt autoremove
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install gcc libffi-dev libssl-dev python3-dev

sudo apt-get install build-essential checkinstall -y
sudo apt-get install software-properties-common -y
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y
sudo apt-get install python3-pip -y
sudo apt-get install build-essential python-dev git scons swig -y
sudo apt-get install python3-pip python3-setuptools python3-psutil python3-bottle python3-requests -y
'''
cd /usr/src
sudo wget https://www.python.org/ftp/python/3.4.4/Python-3.4.4.tgz
sudo tar xzf Python-3.4.4.tgz
cd Python-3.4.4
sudo ./configure
sudo make altinstall
sudo python3.4 -V
'''
sudo apt-get install python3-pip -y
pip install --no-deps -U news-please

# LXML (link: https://lxml.de/installation.html)
sudo apt autoremove
sudo apt-get install python3-lxml -y
sudo apt-get install libxml2-dev libxslt-dev python-dev -y
sudo apt-get build-dep python3-lxml -y
sudo pip install lxml
pip install lxml==3.4.2

menu()
{
clear
echo "------------------------------------------"
echo "Criado por Raphael Maria"
echo "1. Se quer fazer a instalaçao via Copilacacao"
echo " "
echo "2. Se quer fazer a instalacao via contanier (docker)"
echo " "
echo "3. Para SAIR"
echo -n "Escolha uma opção: "
read OPTION
echo
case "$OPTION" in
    1)
    sudo apt-get autoremove
    cd ~
    git https://git.sickrage.ca/SiCKRAGE/sickrage.git
    cd sickrage
    python3 -m pip install -r requirements.txt
    python3 -m pip install -r requirements-dev.txt
;;
    2)
    # Install DOCKER in Ubuntu
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates
    sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    echo deb https://apt.dockerproject.org/repo ubuntu-xenial main | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get update
    apt-cache policy docker-engine
    sudo apt-get install docker-engine
    
    # sudo service docker start ---> Linha do site
    sudo systemctl enable docker --now #Linhas adicionada por Raphael Maria
    
    # DEPLOY SICKRAGE
    sudo mkdir -p /mnt/dados/multimidia/{cache,movies,series,tv,anime}
    sudo chmod -R 777 /mnt/dados/multimidia
    docker pull sickrage/sickrage
    docker run -d --name="sickrage" -v /path/to/sickrage/data:/config -v /path/to/downloads:/mnt/dados/multimidia -v /path/to/tv:/mnt/dados/multimidia/tv -v /path/to/anime:/mnt/dados/multimidia/anime -v /path/to/series:/mnt/dados/multimidia/series -v /path/to/movies:/mnt/dados/multimidia/movies -e TZ=Canada/Pacific -p 8081:8081 sickrage/sickrage:latest
    sudo docker start sickrage
    echo "Basta abri o navegador com o endereço IP desta maquina seguido da porta 8081."
    echo "IPADDRESS:8091"
    pause
    echo "Pressione qualquer tecla para sair!"
    exit;
;;
    3)
    echo "SAINDO... Até Logo!"
    sleep 5
    clear;
    exit;
;;
*)
    echo "A opção selecionada não existe!"
    echo "Tente novamente selecione uma opção do menu."
esac
done

}
menu