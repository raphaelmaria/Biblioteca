#!/bin/sh
# Monitora o equipamento e encaminha a mensagem ao e-mail
# Esse SH deve se colocado no CronTAB da maquina /etc/crontab atraves de um editor de Txt
# echo "*/5     *   *   *   *   root    /root/zpool_status.sh" >> /etc/crontab
# Criado por Raphael Maria
# Em 11 de Novembro de 2019
# 

STATUS=`zpool status -x`
SERVER=`hostname`
LOG=/tmp/zpool_status.log
MAIL=" E-mails aqui "
if [ "$STATUS" == "all pools are healthy" ]
    then
        echo -e "`date`\n\nPool OK" > "$LOG"
    else
        echo "Bad Pool"
        zpool status > "$LOG"
        echo -e "\n\n" >> "$LOG"
        df -h >> "$LOG"
        cat "$LOG" | mail -s "ZFS Alert: $SERVER" "$MAIL"
fi
