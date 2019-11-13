CentOS 7 - VM 
IP ACCESS: 192.168.11.240
ROOT: O22013lx

Diretorio dos arquivos de Dump:
# /dump

Comando que eu executei até agora:
> Instalar o Postgres
# yum search postgres
# yum install postgresql-server.x86_64 vim net-tools
# postgresql-setup initdb
# systemctl start postgresql
# systemctl status postgresql

> Criar uma pasta 
dump na raiz do "/"
# mkdir /dump

Copiar os arquivos sql.gz do servidor 192.168.8.42:/backups
verificar se o arquivo tem um complemento por outra parte.

> usar um gunzip para extrair o arquivo SQL.
# gunzip <file>.sql.gz
O arquivo gz vai sumir

> Para restaurar o DB desejado.
# su - postgres
# psql -d <DB novo> < <DB desejado>.sql
Exemplo: # psql -d 2018_entretenimento_15 < 2018_entretenimento.sql
# exit> Editar os arquivos que permitem o acesso ao Postgres
Localizar o arquivo postgresql.conf
# find / -name "postgresql.conf"# vim /var/lib/pgsql/data/postgresql.conf

Localizar a linha (listen_addresses = 'localhost’) e alterar localhost para “*”
“esc+ :x” para salvar
Localizar o arquivo “pg_hba.conf”
# find / -name pg_hba.conf

# vim /var/lib/pgsql/data/pg_hba.confAlterar as ultimas linhas com:
———————————————————
# TYPE  DATABASE        USER            ADDRESS                 METHOD
:q
# "local" is for Unix domain socket connections only
local   all             all                                     	peer
local   all             postgres                               	 md5
# IPv4 local connections:
host    all             all             127.0.0.1/32            ident
host    all             all             192.168.0.0/16        md5
# IPv6 local connections:
host    all             all             ::1/128                 ident
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     postgres                                peer
#host    replication     postgres        127.0.0.1/32            ident
#host    replication     postgres        ::1/128                 ident
————————————————————
“esc+ :x” para salvar

> Alterar a senha do user postgres
# psql
# ALTER USER postgres WITH PASSWORD ‘senha nova’;

>Desligar o firewall
# systemctl stop firewalld
# systemctl disable firewalld


