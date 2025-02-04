#!/usr/bin/env bash

# Atualização do sistema
apt update && apt upgrade -y

# Exibir detalhes do pacote mariadb-server
apt show mariadb-server

# Instalação de dependências e configuração do repositório MariaDB
apt -y install software-properties-common dirmngr curl ca-certificates apt-transport-https
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash -s -- --mariadb-server-version="mariadb-11.0"

# Instalação do MariaDB Server
apt -y install mariadb-server
systemctl enable --now mariadb

# Configuração de segurança inicial do MariaDB de forma não interativa
mysql_secure_installation <<EOF

Y
n
Y
Y
Y
Y
EOF

# Configurar o MySQL para aceitar conexões de qualquer host
DB_NAME="OCSDB"
DB_USER="root"
PASSWORD_FILE="/root/.mariadb_root_password"
KEY_FILE="/root/.mariadb_key"

# Gera uma senha aleatória, criptografa e armazena em arquivos seguros
RANDOM_PASSWORD=$(openssl rand -base64 16)
echo $RANDOM_PASSWORD > $PASSWORD_FILE
openssl rand -base64 32 > $KEY_FILE
openssl enc -aes-256-cbc -salt -in $PASSWORD_FILE -out "${PASSWORD_FILE}.enc" -pass file:$KEY_FILE
rm $PASSWORD_FILE

# Descriptografando a senha para uso
DECRYPTED_PASSWORD=$(openssl enc -aes-256-cbc -d -in "${PASSWORD_FILE}.enc" -pass file:$KEY_FILE)

# Criação do banco de dados e concessão de privilégios
mysql -u $DB_USER -p"$DECRYPTED_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u $DB_USER -p"$DECRYPTED_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DECRYPTED_PASSWORD';"
mysql -u $DB_USER -p"$DECRYPTED_PASSWORD" -e "FLUSH PRIVILEGES;"

echo "Banco de dados $DB_NAME criado com sucesso e privilégios concedidos."
echo "A senha foi armazenada e criptografada em $PASSWORD_FILE.enc"

# Instalação do OCS Inventory Server
apt -y install php php-pclzip php-mbstring php-soap php-mysql php-curl php-xml php-zip php-gd gnupg2 wget
curl -sS http://deb.ocsinventory-ng.org/pubkey.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/ocs.gpg
echo "deb http://deb.ocsinventory-ng.org/debian/ bullseye main" | tee /etc/apt/sources.list.d/ocsinventory.list
