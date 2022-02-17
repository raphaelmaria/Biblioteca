#!/usr/bin/env bash
# Documentação: https://www.vultr.com/docs/install-sonarqube-on-ubuntu-20-04-lts/

#1. Install OpenJDK 11
sudo apt-get install openjdk-11-jdk -y

#2. Install and Configure PostgreSQL
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
sudo apt install postgresql postgresql-contrib -y
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo passwd postgres << EOF
password
password
EOF

su - postgres << EOF
password
EOF

createuser sonar
psql
ALTER USER sonar WITH ENCRYPTED password 'ASenhaeforte!1206';
CREATE DATABASE sonarqube OWNER sonar;
GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonar;
\q
exit


#3. Download and Install SonarQube
sudo apt-get install zip -y
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-<VERSION_NUMBER>.zip
sudo unzip sonarqube-<VERSION_NUMBER>.zip
sudo mv sonarqube-<VERSION_NUMBER> /opt/sonarqube

#4. Add SonarQube Group and User
sudo groupadd sonar
sudo useradd -d /opt/sonarqube -g sonar sonar
sudo chown sonar:sonar /opt/sonarqube -R

#5. Configure sonarqube
sudo nano /opt/sonarqube/conf/sonar.properties
#sonar.jdbc.username= > sonar.jdbc.username=sonar
#sonar.jdbc.password= > sonar.jdbc.password=my_strong_password

sonar.jdbc.username=sonar
sonar.jdbc.password=my_strong_password

sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube

sudo nano /opt/sonarqube/bin/linux-x86-64/sonar.sh
#RUN_AS_USER= > RUN_AS_USER=sonar

#6. Setup Systemd service
echo "[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking

ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop

User=sonar
Group=sonar
Restart=always

LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/sonar.service

sudo systemctl enable sonar
sudo systemctl start sonar
sudo systemctl status sonar

#7. Modify Kernel System Limits
echo "vm.max_map_count=262144
fs.file-max=65536
ulimit -n 65536
ulimit -u 4096" | sudo tee -a /etc/sysctl.conf

sudo reboot
