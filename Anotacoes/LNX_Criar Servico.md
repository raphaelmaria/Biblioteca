# Criar Service para iniciar automaticamente com a maquina

## Local que o arquivo 'service' precisa existir:
/etc/systemd/system/bazarr.service


## Linhas que precisa ter no arquivo
[Unit]
Description={Descriçao do que faz ou identificacao}
After=[ Inicia o serviço depois dos gatilhos presentes na pasta [*/usr/lib/systemd/system/*] ter iniciado com sucesso ]


# After=syslog.target network.target sonarr.service radarr.service

[Service]
WorkingDirectory=[ Diretorio que vai rodar o script ]
User=root
Group=root
Restart=on-failure
RestartSec=5
Type=simple
ExecStart=[ Script que vai rodar ]
KillSignal=SIGINT
TimeoutStopSec=20
SyslogIdentifier=[ Identificação do que vai ser nomeada no Log]
ExecStartPre=/bin/sleep 30

[Install]
WantedBy=multi-user.target
