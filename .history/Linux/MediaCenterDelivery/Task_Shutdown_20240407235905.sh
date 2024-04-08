#!/bin/sh
#
#
# Script de Mensagens Aleatorias
messageList="/scripts/message.txt"
lineNumber=$(wc -l < "$messageList")
lineRandom=$((RANDOM % "$lineNumber" + 1 ))
message=$(sed -n "${lineRandom}p" "$messageList")

# Configuracao do Telegram
bot='ID do '
chatId='-1001764367092'

# Configuracao de Log
data=$(date +%Y-%m-%d)
log="/var/log/rotinas/rotinas.log" 

# Tarefas 
sudo systemctl stop plexmediaserver.service 
echo "'$data' - Plex desligado com sucesso!" | sudo tee -a $log 

sudo systemctl stop emby-server.service
echo "'$data' - Emby deslogadp com sucesso!" | sudo tee -a $log

sudo systemctl stop sonarr.service
echo "'$data' - Sonarr parado!" | sudo tee -a $log

sudo systemctl stop radarr.service
echo "'$data' - Radarr parado!" | sudo tee -a $log

sudo systemctl stop jackett.service
echo "'$data' - Jackett parado!" | sudo tee -a $log

sudo systemctl stop qbittorrent-nox.service
echo "'$data' - QBittorrent parado!" | sudo tee -a $log

sudo umount -a
echo "'$data' - Unidades de Armazenamento desmontadas com seguranca!" | sudo tee -a $log

curl -s -X POST "https://api.telegram.org/bot$bot/sendMessage" -d "chat_id=$chatId" -d "text=$message"
echo "'$data' - Mensagem enviada para usuarios!" | sudo tee -a $log

sudo poweroff 