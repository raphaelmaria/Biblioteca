#!/bin/sh

# INSTALACAO DE SOURCES LIST
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bkp
echo "deb http://deb.debian.org/debian bullseye main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bullseye-updates main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch-backports main" | sudo tee -a /etc/apt/sources.list.d/backports.list

# ATUALIZACAO DE DB E INSTALACAO DE ATUALIZACOES
sudo apt update && sudo apt upgrade -y

# PRE REQUISITOS
sudo apt -y install vim python dialog tree wget tar unzip vim make gcc autoconf automake 

# REMOVENDO GNOME, DEIXANDO DEBIAN MAIS LEVE PARA RODAR
sudo apt-get autoremove gdm3
sudo apt-get autoremove --purge gnome*


# INSTALACAO NETWORK MANAGER (NMCLI)
sudo apt-get install network-manager -y
sudo systemctl enable --now NetworkManager.service

# INSTALACAO COCKPIT
sudo apt install cockpit -y
sudo systemctl enable --now cockpit

# INSTALACAO ANSIBLE
sudo apt install ansible -y

mv /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bkp

# INSTALACAO
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
retries=3" | sudo tee -a /etc/ansible/ansible.cfg

sudo ssh-keygen ansible

sudo mkdir -p /home/ansible/{group_vars,roles,playbooks}
sudo ln -s /home/ansible/hosts /etc/ansible/
sudo ln -s /home/ansible/group_vars /etc/ansible/
sudo ln -s /home/ansible/roles /etc/ansible/





echo "[ansible]
10.255.2.6
[windows]

[macos]

[linux]

[flash:children]" | sudo tee -a /home/ansible/hosts

echo "ansible_port: 5985
ansible_winrm_scheme: http
ansible_connection: winrm
ansible_user: 
ansible_password: 
ansible_winrm_transport: ntlm
ansible_winrm_server_cert_validation: ignore" | sudo tee -a /home/ansible/group_vars/windows

echo "ansible_ssh_port: 22
ansible_ssh_user: 
#ansible_ssh_pass:
ansible_become: yes
ansible_become_method: sudo
ansible_become_user: 
#ansible_become_pass: password
ansible_connection: ssh" | sudo tee -a /home/ansible/group_vars/linux

echo "ansible_ssh_port: 22
ansible_ssh_user: 
#ansible_ssh_pass: 
ansible_become: yes
ansible_become_method: sudo
#ansible_become_user: 
#ansible_become_pass: password
ansible_connection: ssh
" | sudo tee -a /home/ansible/group_vars/macos


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
