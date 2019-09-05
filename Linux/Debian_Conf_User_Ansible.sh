#!/bin/bash
# Script para automação da criação do usuário ansible
# apenas para Sistemas Baseados em Debian

su -
useradd -G sudo o2pos
adduser ansible
cd /home/ansible
mkdir .ssh
chmod 755 /home/ansible/.ssh
chown root:root /home/ansible/.ssh
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCu8wGTaS91Z+UZ3xHi+SSjcHBFOppzv82SPhqAltlS39iQG3VTfTswkltrqSnbBBhu19yeQJYX28TimShsuKkd2iE1GQmkV/ej69DICMI4JslPeb1r8Wt+TXuG09TLi9Ok2GpKZBUsDfIFEWoKwxat1bAQZMoWPnfrq/H40HDUqJfTWsKiSA7Zq2GH/ClD8oDh/bO8WLDAOBPbQmF7hiRETWmt1JqNawerLCxpsSJZShb5jrxpRdfnbGdPFA06/o/oMm4pVxTniiosFr+1gJusIpyoTtZv+maJHIGyPBJ/h5zYlxUlACYT31AZ+VWrKaRGa17IIc005qqGAy4oTiKj mferreira@ubuntu >> /home/ansible/.ssh/authorized_keys
chmod 644 /home/ansible/.ssh/authorized_keys
chown root:root /home/ansible/.ssh/authorized_keys
usermod -aG sudo ansible