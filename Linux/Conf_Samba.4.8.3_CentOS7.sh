#!/bin/sh
# Script Em Shell Bash para instalacao
# do serviço de SAMBA na versao 4
# Desenvolvido por Raphael Maria
# Na data de 17 de Janeiro de 2020
#


# yum -y install samba samba-client samba-common nfs-utils.x86_64 centos-release-nfs-ganesha28.noarch 
yum -y install samba.x86_64 samba-client.x86_64 samba-common.x86_64 samba-winbind.x86_64 samba-winbind-clients.x86_64 

mv /etc/samba/smb.conf /etc/samba/smb.conf.original
mkdir -p /mnt/storage
chcon -Rt samba_share_t /mnt/storage
chmod -R 0770 /mnt/storage
chown -R root:root /mnt/storage
ulimit -n 16384
echo "* - nofile 16384" >> /etc/security/limits.conf

#### Script SAMBA FOR CENTOS 7 ####
echo " # Criado por raphael maria
[global]
#####################################
####     Configuracao de REDE   #####
#####################################

    [global]
	workgroup = WORKGROUP
	netbios name = $hostname
	security = user

    veto files = /.thumbs/.thumbs/.DS
    read raw = yes
    write raw = yes
    oplocks = yes
    getwd cache = yes

#############################################
########      LOGS DO SAMBA        ##########
#############################################

log file = /var/log/samba/%m.log
# Tamanho de Log e igual a 200Mb
max log size = 200000
# Nivel de Coleta de Log
log level = 1 auth:5

#############################################
#########   Lixeira e da Auditoria  #########
#############################################
    vfs objects = full_audit, recycle
    recycle:versions = yes
    recycle:repository = /mnt/share/lixeira
    recycle:keeptree = yes
    recycle:exclude = *.mp3, *.iso, *.exe, *.mkv, *.mp4 
    recycle:exclude_dir = tmp, cache

    full_audit:success = open, opendir, write, unlink, rename, mkdir, rmdir, chmod, chown
    log file = /mnt/share/logs/%U.log
    max log size = 100
    vfs objects = full_audit
    full_audit:prefix = %u|%I|%S|%

##########################################
###### configuracao Compartilhamentos ####
##########################################
    [LIXEIRA]
        path = /mnt/share/lixeira
        writeable = yes
        browseable = yes
        valid users = $varuser

#####################################
#### Compartilhamento de Arquivos ###
#####################################
    [DADOS]
        comment = Arquivos de Video Backup
        path = /mnt/storage/$varshare
        browseable = yes
        writable = yes
        write list = $varuser
        guest ok = yes
        valid users = $varuser
        veto files = *.exe, *.rar, *.zip, *.tar, *.bmp
    
    [LOGS]
        path=/mnt/share/logs
        browseable = true
        valid users = admin
        admin users = admin" > /etc/samba/smb.conf



USER = acesso
read USER
adduser $USER
echo "Digite a senha:"
read PWD
smbpasswd -a $USER -p $PWD