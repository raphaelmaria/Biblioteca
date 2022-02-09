#!/bin/sh
sudo apt-get install unzip -y
cd ~/Downloads
wget https://github.com/UNIVALI-LITE/Portugol-Studio/releases/download/v2.7.5/portugol-studio-2.7.5-linux-x64.run.zip
chmod 777 portugol-studio-2.7.5-linux-x64.run.zip
unzip portugol-studio-2.7.5-linux-x64.run.zip
chmod +X portugol-studio-2.7.5-linux-x64.run
chmod 777 portugol-studio-2.7.5-linux-x64.run
sudo ./portugol-studio-2.7.5-linux-x64.run
