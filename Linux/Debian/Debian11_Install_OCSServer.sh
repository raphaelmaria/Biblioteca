#!/usr/bin/env bash

# Conteudo base:
# Link 1: https://kifarunix.com/install-ocs-inventory-server-on-debian/
# Link 2: https://kifarunix.com/install-mariadb-11-on-debian/

apt update
apt upgrade -y
apt show mariadb-server
apt -y install software-properties-common dirmngr curl ca-certificates apt-transport-https
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | \
sudo bash -s -- --mariadb-server-version="mariadb-11.0"
apt -y install mariadb-server
systemctl status mariadb
systemctl start mariadb
mariadb-secure-installation
mariadb -u root
#sudo -u mysql mariadb

# Configurar o MySQL para aceitar conexões de qualquer host
# Variáveis
DB_NAME="OCSDB"
DB_USER="root"
PASSWORD_FILE="/root/.mariadb_root_password"
KEY_FILE="/root/.mariadb_key"

# Gera uma senha aleatória e salva em um arquivo
RANDOM_PASSWORD=$(openssl rand -base64 16)
echo $RANDOM_PASSWORD > $PASSWORD_FILE

# Cria uma chave para criptografar a senha
openssl rand -base64 32 > $KEY_FILE

# Criptografa a senha
openssl enc -aes-256-cbc -salt -in $PASSWORD_FILE -out "${PASSWORD_FILE}.enc" -pass file:$KEY_FILE

# Remove o arquivo de senha em texto claro
rm $PASSWORD_FILE

# Descriptografando a senha para uso
DECRYPTED_PASSWORD=$(openssl enc -aes-256-cbc -d -in "${PASSWORD_FILE}.enc" -pass file:$KEY_FILE)

# Criação do banco de dados e concessão de privilégios
mysql -u $DB_USER -p"$DECRYPTED_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u $DB_USER -p"$DECRYPTED_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'localhost' IDENTIFIED BY '$DECRYPTED_PASSWORD';"
mysql -u $DB_USER -p"$DECRYPTED_PASSWORD" -e "FLUSH PRIVILEGES;"

echo "Banco de dados $DB_NAME criado com sucesso e privilégios concedidos."
echo "A senha foi armazenada e criptografada em $PASSWORD_FILE.enc"

# Instalar o OCS Inventory Server
apt -y install php php-pclzip php-mbstring php-soap php-mysql php-curl php-xml php-zip php-gd
apt install gnupg2 curl wget -y
curl -sS http://deb.ocsinventory-ng.org/pubkey.gpg | \
gpg --dearmor -o /etc/apt/trusted.gpg.d/ocs.gpg
echo "deb http://deb.ocsinventory-ng.org/debian/ bullseye main" | \
tee /etc/apt/sources.list.d/ocsinventory.list

apt update
perl -MCPAN -e 'install XML::Entities'
apt -y install ocsinventory

# Configurar o Database para o OCS Inventory Server
# Variáveis
DB_HOST="localhost"
DB_PORT="3306"
DB_NAME="OCSDB"
DB_USER="root"
PASSWORD_FILE="/root/.mariadb_root_password.enc"
KEY_FILE="/root/.mariadb_key"
CONFIG_FILE="/etc/apache2/conf-available/z-ocsinventory-server.conf"

# Descriptografa a senha do banco de dados
DECRYPTED_PASSWORD=$(openssl enc -aes-256-cbc -d -in "$PASSWORD_FILE" -pass file:$KEY_FILE)

# Atualiza o arquivo de configuração com os dados de conexão
cat <<EOL > $CONFIG_FILE
<IfModule mod_perl.c>
 
  # Which version of mod_perl we are using
  # For mod_perl <= 1.999_21, replace 2 by 1
  # For mod_perl > 1.999_21, replace 2 by 2
  PerlSetEnv OCS_MODPERL_VERSION 2

  # Master Database settings
  # Replace localhost by hostname or ip of MySQL server for WRITE
  PerlSetEnv OCS_DB_HOST $DB_HOST
  # Replace 3306 by port where running MySQL server, generally 3306
  PerlSetEnv OCS_DB_PORT $DB_PORT
  # Name of database
  PerlSetEnv OCS_DB_NAME $DB_NAME
  PerlSetEnv OCS_DB_LOCAL $DB_NAME
  # User allowed to connect to database
  PerlSetEnv OCS_DB_USER $DB_USER
  # Password for user
  PerlSetVar OCS_DB_PWD $DECRYPTED_PASSWORD
  # SSL Configuration
