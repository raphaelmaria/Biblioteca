#!/usr/bin/env bash

# Links de referência:
# 1: https://kifarunix.com/install-ocs-inventory-server-on-debian/
# 2: https://kifarunix.com/install-mariadb-11-on-debian/

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

# Configuração de segurança inicial do MariaDB
mariadb-secure-installation

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
apt update
perl -MCPAN -e 'install XML::Entities'
apt -y install ocsinventory

# Configuração do Apache para o OCS Inventory Server
DB_HOST="localhost"
DB_PORT="3306"
CONFIG_FILE="/etc/apache2/conf-available/z-ocsinventory-server.conf"

# Atualiza o arquivo de configuração do OCS Inventory Server
cat <<EOL > $CONFIG_FILE
<IfModule mod_perl.c>
  PerlSetEnv OCS_MODPERL_VERSION 2
  PerlSetEnv OCS_DB_HOST $DB_HOST
  PerlSetEnv OCS_DB_PORT $DB_PORT
  PerlSetEnv OCS_DB_NAME $DB_NAME
  PerlSetEnv OCS_DB_LOCAL $DB_NAME
  PerlSetEnv OCS_DB_USER $DB_USER
  PerlSetVar OCS_DB_PWD $DECRYPTED_PASSWORD
</IfModule>
EOL

sudo systemctl restart apache2
echo "Arquivo de configuração do OCS Inventory Server atualizado com sucesso."

# Configuração da RestAPI para o OCS Inventory Server
CONFIG_FILE="/etc/apache2/conf-available/zz-ocsinventory-restapi.conf"

# Atualiza o arquivo de configuração da RestAPI
cat <<EOL > $CONFIG_FILE
<Perl>
  \$ENV{PLACK_ENV} = 'production';
  \$ENV{MOJO_HOME} = '/usr/share/perl5';
  \$ENV{MOJO_MODE} = 'deployment';
  \$ENV{OCS_DB_HOST} = '$DB_HOST';
  \$ENV{OCS_DB_PORT} = '$DB_PORT';
  \$ENV{OCS_DB_LOCAL} = '$DB_NAME';
  \$ENV{OCS_DB_NAME} = '$DB_NAME';
  \$ENV{OCS_DB_USER} = '$DB_USER';
  \$ENV{OCS_DB_PWD} = '$DECRYPTED_PASSWORD';
  \$ENV{OCS_DB_SSL_ENABLED} = 0;
</Perl>
EOL

sudo systemctl restart apache2
echo "Arquivo de configuração da RestAPI atualizado com sucesso."

# Configuração do dbconfig.inc.php para o OCS Inventory Server
CONFIG_FILE="/etc/ocsinventory-reports/dbconfig.inc.php"

# Atualiza o arquivo dbconfig.inc.php com os dados de conexão
cat <<EOL > $CONFIG_FILE
<?php
 define("DB_NAME", "$DB_NAME");
 define("SERVER_READ", "$DB_HOST");
 define("SERVER_WRITE", "$DB_HOST");
 define("SERVER_PORT", "$DB_PORT");
 define("COMPTE_BASE", "$DB_USER");
 define("PSWD_BASE", "$DECRYPTED_PASSWORD");
?>
EOL

echo "Arquivo de configuração $CONFIG_FILE atualizado com sucesso."

# Configuração do php.ini para o OCS Inventory Server
PHP_INI_PATH="/etc/php/*/apache2/php.ini"

# Altera os valores no arquivo php.ini
sudo sed -i 's/^max_execution_time = .*/max_execution_time = 0/' $PHP_INI_PATH
sudo sed -i 's/^max_input_time = .*/max_input_time = 0/' $PHP_INI_PATH
sudo sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 50M/' $PHP_INI_PATH
sudo sed -i 's/^post_max_size = .*/post_max_size = 51M/' $PHP_INI_PATH
sudo sed -i 's/^memory_limit = .*/memory_limit = 256M/' $PHP_INI_PATH

sudo systemctl restart apache2
echo "Configuração do php.ini atualizada e servidor Apache reiniciado."

# Permissões e ajustes finais
chmod -R 766 /usr/share/ocsinventory-reports
chown -R www-data:www-data /usr/share/ocsinventory-reports /var/lib/ocsinventory-reports
a2dissite 000-default.conf
systemctl restart apache2 mariadb
