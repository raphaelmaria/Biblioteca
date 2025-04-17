#!/bin/sh

# URL: https://h-mdm.com/advanced-web-panel-installation/

apt update
apt install -y aapt tomcat9 postgresql vim certbot unzip net-tools

su postgres
psql
postgres=# CREATE USER hmdm WITH PASSWORD 'topsecret';
postgres=# CREATE DATABASE hmdm WITH OWNER=hmdm;
postgres=# \q
exit

wget https://h-mdm.com/files/hmdm-5.14-install-ubuntu.zip
unzip hmdm-5.14-install-ubuntu.zip
cd hmdm-install/

Alternative: build Headwind MDM
git clone https://github.com/h-mdm/hmdm-server.git
cd hmdm-server/
apt install -y maven
cp server/build.properties.example server/build.properties
mvn install


./hmdm_install.sh
We recommend to confirm suggested answers to the installer questions (install required software, Tomcat upgrade, etc.).

Important: on Tomcat 9, you need to use a subdirectory of the “Tomcat sandbox” (/var/lib/tomcat9) for storing files, because Tomcat has no permission to write files outside the sandbox. Scripts and other files unrelated to Tomcat are placed to /opt/hmdm by default.