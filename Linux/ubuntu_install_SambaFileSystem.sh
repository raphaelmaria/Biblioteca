    #!/usr/bin/env bash

    sudo apt -y install vlc-plugin-samba vlc smbclient samba-vfs-modules samba samba-dev samba-dsdb-modules samba-libs
    sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bkp


    echo" # See smb.conf.example for a more detailed config file or
# read the smb.conf manpage.
# Run 'testparm' to verify the config is correct after
# you modified it.

[global]
	workgroup = WORKGROUP
	netbios name = infoscale
	security = user
	map to guest = Bad User
	guest ok = yes

##################################
#####     LOGS DO SAMBA    #######
##################################
log file = /var/log/samba/%m.log
# Tamanho de Log e igual a 200Mb
max log size = 200000
# Nivel de Coleta de Log
log level = 1 auth:5

###################################
####       TUNNING SAMBA     ######
###################################
strict locking = no
read raw = yes
write raw = yes
oplocks = yes
max xmit = 65535
deadtime = 15
getwd cache = yes
socket options = TCP_NODELAY	

[Externo]
	comment = Data in Externo Device
	path = /mnt/ext
	#valid users = o2
	public = yes
	writable = yes
	veto files = 

	vfs objects = recycle
	recycle:repository = Lixeira
	recycle:keeptree = yes
	recycle:versions = yes" | sudo tee -a /etc/samba/smb.conf

    sudo testparm
    sudo systemctl enable --now smbd.service
    sudo systemctl enable --now nmbd.service