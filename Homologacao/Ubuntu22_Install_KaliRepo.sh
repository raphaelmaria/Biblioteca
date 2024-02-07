#!/bin/bash

# ADD REPO IN SOURCE.LIST
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee -a /etc/apt/sources.list

# INSTALL GPG KEYRING KALI
wget https://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2024.1_all.deb
sudo dpkg -i kali-archive-keyring_2024.1_all.deb

# Update List Repo
sudo apt update



