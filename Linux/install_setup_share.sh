#!/bin/sh
####
#### Script automatico para instalacao de arquivos de configuracao /
#### do Netatalk, Samba e NFS.


wget http://192.168.8.7/linux/Softwares/server/config.zip
unzip config.zip
cd config

mv /usr/local/etc/afp.conf /usr/local/etc/afp.conf.bkp
mv /etc/samba/smb.conf /etc/samba/smb.conf.bkp
mv /etc/exports /etc/exports.bkp

cp -f afp.conf /usr/local/etc/afp.conf
cp -f smb.conf /etc/samba/smb.conf
cp -f exports /etc/exports

systemctl enable smb
systemctl enable nmb
systemctl enable netatalk
systemctl enable nfs
systemctl enable nslcd

systemctl start smb
systemctl start nmb
systemctl start afp
systemctl start nfs
systemctl start nslcd