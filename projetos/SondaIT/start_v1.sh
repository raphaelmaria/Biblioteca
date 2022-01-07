#!/bin/sh

'''
Script de Instalação de Apps para o time de desenvolvimento
EMPRESA: x
CRIADOR: Raphael A O Maria
SITE: www.raphaelmaria.com.br
WHATSAPP: +55 11 9 6061-1839
MAIL: raphaelmaria@outlook.com
VERSION: 1.0
CREATE: 7 de Janeiro de 2022
CHANGE: Read the document Version_Notes.txt

COMMAND FOR USE SCRIPT: 
sudo chmod +X start.sh
sudo chmod 777 start.sh
sudo ./start.sh

'''

# VARIAVEIS - ITENS QUE PODEM MUDAR COM O TEMPO E NECESSIDADE

# ATUALIZACAO DOS PACOTES PADROES DO OS
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y

# INSTALACAO DOS PACOTES PADROES E ESSENCIAIS
sudo apt-get install -y update-manager-core
sudo apt install -y gcc ansible wget vim git-core
sudo apt install -y dialog tree tar unzip make autoconf automake

# INSTALACAO DE PACOTE MICROSOFT DONT NET-FRAMEWORK
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get install -y apt-transport-https
sudo apt-get install -y dotnet-sdk-5.0
sudo apt-get install -y aspnetcore-runtime-5.0
sudo apt-get install -y dotnet-runtime-5.0
sudo apt-get update

# INSTALACAO DO MOMO - BIBLIOTECA C++
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo apt install -y mono-devel

# CONFIGURACAO DO EQUIPAMENTO
# RENOMEANDO A MAQUINA
varHostname=$(dialog --stdout --inputbox 'Insira o nome  do hostname desta maquina: ' 0 0)
sudo hostnamectl set-hostname $varHostname
sudo mkdir /deploy
sudo chmod 777 /deploy

# INSTALACAO DO JAVA
urlJRE="https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245469_4d5417147a92418ea8b615e228bb6935"
sudo mkdir /usr/java/
cd /usr/java/
sudo wget $urlJRE
sudo tar zxvf jre-*u*-linux-x64.tar.gz
cd jre-*u*-linux-x64
sudo ./

# INSTALACAO DO WINE
sudo dpkg --add-architecture i386 
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt update
sudo apt -y install --install-recommends winehq-stable

# INSTALACAO DO SNAP SHOP (AGREGADOR INTELIGENTE DE APPS)
sudo snap install snap-store


# INSTALACAO DOS SOFTWARES SOLICITADOS
cd /deploy

# AndroidStudio;
'''
urlStudio="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2020.3.1.26/android-studio-2020.3.1.26-linux.tar.gz"
urlSDKManager="https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip"
sudo wget $urlStudio /deploy
sudo wget $urlSDKManager /deploy
sudo tar -xvf android-studio-*.tar.zip
cd 
sudo tar -xvf commandlinetools-linux-*_latest.zip
cd 
'''

sudo snap -y install android-studio --classic

#Cygwin;
'''
Esse Aplicativo é desenvolvido para Windows SOMENTE
https://cygwin.com/index.html
'''

#DBeaver;
urlDBeaver="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
sudo wget $urlDBeaver
sudo chmod 777 dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb

#Docker;
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
sudo apt update
sudo apt-get -y install docker-ce

#Eclipse;
'''
urlEclipse="https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2021-12/R/eclipse-inst-jre-linux64.tar.gz"
sudo wget $urlEclipse
sudo tar -xvf eclipse-inst-jre-linux64.tar.gz
cd 
'''
sudo snap install eclipse --classic


#EnterpriseArchitect;
'''
APP é PAGO (TRIAL PERMITIDO) e NATIVO PARA WINDOWS
SEU USO É POSSIVEL PORQUE USA O EMULADOR WINE
https://sparxsystems.com/products/ea/trial/request.html
'''
urlEnterpriseArch="https://www.sparxsystems.com/bin/easetup.msi"

