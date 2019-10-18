yum install samba samba-client samba-common
mv /etc/samba/smb.conf /etc/samba/smb.conf.original


mkdir -p /mnt/storage
chcon -Rt samba_share_t /mnt/storage
chmod -R 0770 
chown -R acesso:acesso /mnt/storage
ulimit -n 16384
echo "* - nofile 16384" >> /etc/security/limits.conf

#### Script SAMBA FOR CENTOS 7 ####
echo " # Criado por raphael maria
[global]
#####################################
####     Configuracao de REDE   #####
#####################################

    server role = standalone server
    workgroup = WORKGROUP
    netbios name = cinema
    server string = Samba Files
    os level = 100   
    wins support = yes
    # hosts allow = [Ranger IP/Mascara]
    bind interfaces only = yes
    keepalive = 20
    dns proxy = no
    max connections = 10
    max xmit = 65535


    security = user
    encrypt passwords = true
    passdb backend = tdbsam

    preserve case = yes
    default case = lower
    veto files = /.thumbs/.thumbs/.DS
    read raw = yes
    write raw = yes
    oplocks = yes
    getwd cache = yes
    unix charset = UTF-8
    min protocol = SMB2
    max protocol = SMB3

################################
##### configuracao Lixeira #####
################################
    vfs objects = full_audit, recycle
    recycle:versions = yes
    recycle:repository = /mnt/storage/lixeira
    recycle:keeptree = yes
    recycle:exclude = *.mp3, *.iso, *.exe, *.mkv, *.mp4 
    recycle:exclude_dir = tmp, cache

##################################
###### configuracao Auditoria ####
##################################
    full_audit:success = write, unlink, rename, rmdir, chmod, chown
    full_audit:prefix = %u|%S
    full_audit:failure = none
    full_audit:facility = local5
    full_audit:priority = notice

##########################################
###### configuracao Compartilhamentos ####
##########################################
    [lixeira]
        path = /mnt/storage/lixeira
        writable = yes
        create mask = 0700
        directory mask = 0700
        browseable = yes

#####################################
#### Compartilhamento de Arquivos ###
#####################################
    [midia]
        comment = Arquivos de Video Backup
        path = /mnt/storage/dados
        browseable = yes
        writable = yes
        write list = acesso
        create mask = 0775
        directory mask = 0775
        guest ok = yes
        valid users = acesso nobody guest
        veto files = *.rar, *.zip, *.tar, *.bmp" >> /etc/samba/smb.conf
