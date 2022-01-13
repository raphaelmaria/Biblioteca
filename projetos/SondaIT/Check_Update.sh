#!/bin/sh

'''
Script de atualização para o time de desenvolvimento
EMPRESA: ALELO
CRIADOR: Raphael A O Maria
SITE: www.raphaelmaria.com.br
WHATSAPP: +55 11 9 6061-1839
MAIL: raphaelmaria@outlook.com
VERSION: 1.0
CREATE: 7 de Janeiro de 2022
CHANGE: Read the document Version_Notes.txt

COMMAND FOR USE SCRIPT: 
sed -i 's/\r$//' start.sh
sudo chmod +X start.sh
sudo chmod 777 start.sh
sudo ./start.sh
'''

################# ROTINA PARA VERIFICAR SE SEMPRE 
urlUpdates="https://rmtechfiles.s3.amazonaws.com/ScriptFiles/SONDAIT/scripts/Check_Update.sh"
cd /root
sudo wget -O 'Check_Updates.sh' $urlUpdates
sudo chmod -R 777 /root
sudo chmod +X /root/*.sh
sudo ln -s /root/Check_Updates.sh /etc/cron.weekly/Check_Updates.sh


######## ATUALIZACAO DO SISTEMA OPERACIONAL ################
sudo apt update
sudo apt install --fix-broken -y
sudo apt upgrade -y
sudo apt distro-upgrade -y
sudo apt autoremove -y

###################################################################
###> ATUALIZACAO DE APLICATIVO
sudo snap refresh intellij-idea-community



################ ATUALIZACAO CONCLUIDA ############################
dialog \
    --title "Atualização Semanal :wqFinalizada!"  \
    --msgbox "Instalação foi efetuada com sucesso!" \
    0 0