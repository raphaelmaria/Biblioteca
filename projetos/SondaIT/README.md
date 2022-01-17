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

Teste - Link Curto
$ curl -s https://bityli.com/bOeWz | sudo bash

Via download do AWS S3 Bucket
$ curl -s https://rmtechfiles.s3.amazonaws.com/ScriptFiles/SONDAIT/scripts/script_instalacao_sondait.sh | sudo bash

Teste - Link Curto 
$ curl -s https://bityli.com/CMpPd | sudo bash
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

**Tela de Criptografia que é executada na inicialização do sistema Linux**
[Linux Boot](https://imgur.com/a/7CKO3sL)


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

