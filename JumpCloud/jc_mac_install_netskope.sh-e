#!/bin/bash

# Qual o nome do programa que vai ser pesquisado nas tarefas
appTarget="netskope"

# valida se existe serviço ou task ativa no equipamento.
if pgrep -if $appTarget > /dev/null
then
    # Se existe, apenas registrar o retorno de positivo.
	echo "Netskope encontrado e ativo!"
else
	# Approve Extension Netskope
	# Fonte: https://community.jamf.com/t5/jamf-pro/netskope-tenant-automation/m-p/225270
    # Para aprovação de alguns apps que necessitam acessar o hardware do equipamento, a apple limita por um codigo de autorização, a linha abaixo adiciona essa aprovação
	sudo /usr/sbin/spctl kext-consent add 24W52P9M7W
    # Coleta  user atualmente logado
	USER=$(users)
    # Inicia o download, nao esqueça de trocar o CONTOSO-BR usado como exemplo para o seu tenant
	curl https://download-contoso-br.goskope.com/dlr/mac/get --output /tmp/NSClient.pkg
    # Inicia o download do script necessário da JAMF
    curl "https://raw.githubusercontent.com/raphaelmaria/Biblioteca/master/JumpCloud/IDPmode_Install.sh" | sudo bash
    # Aplica a permissao para instalação, caso ocorra erro use o 775
	sudo chmod 755 /tmp/IDPmode_install.sh
    # faz a configuração iniciar para que ao instalar o client seja reconhecido.
	sudo /tmp/IDPmode_install.sh 1 2 3 idp goskope.com contoso-br 0 peruserconfig
	# Instala o client
    sudo installer -pkg /tmp/NSClient.pkg -target /
fi
exit