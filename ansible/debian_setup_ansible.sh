#!/bin/sh

# curl -s "https://rmtechfiles.s3.amazonaws.com/Applications/lnxos/debian_setup_ansible.sh" | sudo bash

# INSTALACAO DE SOURCES LIST
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bkp
echo "deb http://deb.debian.org/debian bullseye main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bullseye-updates main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch-backports main" | sudo tee -a /etc/apt/sources.list.d/backports.list

# ATUALIZACAO DE DB E INSTALACAO DE ATUALIZACOES
sudo apt update && sudo apt upgrade -y

# PRE REQUISITOS
sudo apt install vim python dialog tree wget tar unzip vim make gcc autoconf automake -y
sudo apt-get install gnupg2 curl wget -y


# REMOVENDO GNOME, DEIXANDO DEBIAN MAIS LEVE PARA RODAR
sudo apt-get autoremove gdm3 -y
sudo apt-get autoremove --purge gnome* -y


# INSTALACAO NETWORK MANAGER (NMCLI)
sudo apt-get install network-manager -y
sudo systemctl enable --now NetworkManager.service

# INSTALACAO COCKPIT
sudo apt install cockpit -y
sudo systemctl enable --now cockpit

# INSTALACAO PYTHON PIP
sudo apt-get install python3 python3-pip -y
python3 -m ensurepip --upgrade
curl -s "https://bootstrap.pypa.io/pip/2.7/get-pip.py" | sudo python3
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pip


# INSTALACAO ANSIBLE
deb http://ppa.launchpad.net/ansible/ansible/ubuntu focal main
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update
sudo apt install ansible -y
mv /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bkp

# DEFININDO SUDO USER
echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

# CONFIGURANDO SSH KEY PARA O USUARIO ANSIBLE

sudo ssh-keygen -t rsa -f ansible << EOF


EOF

if [ -d /etc/ansible ];
then
    echo "Diretorio Ansible Padrão já existe!"
else
    sudo mkdir -p /etc/ansible
    sudo mkdir -p /home/ansible/{group_vars,roles,playbooks}
    sudo ln -s /home/ansible/group_vars /etc/ansible/
    sudo ln -s /home/ansible/roles /etc/ansible/
fi

if [ -f /home/ansible/hosts ];
then
    echo "Já existe um arquivo Hosts!"
else
    echo "[ansible]
10.255.2.6
[windows]

[macos]

[linux]

[flash:children]" | sudo tee -a /home/ansible/hosts
    echo "Arquivo Hosts foi Criado! "
if

if [ -f /home/ansible/group_vars/windows ];
then
    echo "Arquivo já existe!"
else
    echo "ansible_port: 5985
ansible_winrm_scheme: http
ansible_connection: winrm
ansible_user: 
ansible_password: 
ansible_winrm_transport: ntlm
ansible_winrm_server_cert_validation: ignore" | sudo tee -a /home/ansible/group_vars/windows
fi

if [ -f /home/ansible/group_vars/linux ];
then
    echo "Arquivo ja existe!"
else
    echo "ansible_ssh_port: 22
ansible_ssh_user: 
#ansible_ssh_pass:
ansible_become: yes
ansible_become_method: sudo
ansible_become_user: 
#ansible_become_pass: password
ansible_connection: ssh" | sudo tee -a /home/ansible/group_vars/linux
fi

if [ -f /home/ansible/group_vars/macos ];
then
    echo "Arquivo já existe!"
else    
    echo "ansible_ssh_port: 22
ansible_ssh_user: 
#ansible_ssh_pass: 
ansible_become: yes
ansible_become_method: sudo
#ansible_become_user: 
#ansible_become_pass: password
ansible_connection: ssh" | sudo tee -a /home/ansible/group_vars/macos
fi

if [ -f /root/.vimrc ];
then
    echo "Arquivo VIMRC já configurado!"
else
    echo "syntax on
set number
set showmode
set ignorecase
set ruler                  
set hlsearch                
set showcmd                
set smarttab            
set nowrap                
set sm                  
set visualbell         
set laststatus=1           
set title                  
set term=xterm-256color   
set smartcase
set incsearch 
set autoindent
set shiftwidth=2
set smartindent
set softtabstop=2
set undolevels=1000" | sudo tee -a /root/.vimrc
 
mv /root/.vimrc /home/ansible/.vimrc
sudo chmod 775 /home/ansible/.vimrc
sudo chowm ansible:ansible /home/ansible/.vimrc
fi

if [ -f /home/ansible/ansible.cfg ];
then
    echo "Identificamos que o ansible.cfg já existe!"
else
    echo "[defaults]
forks=5
log_path=/var/log/ansible.log
module_name=command
executable=/bin/bash
ansible_managed=Ansible managed

inventory=/etc/ansible/hosts
library=/usr/share/my_modules
remote_tmp=~/.ansible/tmp
local_tmp=~/.ansible/tmp
roles_path=/etc/ansible/roles

#remote_user=root
ask_pass=no
ask_sudo_pass=no

remote_port=22
timeout=10
host_key_checking=False
ssh_executable=/usr/bin/ssh
private_key_file=~/.ssh/id_rsa

[privilege_scalation]
become=True
become_method=sudo
become_user=root
become_ask_pass=False

[ssh_connection]
scp_if_ssh=smart
tranfer_method=smart
retries=3" | sudo tee -a /home/ansible/ansible.cfg
sudo ln -s /home/ansible/hosts /etc/ansible/
fi


# Modulos Ansible
# Para Powershell em Windows
ansible-galaxy collection install ansible.windows
ansible-galaxy collection install ansible.windows
