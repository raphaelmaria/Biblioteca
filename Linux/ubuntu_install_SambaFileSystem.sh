#!/usr/bin/env bash
sudo apt -y install dialog
sudo apt -y install vlc-plugin-samba vlc smbclient samba-vfs-modules samba samba-dev samba-dsdb-modules samba-libs
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bkp

VARSHARE=$(dialog --stdout --inputbox 'Insira o nome  do compartilhamento: ' 0 0)
VARPATH=$(dialog --stdout --inputbox 'Insira o diretorio: ' 0 0)

sudo mkdir $VARPATH/$VARSHARE
sudo chmod -R 775 $VARPATH/$VARSHARE

cat <<EOF >
 # See smb.conf.example for a more detailed config file or
# read the smb.conf manpage.
# Run 'testparm' to verify the config is correct after
# you modified it.

[global]
	workgroup = WORKGROUP
	netbios name = $VARSHARE
	security = user
	map to guest = Bad User
	guest ok = yes

#>_ Logs
log file = /var/log/samba/%m.log
# Tamanho de Log e igual a 200Mb
max log size = 200000
# Nivel de Coleta de Log
log level = 1 auth:5

#>_ TUNNING SAMBA
strict locking = no
read raw = yes
write raw = yes
oplocks = yes
max xmit = 65535
deadtime = 15
getwd cache = yes
socket options = TCP_NODELAY	

[$VARSHARE]
	comment = Data in Device
	path = $VARPATH/$VARSHARE
	public = yes
	writable = yes
	veto files = 

	vfs objects = recycle
	recycle:repository = Lixeira
	recycle:keeptree = yes
	recycle:versions = yes
EOF

sudo testparm
sudo systemctl enable --now smbd.service
sudo systemctl enable --now nmbd.service