EOL

# Reinicie o Apache para aplicar as mudanças
sudo systemctl restart apache2

echo "Arquivo de configuração atualizado com sucesso e servidor Apache reiniciado."

# Configurar o RestAPI para o OCS Inventory Server
# Variáveis de conexão do banco de dados
DB_HOST="localhost"
DB_PORT="3306"
DB_NAME="OCSDB"
DB_USER="root"
PASSWORD_FILE="/root/.mariadb_root_password.enc"
KEY_FILE="/root/.mariadb_key"
CONFIG_FILE="/etc/apache2/conf-available/zz-ocsinventory-restapi.conf"

# Descriptografa a senha do banco de dados
DECRYPTED_PASSWORD=$(openssl enc -aes-256-cbc -d -in "$PASSWORD_FILE" -pass file:$KEY_FILE)

# Atualiza o arquivo de configuração zz-ocsinventory-restapi.conf com os dados de conexão
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

# Reinicie o Apache para aplicar as mudanças
sudo systemctl restart apache2

echo "Arquivo de configuração $CONFIG_FILE atualizado com sucesso e servidor Apache reiniciado."

# Configurar o Database para o OCS Inventory Server
# Variáveis de conexão do banco de dados
DB_HOST="localhost"
DB_PORT="3306"
DB_NAME="OCSDB"
DB_USER="root"
PASSWORD_FILE="/root/.mariadb_root_password.enc"
KEY_FILE="/root/.mariadb_key"
CONFIG_FILE="/etc/ocsinventory-reports/dbconfig.inc.php"

# Descriptografa a senha do banco de dados
DECRYPTED_PASSWORD=$(openssl enc -aes-256-cbc -d -in "$PASSWORD_FILE" -pass file:$KEY_FILE)

# Atualiza o arquivo dbconfig.inc.php com os dados de conexão
cat <<EOL > $CONFIG_FILE
<?php
 define("DB_NAME", "$DB_NAME");
 define("SERVER_READ", "$DB_HOST");
 define("SERVER_WRITE", "$DB_HOST");
 define("SERVER_PORT", "$DB_PORT");
 define("COMPTE_BASE", "$DB_USER");
 define("PSWD_BASE", "$DECRYPTED_PASSWORD");
 define("ENABLE_SSL", "");
 define("SSL_MODE", "");
 define("SSL_KEY", "");
 define("SSL_CERT", "");
 define("CA_CERT", "");
?>
EOL

echo "Arquivo de configuração $CONFIG_FILE atualizado com sucesso."

# Configurar o php.ini para o OCS Inventory Server
# Variáveis
PHP_INI_PATH="/etc/php/*/apache2/php.ini"

# Altera os valores no arquivo php.ini
sudo sed -i 's/^max_execution_time = .*/max_execution_time = -1/' $PHP_INI_PATH
sudo sed -i 's/^max_input_time = .*/max_input_time = -1/' $PHP_INI_PATH
sudo sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 50M/' $PHP_INI_PATH
sudo sed -i 's/^post_max_size = .*/post_max_size = 51M/' $PHP_INI_PATH
sudo sed -i 's/^memory_limit = .*/memory_limit = 256M/' $PHP_INI_PATH

# Reinicie o Apache para aplicar as mudanças
sudo systemctl restart apache2

echo "Configuração do php.ini atualizada e servidor Apache reiniciado."

chmod -R 766 /usr/share/ocsinventory-reports
chown -R www-data:www-data /usr/share/ocsinventory-reports \
/var/lib/ocsinventory-reports
a2dissite 000-default.conf
systemctl restart apache2 mariadb
