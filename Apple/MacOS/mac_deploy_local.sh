#!/usr/bin/env bash

# ATUALIZAÇAO DO MACOS
sudo softwareupdate --install-rosetta --agree-to-license


# Instalar  Google Chrome
if [ -f "/Applications/Google Chrome.app" ];
then
    echo "Google Chrome já instalado!"
else
    killall "Google Chrome"
    sudo rm -rf "/Applications/Google Chrome.app"
    cd /tmp/
    curl -s -O "https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
    hdiutil attach /tmp/googlechrome.dmg -nobrowse;
    sudo cp -Rf "/Volumes/Google Chrome/Google Chrome.app" /Applications;
    hdiutil detach "/Volumes/Google Chrome";
    sudo rm -rf /tmp/googleChrome;
fi

# INSTALL GOOGLE REMOTE DESKTOP
URLGOOGLERD="https://dl.google.com/chrome-remote-desktop/chromeremotedesktop.dmg"
sudo mkdir /tmp/Google;
sudo chmod -R 777 /tmp/Google
cd /tmp/Google;
curl -L -o chromeremotedesktop.dmg "https://dl.google.com/chrome-remote-desktop/chromeremotedesktop.dmg";
hdiutil attach /tmp/Google/chromeremotedesktop.dmg -nobrowse;
sudo installer -pkg "/Volumes/Chrome Remote Desktop Host */Chrome Remote Desktop Host.pkg" -target /;
hdiutil detach "/Volumes/Chrome Remote Desktop Host *" -force;
sudo rm -rf /tmp/Google

# INSTALACAO GOOGLE DRIVE
if pgrep -if Drive > /dev/null;
then
    echo "Google Drive Ativo!"
else
    sudo mkdir /tmp/GoogleDrive;
    sudo chmod -R 777 /tmp/GoogleDrive
    cd /tmp/GoogleDrive;
    curl -L -o GoogleDrive.dmg "https://dl.google.com/drive-file-stream/GoogleDrive.dmg";
    hdiutil attach /tmp/GoogleDrive/GoogleDrive.dmg -nobrowse;
    sudo installer -pkg "/Volumes/Install Google Drive/GoogleDrive.pkg" -target /;
    hdiutil detach "/Volumes/Install Google Drive" -force;
    sudo rm -rf /tmp/GoogleDrive
fi

$USER=raphaelmaria
cd /Users/$USER/Downloads
curl -L -o https://az764295.vo.msecnd.net/stable/5e805b79fcb6ba4c2d23712967df89a089da575b/VSCode-darwin-universal.zip
sudo unzip /Users/$USER/VSCode-darwin-universal.zip -d /Applications/;

VarVisualStudio="/Applications/Visual Studio Code.app"
if [  -f $VarVisualStudio   ]; then
echo -n "Não encontramos o programa neste computador!"
else
sudo chown -R :staff $VarVisualStudio  && chmod -R 775 $VarVisualStudio

fi

# Setup MacOS
sudo /usr/sbin/systemsetup -setharddisksleep Never
sudo /usr/sbin/systemsetup -setcomputersleep 60
sudo /usr/sbin/systemsetup -setnetworktimeserver a.ntp.br
sudo /usr/sbin/systemsetup -setremotelogin on
sudo /usr/sbin/systemsetup -setremoteappleevents on
sudo /usr/sbin/systemsetup -setusingnetworktime on

# Fix de Wifi e Airdrop
VAROS=$(sw_vers -productVersion)

case "$VAROS" in
	12.*.*) echo "Versao Monterey."
	;;
	13.*)
	sudo ifconfig awdl0 down
	bash <(curl -sL https://www.meter.com/awdl.sh)
	echo "MacOS Ventura Identificado e corrigido!"
	;;
	13.*.*)
	sudo ifconfig awdl0 down
	bash <(curl -sL https://www.meter.com/awdl.sh)
	echo "MacOS Ventura Identificado e corrigido!"
	;;
esac
