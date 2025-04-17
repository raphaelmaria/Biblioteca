#!/bin/bash
# Rodando atualização do sistema
sudo dnf update -y
#
# Habilitando Repositorio EPEL e REMI
sudo dnf config-manager --set-enabled powertools
sudo dnf -y install epel-release
sudo dnf -y install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
#
# Ativando e instalando PHP 8.0
sudo dnf module list php
sudo dnf module reset php
sudo dnf module enable php:remi-8.0
#
# Instalando pacotes
sudo dnf -y install nano snmp snmpd snmp-mibs-downloader net-tools libjson-perl libo-socket-inet6-perl libsocket6-perl libxml-twig-perl libnetaddr-ip-perl libdbi-perl libnetaddr-ip-perl libhtml-parser-perl wmi-client snmp-mibs-downloader
sudo yum -y install  nmap perl-* --skip-broken --allowerasing
sudo dnf -y install wget curl git vim fping libnsl pandorawmic
#
sudo cpan Time::Local DBI Socket6 XML::Simple XML::Twig IO::Socket Time::HiRes NetAddr::IP HTML::Entities IO::Socket::INET6 JSON
#
# Instalando PERCONA -  MySQL 8.0
sudo yum module disable mysql
sudo yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
sudo percona-release setup ps-80
sudo yum install percona-server-server
#
# Instalando o Pandora FMS
curl -SsL https://pfms.me/deployenterprise | PANDORA_LTS=1 PANDORA_ENT_FREE=1 bash
