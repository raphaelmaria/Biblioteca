#!/usr/bin/env bash

# Variavel
userDB="admin"
userDBPass="password"

sudo apt update
sudo apt upgrade -y

sudo apt install mariadb-server -y
sudo mysql_secure_installation << EOF
$userDBPass
N
Y
Y
Y
EOF

sudo mysql -u root -p -e "GRANT USAGE ON *.* TO 'admin'@'%' IDENTIFIED BY 'password';"
sudo mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS monitor;"
sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON monitor.* TO 'admin'@'%';"
sudo mysql -u root -p -e "FLUSH PRIVILEGES;"
