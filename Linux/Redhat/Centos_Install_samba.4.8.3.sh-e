#!/bin/sh
echo "
#######        Criado por Raphael Maria             ##########
#######        http://www.raphaelmaria.com.br       ##########
#######        Versão desta Configuracao 2.1        ##########
#######        Compativel com CenOS 7 e 8           ##########
#######        Versao Samba 4.10.4                  ##########
#######        30 de Março de 2020                  ##########"

# Instalação de softwares básicos.
yum -y install dialog wget tar unzip vim make gcc dnf autoconf automake epel-release 

##### VARIAVEIS
#VARHOSTNAME=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
#VARIPADDRESS=$(dialog --stdout --inputbox 'Insira o IP ADDRESS do hostname desta maquina: ' 0 0)
#VARGATEWAY=$(dialog --stdout --inputbox 'Insira o GATEWAY do hostname desta rede: ' 0 0)


#hostnamectl set-hostname $VARHOSTNAME
# Altera somente o IP Address de DHCP para FIXO com o ip designado anterimente.
#VARINTERFACE=$(nmcli con show | tail -1 | awk '{print $1}')
#nmcli con modify $VARINTERFACE ipv4.method manual ipv4.addresses $VARIPADDRESS/24 ipv4.gateway $VARGATEWAY ipv4.dns 8.8.8.8,8.8.4.4,1.1.1.1
#nmcli con up $VARINTERFACE

# INSTALACOES COMPLEMENTARES E UPDATES
yum -y install ansible
yum provides pip
yum install python2-pip -y
pip2 install pip --upgrade
pip2 install ansible
pip2 install ansible --upgrade
yum check-update
yum update -y

# INSTALACAO DO PAINEL DE CONTROLE PARA SERVIDOR VIA WEB
yum -y install cockpit
systemctl enable --now cockpit.socket

# SETUP SERVIDOR
systemctl stop firewalld
systemctl disable firewalld

yum -y install samba samba-client samba-common

mv /etc/samba/smb.conf /etc/samba/smb.conf.original
mkdir -p /mnt/storage
chcon -Rt samba_share_t /mnt/storage/*
chmod -R 0770 /mnt/storage
chown -R root:root /mnt/storage
ulimit -n 16384
echo "* - nofile 16384" >> /etc/security/limits.conf

mkdir -p /mnt/samba/logs
chmod -R 777 /mnt/samba/logs


#### ATENCAO ####
# esta linha ainda não esta funcional
VARSHARE=$(dialog --stdout --inputbox 'Insira o nome  desejado do Share: ' 0 0)
VARPATH=$(dialog --stdout --inputbox 'Insira o URL real da pasta: ' 0 0)
VARUSER=$(dialog --stdout --inputbox 'Insira o nome do usuario: ' 0 0)
VARPASS=$(dialog --stdout --inputbox 'Insira uma senha: ' 0 0)

smbpasswd -a $VARUSER -p $VARPASS'''

'''
Para criar usuários no samba, basta digitar adduser [Nome desejado]
e depois smbpasswd -a [Nome do usuario criado] e inserir a senha.
depois disso adicione o mesmo nome no share criado.
'''

#### Script SAMBA FOR CENTOS 7 e 8  ####
#### Atualizado ate 30/03/2020      ####
echo " # 
##############################################################
#######        Criado por Raphael Maria             ##########
#######        http://www.raphaelmaria.com.br       ##########
#######        Versão desta Configuracao 2.1        ##########
#######        Compativel com CenOS 7 e 8           ##########
#######        Versao Samba 4.10.4                  ##########
#######        30 de Março de 2020                  ##########
##############################################################
[global]
#####################################
####     Configuracao de REDE   #####
#####################################

    [global]
	workgroup = WORKGROUP
	netbios name = $HOSTNAME
	security = user

    
###################################
####       TUNNING SAMBA     ######

strict locking = no
read raw = yes
write raw = yes
oplocks = yes
max xmit = 65535
deadtime = 15
getwd cache = yes
socket options = TCP_NODELAY	
###################################

#########################################
########      LOGS DO SAMBA    ##########

log file = /var/log/samba/%m.log
# Tamanho de Log e igual a 200Mb
max log size = 200000
# Nivel de Coleta de Log
log level = 1 auth:5
##########################################

###########################################################################################
#########                              AUDITORIA                                  #########
    vfs objects = full_audit
    
    full_audit:success = open, opendir, write, unlink, rename, mkdir, rmdir, chmod, chown
    log file = /mnt/share/logs/%U.log
    max log size = 100
    vfs objects = full_audit
    full_audit:prefix = %u|%I|%S|%
############################################################################################

######################################################################################
####                     Compartilhamento de Arquivos                              ###

    ['$VARSHARE']
        comment = Accounts data directory
	    path = '$VARPATH'
	    public = yes
	    writable = yes
	    veto files = *.exe, *.tar, *.gz, *.sh, .thumbs, .thumbs, .DS, .DS*
        #Coloque aqui o nome dos usuários que teram acesso a esse repositorio
        valid users = '$VARUSER'


        vfs objects = recycle
	    recycle:repository = Lixeira
	    recycle:keeptree = yes
	    recycle:versions = yes
        recycle:exclude = [Digite as extensoes que seram apagadas diretamente sem passar na lixeira, ex.: *.mp3, *.mkv, ... ] 
    
    
    [LOGS]
        path=/mnt/share/logs
        browseable = true
        valid users = admin
        admin users = admin
        
 ####################################################################################################" > /etc/samba/smb.conf

dialog --msgbox "SAMBA e PASTA configuradas com sucesso, para acessar use \\$VARHOSTNAME\\$varshare" 0 0
dialog --msgbox "Sua configuração foi concluida \nAcesse a gerencia deste através do endereço \nhttps://$VARIPADDRESS:9090  \nusando o usuário de logado desta sessão do shell" 0 0
