#!/bin/sh

# Credenciais AWS
region = 
role_arn = 


# VARIAVEIS
$downloadPath = "/rmtech"
$urlAWSDownloadEmby = "s3://rmtechfiles/Applications/EmbyUpdate"

#Install AWS-CLI in Linux
sudo apt install awscli -y 

sudo aws s3 cp "s3://rmtechfiles/Applications/EmbyUpdate" .
if [ -d "$downloadPath"]; then
    echo "A pasta de Download existe, seguindo com a atualizacao!"
    sudo aws s3 cp $urlAWSDownloadEmby /rmtech
    sudo chmod -R 777 /rmtech/EmbyUpdate
    sudo systemctl stop embyserver
    # Instalacao em maquinas
    sudo dpkg -i /rmtech/EmbyUpdate/x64/emby-server-deb_*_amd64.deb

    # Instalacao em Raspberry
    sudo dpkg -i /rmtech/EmbyUpdate/Arm64/emby-server-deb_*_arm64.deb

    sudo systemctl enable embyserver --now
    sudo systemctl start embyserver
    echo "Atualizacao concluida com sucesso!"

else
    echo "A Pasta de Download nao existe!"
    
    sudo mkdir /rmtech
    echo "A pasta de Download foi criada"
    echo "Iniciando processo de instalacao!"
    sudo chmod -R 777 /rmtech
    sudo aws s3 cp $urlAWSDownloadEmby /rmtech
    sudo chmod -R 777 /rmtech/EmbyUpdate
    sudo systemctl stop embyserver
    
    # Instalacao em maquinas
    sudo dpkg -i /rmtech/EmbyUpdate/x64/emby-server-deb_*_amd64.deb

    # Instalacao em Raspberry
    sudo dpkg -i /rmtech/EmbyUpdate/Arm64/emby-server-deb_*_arm64.debb

    sudo systemctl enable embyserver --now
    sudo systemctl start embyserver
    echo "Atualizacao concluida com sucesso!"
fi




