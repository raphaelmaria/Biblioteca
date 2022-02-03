# Projeto - Confecção de Imagem Linux

Distro = Ubuntu 20.04

Kernel Version = 5.0

Tipo de Hardware Homologado: Virtual Machine
Processador Intel i7 #6th Generation - 2 Cores 3.40GHz
Memória 4 GB Ram DDR 4 2133Mhz
SSD 60 GB SATA #3 Generation


## Como instalar rodar o script:

Instalar o comando CURL antes de rodar a linha abaixo:
$ sudo apt install curl -y


## Instalar usando o [Ubuntu 20.04](https://ubuntu.com/download/desktop/thank-you?version=20.04.3&architecture=amd64)

Via download do GitHub
$ curl -s https://raw.githubusercontent.com/raphaelmaria/deploy/master/projetos/SondaIT/config_ubuntu2004.sh | sudo bash

$ curl -s https://alelodev.s3.amazonaws.com/pre_ubuntu2004.sh | sudo bash
$ curl -s https://alelodev.s3.amazonaws.com/ubuntu2004.sh | sudo bash
## Instalar usando o [Ubuntu 21.10](https://ubuntu.com/download/desktop/thank-you/?version=21.10&architecture=amd64)
Via download do GitHub
$ curl -s https://raw.githubusercontent.com/raphaelmaria/deploy/master/projetos/SondaIT/config_ubuntu2110.sh | sudo bash

Via download do S3 AWS - Link Curto
$ curl -s https://alelodev.s3.amazonaws.com/ubuntu2004.sh | sudo bash

## Observações
Os Softwares abaixo são exclusivos para uso em Windows.
Existe um meio de rodar usando um emulação chamada Wine, mas não recomendo pois da muitos crashs nas aplicações.
WinSCP
WinMERGE
CynWin
EnterpriseArchitect

## Softwares abaixo ainda faltam informaçoes:
# Symantic DLP - Não existe compatibilidade para o Linux

# INSTALACAO FILTRO WEB (PROXY)
# FORCE POINT - Não existe compatibilidade para o Linux (https://www.forcepoint.com/pt-br/product/dlp-data-loss-prevention)

# Instalação CHECKPOINT SSL-VPN
#FONTE DE PESQUISA: 
#http://www.pr.gov.br/vpn/cp_linux/
#https://pedroeml.github.io/checkpoint-mobile-access-vpn/


## Criptografia

É possivel efetuar a criptografia após a instalação, mas isso só é possivel fazer em uma unica pasta, alocada em uma partição a parte.
Em detalhes, se a partição /home estiver em um disco diferente ou partição a parte do "/", basta instalar o CryptSetup e seguir esse [artigo](https://linuxdicasesuporte.blogspot.com/2019/11/criptografar-sua-particao-home-no.html).
Com analise no contéudo, se torna inviavel, pq o processo precisa ser feito manual exigindo um conhecimento mais amplo do sistema operacional linux e sua linha de comando em Bash.

### Processo para ativar o LVM e a CRIPTOGRAFIA do disco

[Passo 01](https://imgur.com/DJRI8hC)
1. Selecione a opção "Apagar disco e instalar Ubuntu"
2. Clique em "Funcionalidades Avançadas"
3. Será aberto o pop-up abaixo

[Passo 02](https://imgur.com/6jCJBTY)
1. Marque o check-box que permite o uso do LVM na nova instalação
2. Marque o check-box que ativa a criptografia a parte da nova instalação

[Passo 03](https://imgur.com/0HTsf8v)
1. Defina uma senha e a confirme logo em seguinta.
2. Clique em avançar para prosseguir com a instalação

[Passo 04](https://imgur.com/0HTsf8v)
1. Essa tela será exibida todas as vezes que o sistema reiniciar.
Obs.: Pode ser que em algumas maquinas fisicas, a senha seja armazenada dentro da BIOS da placa-mão como uma forma de check-in, validando a chave entre disco e máquina.

Criação de Imagem ISO customizada

Não existe mais essa possibilidade para o Ubuntu 20.04 ou superior.
Devido a grande parte das ferramentas terem sido descontinuadas e não ter um outro meio de copilar.

**Ferramenta Pesquisadas:**
Wimlib - Descontinuada
Constructor - Descontinuada
Remastersys - Descontinuada
Remastersys-gtk - Descontinuada
Pinguy Builder - Descontinuada

------------------------------------------------------
## Referencias usadas para desenvolvimento do Projeto e atualização pessoal
WIMLIB: [Para criar imagem em wim](https://wimlib.net/)

[Copiar para .ISO](https://docs.google.com/document/d/1d33KWBf2NsFJdFqPR3-h6HuL9dqY4s5ZNlRyfes9p8g/edit?usp=sharing)
-------------------------------------------------------

