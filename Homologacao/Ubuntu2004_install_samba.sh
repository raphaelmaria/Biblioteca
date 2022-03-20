#!/usr/bin/env bash

# Instalacao do Samba
sudo apt-get -y install samba samba-client samba-tools


# Variaveis Configuracao do Samba
varServerName = $(dialog )

echo "Selecione quantas pasta deseja compartilhar: "
echo "  1) 1 pasta"
echo "  2) 2 pastas"
echo "  3) 3 pastas" 

read n
case $n in
  1) 
    sudo mv /etc/samba/smb.conf /home/$WHOAMI/
    ;;
  2) 
    ;;
  3) 
    ;;

  *) echo "invalid option";;
esac

# Teste das configuraçoes do Samba
testparm
sudo systemctl enable smb --now
sudo systemctl enable nmb --now
