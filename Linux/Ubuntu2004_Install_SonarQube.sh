#!/usr/bin/env bash
# Documentação: https://www.vultr.com/docs/install-sonarqube-on-ubuntu-20-04-lts/

VarPass="ASenhaeforte1206"
SONAR_HOME="/opt/sonarqube"
VARDB="sonardb"
#1. Install OpenJDK 11
sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update
sudo apt-get -y upgrade
sudo apt -y install oracle-java8-installer
sudo apt -y install mysql-server mysql-client
sudo apt-get -y install unzip software-properties-common wget default-jdk -y
sudo apt -y install fontconfig-config libfreetype6 -y

# Instalando Database em Postgres
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ lsb_release -cs-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'


wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-7.1.zip
sudo unzip sonarqube-7.1.zip -d /opt
cd /opt
sudo mv sonarqube-7.1 sonar


sudo mv /opt/sonar/conf/sonar.properties sonar.properties.bkp
echo "sonar.jdbc.username=sonarqube" | sudo tee -a /opt/sonar/conf/sonar.properties
echo "sonar.jdbc.password=your_password
echo "sonar.jdbc.url=jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance&useSSL=false" | sudo tee -a /opt/sonar/conf/sonar.properties

sudo groupadd sonar
sudo useradd -c sonarqube -d /opt/sonar -g sonar sonar
sudo chown sonar:sonar /opt/sonar -R
sudo sed -i '49c\RUN_AS_USER=sonar' /opt/sonar/bin/linux-x86-64/sonar.sh
sudo su sonar
cd /opt/sonar/bin/linux-x86-64/
./sonar.sh start

