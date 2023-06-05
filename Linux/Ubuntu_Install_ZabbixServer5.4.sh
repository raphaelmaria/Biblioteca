#!/bin/bash

# Adicione o repositório oficial do Zabbix
wget https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.4-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_5.4-1+ubuntu20.04_all.deb
sudo apt update

# Instale o servidor Zabbix e o banco de dados MySQL
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent mysql-server

# Configure o banco de dados MySQL
sudo mysql_secure_installation

# Crie o banco de dados do Zabbix
sudo mysql -uroot -p -e "CREATE DATABASE zabbix CHARACTER SET utf8 COLLATE utf8_bin;"
sudo mysql -uroot -p -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost' IDENTIFIED BY 'sua_senha';"

# Importe o esquema inicial e os dados no banco de dados do Zabbix
sudo zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | sudo mysql -uzabbix -p zabbix

# Configure as credenciais do banco de dados no arquivo de configuração do Zabbix Server
sudo sed -i 's/DBHost=localhost/DBHost=localhost\nDBPassword=sua_senha/' /etc/zabbix/zabbix_server.conf

# Reinicie os serviços do Apache e do Zabbix Server
sudo systemctl restart apache2
sudo systemctl restart zabbix-server

# Habilitar o serviço do Zabbix Agent
sudo systemctl enable zabbix-agent
sudo systemctl start zabbix-agent

echo "A instalação do Zabbix Server foi concluída!"
