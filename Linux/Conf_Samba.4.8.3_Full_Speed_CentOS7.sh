#!/bin/sh

# Pacotes para instalacao

# Script para substituicao de SMB.CONF




echo "# See smb.conf.example for a more detailed config file or
# read the smb.conf manpage.
# Run 'testparm' to verify the config is correct after
# you modified it.

[global]
	workgroup = WORKGROUP
	netbios name = infoscale
	security = user

[accounts]
	comment = Accounts data directory
	path = /mnt/storage
	valid users = o2
	public = yes
	writable = yes"