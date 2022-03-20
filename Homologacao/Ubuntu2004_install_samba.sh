#!/usr/bin/env bash

# Instalacao do Samba
sudo apt-get -y install samba samba-client samba-tools


# Variaveis Configuracao do Samba
varServerName = $(dialog )

echo "Qual a quantidade de pastas compatilhadas você precisa?"
PS3='Escolha uma opção: '
options=("Para 1 pasta" "Para 2 pastas" "Para 3 pastas" "Sair" )
do
    case $opt in
        "Para 1 pasta")

            ;;
        "Para 2 pastas")

            ;;
        "Para 3 pastas")

            ;;
        "Sair")
            break
            ;;
        *) echo "A opção inserida é invalida";;
    esac
done

# Teste das configuraçoes do Samba
testparm
sudo systemctl enable smb --now
sudo systemctl enable nmb --now
