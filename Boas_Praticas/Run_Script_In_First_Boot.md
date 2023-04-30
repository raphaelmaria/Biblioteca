Para fazer um script rodar na primeira vez que a máquina com Ubuntu inicia, você pode usar o serviço Systemd.

Siga estes passos:

Crie o seu script: Crie o seu script em um local seguro. Por exemplo, você pode criar o seu script em "/usr/local/bin" usando o seguinte comando:


sudo nano /usr/local/bin/meu_script.sh

Adicione as permissões de execução: Adicione as permissões de execução ao seu script com o seguinte comando:

sudo chmod +x /usr/local/bin/meu_script.sh

Crie um arquivo de serviço do Systemd: Crie um arquivo de serviço do Systemd em "/etc/systemd/system" com o seguinte comando:


sudo nano /etc/systemd/system/meu_servico.service
Adicione o conteúdo do arquivo de serviço: Adicione o seguinte conteúdo ao arquivo de serviço:


[Unit]
Description=Meu script de inicialização
ConditionPathExists=!/path/to/flag/file

[Service]
ExecStart=/usr/local/bin/meu_script.sh

[Install]
WantedBy=multi-user.target

Neste arquivo, você precisa definir a descrição do serviço e o caminho para o seu script. O "ConditionPathExists" é usado para verificar se um arquivo de sinalização existe antes de iniciar o serviço. Isso garante que o script seja executado apenas na primeira inicialização. O arquivo de sinalização deve ser criado em seu script, assim que ele for executado.

Recarregue o Systemd: Recarregue o Systemd com o seguinte comando para que ele reconheça o novo serviço:


sudo systemctl daemon-reload

Ative o serviço: Ative o serviço com o seguinte comando:


sudo systemctl enable meu_servico.service

Reinicie o sistema: Reinicie o sistema para ver o seu script sendo executado na primeira inicialização.

Com esses passos, o seu script será executado apenas na primeira inicialização da máquina com Ubuntu. Se você quiser executá-lo em todas as inicializações, remova a linha "ConditionPathExists" do arquivo de serviço.