#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt -y install wget apt-transport-https gnupg2 software-properties-common
sudo add-apt-repository ppa:mrazavi/openvas -y
sudo apt update

