# Deploy DB

- [Deploy DB](#deploy-db)
  - [Primeiro passo corrigir o horário do servidor](#primeiro-passo-corrigir-o-horário-do-servidor)
    - [Verificar o timezone atual](#verificar-o-timezone-atual)
    - [Listar timezone disponiveis](#listar-timezone-disponiveis)
    - [Definir timezone](#definir-timezone)
    - [Verifique o timezone novamente](#verifique-o-timezone-novamente)
  - [Ajustes de S.O após a instalação](#ajustes-de-so-após-a-instalação)
    - [Verificar se é necessário atualização do S.O](#verificar-se-é-necessário-atualização-do-so)
    - [Instalar utilitários](#instalar-utilitários)
    - [Desabilitar SELINUX](#desabilitar-selinux)
      - [Editar o arquivo de configuração e desabilitar o SELINUX](#editar-o-arquivo-de-configuração-e-desabilitar-o-selinux)
  - [Instalar o MySQL 8](#instalar-o-mysql-8)
    - [Verificar versão disponivel no repositório do Centos 8](#verificar-versão-disponivel-no-repositório-do-centos-8)
    - [Instalar MySQL 8](#instalar-mysql-8)
    - [Habilitar inicialização automática, iniciar o serviço e validar o status](#habilitar-inicialização-automática-iniciar-o-serviço-e-validar-o-status)
    - [Definir senha do usuário root do MySQL](#definir-senha-do-usuário-root-do-mysql)
    - [Conectar no banco, criar o banco de dados e o usuário do Zabbix](#conectar-no-banco-criar-o-banco-de-dados-e-o-usuário-do-zabbix)
    - [Criar usuário zabbix permitindo a conexão através de um servidor remoto](#criar-usuário-zabbix-permitindo-a-conexão-através-de-um-servidor-remoto)
    - [Criar regra no firewall](#criar-regra-no-firewall)

## Primeiro passo corrigir o horário do servidor

### Verificar o timezone atual

```bash
timedatectl status
```

Output:

```bash
               Local time: Wed 2020-06-03 05:03:25 -03
           Universal time: Wed 2020-06-03 08:03:25 UTC
                 RTC time: Wed 2020-06-03 08:03:24
                Time zone: America/New_York (-03, -0300)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

### Listar timezone disponiveis

```bash
timedatectl list-timezones | grep Sao_Paulo
```

Output:

```bash
America/Sao_Paulo
```

### Definir timezone

```bash
timedatectl set-timezone America/Sao_Paulo
```

### Verifique o timezone novamente

```bash
timedatectl status
```

Output:

```bash
               Local time: Wed 2020-06-03 05:03:25 -03
           Universal time: Wed 2020-06-03 08:03:25 UTC
                 RTC time: Wed 2020-06-03 08:03:24
                Time zone: America/Sao_Paulo (-03, -0300)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

## Ajustes de S.O após a instalação

### Verificar se é necessário atualização do S.O

```bash
dnf clean all
dnf check-update
```

### Instalar utilitários

```bash
dnf install -y net-tools vim nano epel-release wget curl tcpdump
```

### Desabilitar SELINUX

- Verificar status atual do SELINUX

```bash
getenforce
```

#### Editar o arquivo de configuração e desabilitar o SELINUX

`É NECESSÁRIO o REBOOT`

```bash
cat /etc/selinux/config
vim /etc/selinux/config
SELINUX=disabled
```

`CASO NÃO QUEIRA DAR REBOOT`

```bash
setenforce 0
getenforce
```

## Instalar o MySQL 8

### Verificar versão disponivel no repositório do Centos 8

```bash
dnf info mysql-server
```

Output:

```bash
Extra Packages for Enterprise Linux Modular 8 - x86_64                                                                                                           228 kB/s | 118 kB     00:00
Extra Packages for Enterprise Linux 8 - x86_64                                                                                                                   7.3 MB/s | 6.9 MB     00:00
Last metadata expiration check: 0:00:01 ago on Mon 08 Jun 2020 11:47:25 PM -03.
Available Packages
Name         : mysql-server
Version      : 8.0.17
Release      : 3.module_el8.0.0+181+899d6349
Architecture : x86_64
Size         : 22 M
Source       : mysql-8.0.17-3.module_el8.0.0+181+899d6349.src.rpm
Repository   : AppStream
Summary      : The MySQL server and related files
URL          : http://www.mysql.com
License      : GPLv2 with exceptions and LGPLv2 and BSD
Description  : MySQL is a multi-user, multi-threaded SQL database server. MySQL is a
             : client/server implementation consisting of a server daemon (mysqld)
             : and many different client programs and libraries. This package contains
             : the MySQL server and some accompanying files and directories.
```

### Instalar MySQL 8

```bash
dnf -y install mysql-server
```

### Habilitar inicialização automática, iniciar o serviço e validar o status

```bash
systemctl enable --now mysqld
systemctl status mysqld
```

### Definir senha do usuário root do MySQL

```bash
mysql_secure_installation

Securing the MySQL server deployment.

Connecting to MySQL using a blank password.

VALIDATE PASSWORD COMPONENT can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD component?

Press y|Y for Yes, any other key for No: y

There are three levels of password validation policy:

LOW    Length >= 8
MEDIUM Length >= 8, numeric, mixed case, and special characters
STRONG Length >= 8, numeric, mixed case, special characters and dictionary                  file

Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 1
Please set the password for root here.

New password: M4r4t0n4Z4bb1x!

Re-enter new password: M4r4t0n4Z4bb1x!

Estimated strength of the password: 100
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : y
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : y
Success.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
Success.

All done!
```

### Conectar no banco, criar o banco de dados e o usuário do Zabbix


```bash
mysql -u root -p
create database zabbix character set utf8 collate utf8_bin;
create user 'zabbix'@'localhost' identified by '2Maratona@Zabbix';
grant all privileges on zabbix.* to 'zabbix'@'localhost';
```

`character set utf8 - support for multilingualism`
`collate utf8_bin - case sensitiveness of stored data`


### Criar usuário zabbix permitindo a conexão através de um servidor remoto

```bash
create user 'zabbix'@'10.0.0.51' identified with mysql_native_password by '2Maratona@Zabbix';
grant all privileges on zabbix.* to 'zabbix'@'10.0.0.51';
UPDATE mysql.user SET Super_Priv='Y' WHERE user='zabbix' AND host='10.0.0.51';
flush privileges;
```

### Criar regra no firewall 

```shell
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --reload
```