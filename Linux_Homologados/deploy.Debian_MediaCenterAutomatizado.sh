#!/bin/sh
'''
Links usados para a pesquisa:
Install Sickrage: https://www.smarthomebeginner.com/install-sickrage-on-ubuntu/
Install CoachPotato: https://www.how2shout.com/linux/how-to-install-couchpotato-on-ubuntu-20-04-lts-linux/
Install Sonarr: https://varhowto.com/install-sonarr-ubuntu-20-04/
Install Jackett: https://varhowto.com/install-jackett-ubuntu-20-04/
Install Radarr: https://varhowto.com/install-radarr-ubuntu-20-04/
'''
# Variaveis necessarias para instalacao
$userLocal = ${whoime}

# Alterando algumas configuracoes
# Mudando o nome da maquina:
sudo hostnamectl set-hostname pyserver
# Mudanro o Time Zone para o horario ficar certo:
sudo timedatectl set-timezone America/Sao_Paulo

# Atualizando o Debian / Ubuntu
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt --fix-broken -y
sudo apt autoremove -y
sudo apt-get upgrade -y
sudo apt-get install update-manager-core
do-release-upgrade

# Instalando app que sao requisitos
sudo apt -y gcc ansible wget vim git-core

# Instalando o gerenciador via Web Browser
sudo apt install cockpit -y
##
## AGORA SO ACESSAR O NAVEGADOR NO http://localhost:9090/
##
# Criando diretorios Necessarios.
sudo mkdir -p /home/$userLocal/multimidia/{Series,Movies,Animes}
sudo chmod -R 777 /home/$userLocal/multimidia/*

# Instalando e configurando o Samba para acesso pela REDE
sudo apt install samba samba-client
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.original
sudo touch /etc/samba/smb.conf

sudo cat <<EOF > /etc/samba/smb.conf
#CRIADO POR RAPHAEL MARIA

[global]
   workgroup = WORKGROUP
	server string = %h server (Samba, Ubuntu)
   dns proxy = no
   netbios name = "$hostname"
   
# Configuracao de Checagem de Ativo na Rede
	keepalive = 30

##################################
#####     LOGS DO SAMBA    #######
##################################
    log file = /var/log/samba/%m.log
    # Tamanho de Log e igual a 200Mb
    max log size = 200000
    # Nivel de Coleta de Log
    log level = 1 auth:5

# Configuracao do Servico de Autenticacao Local
    server role = standalone server
    passdb backend = tdbsam
    obey pam restrictions = yes
    unix password sync = yes
    passwd program = /usr/bin/passwd %u
    passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
    pam password change = yes
    map to guest = bad user
    usershare allow guests = yes

###########################
# TUNNING SAMBA
###########################
    strict locking = no
    read raw = yes
    write raw = yes
    oplocks = yes
    max xmit = 65535
    deadtime = 15
    getwd cache = yes
    socket options = TCP_NODELAY
    create mask = 0777
    directory mask = 0777
    strict allocate = yes
    min receivefile size = 16384
    use sendfile = true
    aio write size = 16384
    inherit owner = yes
    inherit group = yes

###################################   
# CONFIGURACAO DA LIXEIRA
###################################
    vfs objects = full_audit,recycle
    recycle:version = yes
    recycle:repository = /var/samba/trash/%U
    recycle:keeptree = yes
    recycle:exclude = *.mp3, *.zip, *.rar
    recycle:exluce_dir = tmp,cache

###################################
# CONFIGURACAO DE Auditoria (DESATIVADA, para ativar remova os '#" das linhas abaixo)
###################################
    #full_audit:success = write, unlink, rename, rmdir, chmod, chown
    #full_audit:prefix = %u|%S
    #full_audit:failure = none
    #full_audit:facility = local5
    #full_audit:priority = notice

###################################
# Sessao que apresenta a Definicao a serem usadas no compartilhamento por pasta
###################################

[printers]
   comment = All Printers
   browseable = no
   path = /var/spool/samba
   printable = yes
   guest ok = no
   read only = yes
   create mask = 0700

[print$]
   comment = Printer Drivers
   path = /var/lib/samba/printers
   browseable = no
   read only = yes
   guest ok = no

###################################
# CONFIGURACAO DE COMPARTILHAMENTO DA LIXEIRA.
###################################

[Lixeira]
	path = /var/samba/trash/%U
	writable = yes
	create mask = 0700
	directory mask = 0700
	browseable = yes

###################################
# Pasta que vai aparecer na REDE.
###################################
[multimidia]  
	path = /home/${whoime}/multimidia
	browseable = yes
	writable = yes
	guest ok = yes
	
EOF

# Instalando o Sonarr
# Requisitos
sudo apt install mono-devel -y
sudo apt install gnupg ca-certificates -y
# Instalando o repositorio official.
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xA236C58F409091A18ACA53CBEBFF6B99D9B78493
echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list
sudo apt update
sudo apt install nzbdrone -y
sudo cat <<EOF > /etc/systemd/system/sonarr.service
[Unit]
Description=Sonarr Daemon
After=network.target

[Service]
# Change and/or create the required user and group.
User=$userLocal
Group=$userLocal

# The UMask parameter controls the permissions of folders and files created.
#UMask=002

# The -data=/path argument can be used to force the config/db folder
ExecStart=/usr/bin/mono --debug /opt/NzbDrone/NzbDrone.exe -nobrowser

Type=simple
TimeoutStopSec=20
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable --now sonarr.service
##
## AGORA SO ACESSAR O NAVEGADOR NO http://localhost:8989/
##

# Install Jacket
curl -L -O $( curl -s https://api.github.com/repos/Jackett/Jackett/releases | grep Jackett.Binaries.LinuxAMDx64.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
tar -xvzf Jackett.Binaries.LinuxAMDx64.tar.gz
sudo mv Jackett /opt
cd /opt/Jackett
sudo ./install_service_systemd.sh
##
## AGORA SO ACESSAR O NAVEGADOR NO http://localhost:9117/
##

# Instalando qBittorrent
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt-get update && sudo apt-get install qbittorrent

# Instalando o Radarr
sudo apt install curl mediainfo -y
curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
ls Radarr*
tar -xvzf Radarr.*.linux.tar.gz
sudo mv Radarr /opt
sudo mono /opt/Radarr/Radarr.exe
sudo cat <<EOF > /etc/systemd/system/radarr.service
[Unit]
Description=Radarr Daemon
After=syslog.target network.target

[Service]
# Change and/or create the required user and group.
User=raphaelmaria
Group=raphaelmaria

Type=simple

# Change the path to Radarr or mono here if it is in a different location for you.
ExecStart=/usr/bin/mono --debug /home/vh/Radarr/Radarr.exe -nobrowser
TimeoutStopSec=20
KillMode=process
Restart=on-failure

# These lines optionally isolate (sandbox) Radarr from the rest of the system.
# Make sure to add any paths it might use to the list below (space-separated).
#ReadWritePaths=/opt/Radarr /path/to/movies/folder
#ProtectSystem=strict
#PrivateDevices=true
#ProtectHome=true

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable --now radarr.service

##
## AGORA SO ACESSAR O NAVEGADOR NO http://localhost:7878/
##