#IntelliJ; 
'''
urlIntellij="https://download.jetbrains.com/idea/ideaIC-2021.3.1.tar.gz"
sudo wget $urlIntellij
sudo tar -xvf ideaIC-*.tar.gz
cd ideaIC-*
'''
sudo snap install intellij-idea-community --classic

#Node.js;
urlNodeJS="https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-x64.tar.xz"
sudo wget $urlNodeJS
sudo tar -xvf node-v*-linux-x64.tar.xz
cd node-v*-linux-x64

#Notepad++;
sudo snap install notepad-plus-plus

#Postman;
'''
urlPostman="https://dl.pstmn.io/download/latest/linux64"
'''
sudo snap -y install postman


#PyCharm;
sudo snap -y install pycharm-community --classic

#Buddy;
'''
Plataforma de Pipelines, não é necessario fazer a instalação, isso é uma ferramenta de integração com o git do projeto.
https://buddy.works/docs
A responsabilidade do uso fica por conta do Desenvolvedor.
'''
#SoapUI;
'''
Link do site para download do sh de instalacao
'''
urlSoapUI="https://s3.amazonaws.com/downloads.eviware/soapuios/5.6.1/SoapUI-x64-5.6.1.sh"
sudo chmod +X SoapUI-x64-5.6.1.sh
sudo chmod 777 SoapUI-x64-5.6.1.sh
sudo ./SoapUI-x64-5.6.1.sh

#SourceTree;
'''
O Source Tree é uma versão homologada para Windows e MacOSX.
Em analise ao desenvolvedor foi pontuado em uma thread da community que eles não tem nenhum interesse em desenvolver esse app para Linux:
https://community.atlassian.com/t5/Sourcetree-questions/SourceTree-for-Linux/qaq-p/255473
'''
#SQLDeveloper;
urlSQLDeveloper="https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-21.4.0.348.1716.zip"
urlJDK="https://www.oracle.com/webapps/redirect/signon?nexturl=https://download.oracle.com/otn/java/jdk/8u311-b11/4d5417147a92418ea8b615e228bb6935/jdk-8u311-linux-x64.tar.gz"
sudo mkdir /usr/java/jdk-8u311
cd /usr/java/jdk-8u311
sudo wget $urlJDK
sudo tar zxvf jdk-8u311-linux-x64.tar.gz
cd jdk-8u311-x64
cd ./

cd /deploy
sudo wget $urlSQLDeveloper
sudo unzip sqlcl-21.4.0.348.1716.zip slqcl-21
sudo slqcl-21/sqldeveloper.sh

#SublimeText;
sudo wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get -y install sublime-text


#Visual Studio Code;
urlVSCode="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo chmod 777 code_*_amd64.deb
sudo dpkg -i code_*_amd64.deb

# INSTALACAO DO CROWN-STRIKE
sudo wget 'https://rmtechfiles.s3.amazonaws.com/ScriptFiles/LOFT/linux/falcon-sensor_6.14.0-11110_amd64.deb' -O /tmp/falcon-sensor_6.14.0-11110_amd64.deb
sudo chmod 777 /tmp/falcon-sensor_6.14.0-11110_amd64.deb
sudo dpkg -i /tmp/falcon-sensor_6.14.0-11110_amd64.deb
sudo /opt/CrowdStrike/falconctl -s --cid=[INSIRIR A CHAVE DE ATIVACAO DO FALCON]
sudo service falcon-sensor start
sudo systemctl enable falcon-sensor --now
ps -e | grep falcon-sensor

# INSTALACAO DO DLP (DATA LOSS PROVIDER)
'''
07/01/2022 - FATAL ESSA INFORMACAO
'''
# INSTALACAO FILTRO WEB (PROXY)
'''
07/01/2022 - FATAL ESSA INFORMACAO
'''