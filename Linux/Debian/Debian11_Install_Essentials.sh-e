#!/usr/bin/env bash



# CONFIGURANDO REPOSITORIOS OFICIAIS DO SISTEMA OPERACIONAL (DEBIAN 11)

tee /etc/apt/sources.list<<EOF
deb http://deb.debian.org/debian bullseye main contrib non-free
# deb-src http://deb.debian.org/debian bullseye main contrib non-free

deb http://deb.debian.org/debian bullseye-updates main contrib non-free
# deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free

# deb http://deb.debian.org/debian bullseye-backports main contrib non-free
# deb-src http://deb.debian.org/debian bullseye-backports main contrib non-free

deb http://security.debian.org/debian-security bullseye-security main contrib non-free
# deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free
EOF

# ATUALIZANDO REPOSITORIOS

apt update
apt upgrade -y

# INSTALANDO PACOTES ESSENTIAIS
apt install dialog tree wget tar unzip vim make gcc autoconf automake -y

# INSTALANDO COCKPIT
apt install cockpit -y
systemctl enable cockpit.socket

