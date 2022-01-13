# Projeto - Confecção de Imagem Linux

Distro = Ubuntu 20.04
Kernel Version = 

Tipo de Hardware Homologado: Virtual Machine
Processador: Intel i7 #6th Generation - 2 Cores 3.40GHz
Memória: 4 GB Ram DDR 4 2133Mhz
SSD: 60 GB SATA #3 Generation


## Como instalar rodar o script:

Instalar o comando CURL antes de rodar a linha abaixo:
$ sudo apt install curl -y

Via download do GitHub
$ curl -s https://raw.githubusercontent.com/raphaelmaria/deploy/master/projetos/SondaIT/script_instalacao_sondait.sh | sudo bash

Via download do AWS S3 Bucket
$ curl -s https://rmtechfiles.s3.amazonaws.com/ScriptFiles/SONDAIT/scripts/script_instalacao_sondait.sh | sudo bash

## Observações
Os Softwares abaixo são exclusivos para uso em Windows.
Existe um meio de rodar usando um emulação chamada Wine, mas não recomendo pois da muitos crashs nas aplicações.
WinSCP
WinMERGE
CynWin
EnterpriseArchitect

## Softwares abaixo ainda faltam informaçoes:
DLP
PROXY


## Criptografia

É possivel efetuar a criptografia após a instalação, mas isso só é possivel fazer em uma unica pasta, alocada em uma partição a parte.
Em detalhes, se a partição /home estiver em um disco diferente ou partição a parte do "/", basta instalar o CryptSetup e seguir esse [artigo](https://linuxdicasesuporte.blogspot.com/2019/11/criptografar-sua-particao-home-no.html).
Com analise no contéudo, se torna inviavel, pq o processo precisa ser feito manual exigindo um conhecimento mais amplo do sistema operacional linux e sua linha de comando em Bash.

** Tela de Criptografia que é executada na inicialização do sistema Linux **
![Linux Boot](https://imgur.com/a/7CKO3sL)


## Criação de Imagem ISO customizada

** Ferramenta Pesquisadas: **
Wimlib - Descartada
Motivo: não funciona para Linux

Constructor - Descartada
Motivo: Ferramenta descontinuada

Remastersys - Descartada
Motivo: Ferramenta descontinuada

Remastersys-gtk - Descartada
Motivo: Ferramenta não é compativel com Ubuntu 20.04 LTS

Pinguy Builder - Em Teste
Motivo: versão 5.2.1 suporta o Ubuntu 20.04 LTS

Instalação dentro da VM:
Pinguy Builder para Ubuntu 19 ou acima - ![Fonte](https://www.edivaldobrito.com.br/iso-personalizada-do-ubuntu/)

Linhas de comando estruturadas para Script de download:
urlPinguyBuild="https://sourceforge.net/projects/pinguy-os/files/ISO_Builder/pinguybuilder_5.2-1_all.deb/download"
wget $urlPinguyBuild -O pinguybuilder.deb
sudo dpkg -i pinguybuilder.deb
sudo apt-get install -f

Após instalado use a opções na seguinte ordem:
1. Opção "3.Clean working directory" para remover cache.
2. Opção "2b.Backup(dist-mode) ou 2c.Backup (cdfs-only)"
3. Os arquivos será armazenados no seguinte diretorio "/home/pinguybuilder/pinguybuilder/ISOTMP"

## Criando o arquivo .ISO
Comandos usados do proprio Linux:
$ genisoimage -allow-limited-size -l -J -r -iso-level 3 -o <output.iso> <source file or directory>

** Linha de Exemplo: **
$ genisoimage -allow-limited-size -l -J -r -iso-level 3 -o /tmp/[Nome desejado].iso> /home/pinguybuilder/pinguybuilder/ISOTMP

$ mkisofs -allow-limited-size -l -J -r -iso-level 3 -o <output.iso> <source file or directory>

** Linha de Exemplo: **
$ mkisofs -allow-limited-size -l -J -r -iso-level 3 -o /tmp/[Nome desejado].iso> /home/pinguybuilder/pinguybuilder/ISOTMP

------------------------------------------------------
## Referencias usadas para desenvolvimento do Projeto e atualização pessoal
-------------------------------------------------------
WIMLIB
Para criar imagem em wim:
Nao funciona para Linux
https://wimlib.net/
-------------------------------------------------------
Pinguy Builder para Ubuntu 19 ou acima - ![Fonte](https://www.edivaldobrito.com.br/iso-personalizada-do-ubuntu/)
download:
urlPinguyBuild="https://sourceforge.net/projects/pinguy-os/files/ISO_Builder/pinguybuilder_5.2-1_all.deb/download"
wget $urlPinguyBuild -O pinguybuilder.deb
sudo dpkg -i pinguybuilder.deb
sudo apt-get install -f
---------------------------------------------------------

