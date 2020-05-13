#!/bin/sh
echo "
#######        Criado por Raphael Maria             ##########
#######        http://www.raphaelmaria.com.br       ##########
#######        Versão desta Configuracao 2.1        ##########
#######        Compativel com CenOS 7 e 8           ##########
#######        Versao Samba 4.10.4                  ##########
#######        30 de Março de 2020                  ##########"

# Variaveis
# INSTALACOES COMPLEMENTARES E UPDATES
yum -y install epel-release

yum -y install wget nss dkms git dnf snapd vim ansible libselinux-python nfs-utils tcsh libXext libSM libXrender Xvfb xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps
yum install centos-release-scl -y
yum install rh-python36 -y
scl enable rh-python36 bash

# INSTALACAO DO PAINEL DE CONTROLE PARA SERVIDOR VIA WEB
yum -y install cockpit
systemctl enable --now cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --reload

echo " PAINEL DE GESTADO DO SERVIDOR INSTALADO COM SUCESSO PARA ACESSAR "
echo " UTILIZE DIGITE IP:9090 EM UM NAVEGADOR "
echo " PARA FAZER LOGIN USE OS DADOS DOS USUARIOS CRIADOS LOCALMENTES NA MAQUINA "    

# Pacotes para instalacao
yum -y install samba samba-client samba-common

# SETUP SERVIDOR
echo "Nome do Servidor:"
read HOSTNAME
hostnamectl set-hostname $HOSTNAME

nmcli con show
echo "DIGITE O NOME DA PLACA DE REDE CONECTADA: "
read INTERFACE
echo "IP DESTINADO AO SERVIDOR"
read IPADDRESS
echo "DIGITE O GATEWAY DA REDE:"
read GATEWAY


nmcli connection modify $INTERFACE ipv4.method manual ipv4.addresses $IPADDRESS/24 ipv4.gateway $GATEWAY ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search 
nmcli connection up $INTERFACE

systemctl stop firewalld
systemctl disable firewalld

echo "Nome do Compartilhamento: "
echo "Exemplo: DADOS"
read varshare

echo "Digite o caminho completo da pasta que deseja compartilhar: "
echo "Exemplo: /mnt/dados"
read varpath

yum -y install samba samba-client samba-common

mv /etc/samba/smb.conf /etc/samba/smb.conf.original
mkdir -p /mnt/storage
chcon -Rt samba_share_t /mnt/storage
chmod -R 0770 /mnt/storage
chown -R root:root /mnt/storage
ulimit -n 16384
echo "* - nofile 16384" >> /etc/security/limits.conf

mkdir -p /mnt/samba/logs
chmod -R 777 /mnt/samba/logs


#### ATENCAO ####
# esta linha ainda não esta funcional
''' echo "Digite o nome do usuario desejado: "
# read USER
# adduser $USER
# echo "Digite a senha: "
# read PWD
# smbpasswd -a $USER -p $PWD'''

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

    [$varshare]
        comment = Accounts data directory
	    path = $varpath
	    public = yes
	    writable = yes
	    veto files = *.exe, *.tar, *.gz, *.sh, .thumbs, .thumbs, .DS, .DS*
        #Coloque aqui o nome dos usuários que teram acesso a esse repositorio
        valid users = [usuario criado anteriormente]


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