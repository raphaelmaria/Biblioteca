#!/bin/sh
# AUTO CIFS CREATE TASK
# VERSAO LINUX
# CRIADO POR RAPHAEL MARIA.
# EM 11 DE JUNHO DE 2020.
# VERSAO 1.0

# Desmonta todas as unidades:
umount -a
#Substitui a entrada do 192.168.8.14 comentando para mesma não ser lida
sed -i 's/^192.168.8.14/#192.168.8.14/' /etc/fstab
#Monta as unidades NFS novamentes
mount -a

#Cria e escreve o arquivo de crendecial a serem lidos
mkdir /scripts
touch /scripts/credentials
echo "username=render
password=o22009Render
domain=o2pos" >> /scripts/credentials
chown root: /scripts/credentials
chmod 600 /scripts/credentials

#Criar o scritp de automount
touch /scripts/autocifs.sh
echo "
mount.cifs -o credentials=/scripts/credentials //192.168.8.14/Publicidade /mnt/Publicidade" >> /scripts/autocifs.sh
chmod -R 777 /scripts
chmod +X /scripts/autocifs.sh

#Cria a tarefa para ler o script de montagem sempre que reiniciar
echo"@reboot /scripts/autocifs.sh" >> /etc/crontab
#Roda o script na primeira instalação.
bash /scripts/autocifs.sh