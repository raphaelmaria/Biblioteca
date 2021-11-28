#!/bin/sh

# Credenciais AWS
$accessKey = "AKIAQ2Z34DMBMJA6YAVW"
$secretKey = "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"
$region = "us-east-1"
$bucket = "rmtechfiles"


# VARIAVEIS
$downloadPath = "/rmtech"
$urlAWSDownloadEmby = "Applications/EmbyUpdate"

#Install AWS-CLI in Linux
sudo apt install awscli -y 

# AWS Configure
# aws configure set aws_access_key_id AKIAQ2Z34DMBMJA6YAVW; aws configure set aws_secret_access_key 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; aws configure set default.region us-east-1
aws configure set aws_access_key_id $accessKey; aws configure set aws_secret_access_key $secretKey; aws configure set default.region $region

if [ -d "$downloadPath"]; then
    echo "A pasta de Download existe, seguindo com a atualizacao!"
    sudo rm -rf /rmtech/EmbyUpdate
    sudo aws s3 cp "Applications/EmbyUpdate" /rmtech/EmbyUpdate --recursive
    sudo aws s3 cp $urlAWSDownloadEmby /rmtech/EmbyUpdate --recursive
    sudo chmod -R 777 /rmtech/EmbyUpdate
    sudo systemctl stop embyserver
    
    # Instalacao em maquinas
    # sudo dpkg -i /rmtech/EmbyUpdate/x64/emby-server-deb_*_amd64.deb

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
    sudo aws s3 cp $urlAWSDownloadEmby /rmtech/EmbyUpdate ---recursive
    sudo chmod -R 777 /rmtech/EmbyUpdate
    sudo systemctl stop embyserver
    
    # Instalacao em maquinas
    # sudo dpkg -i /rmtech/EmbyUpdate/x64/emby-server-deb_*_amd64.deb

    # Instalacao em Raspberry
    sudo dpkg -i /rmtech/EmbyUpdate/Arm64/emby-server-deb_*_arm64.debb

    sudo systemctl enable embyserver --now
    sudo systemctl start embyserver
    echo "Atualizacao concluida com sucesso!"
fi




