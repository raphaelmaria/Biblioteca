#!/usr/bin/env bash
WHOAMI = '( whoami )'
echo "Recomendado rodar esse script como ROOT da maquina!"
echo "Este é o usuário rodando script atualmente, $WHOAMI"
if [ "$WHOAMI" == "root"]
then
    echo "Seguindo com a instalacao:"
    sudo apt-get -y install curl
    sudo curl -s https://alelodev.s3.amazonaws.com/ubuntu2004.sh | sudo bash
else
    echo "Forçado uso do ROOT!"
    sudo apt-get -y install curl
    sudo curl -s https://alelodev.s3.amazonaws.com/ubuntu2004.sh | sudo bash
fi


