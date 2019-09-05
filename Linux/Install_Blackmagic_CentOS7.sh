#!/bin/bash
# Empresa: O2 Produções Artisticas e Cinematograficas Ltda
# Desenvolvidor: Raphael Maria
# Cargo: Administrador de Redes
# Ticket:
# Script criado em 23/04/2019
# Motivo: Instalação do Desktop Video e Driver Blackmagic no CentOS 7 com kernel 3.10.0-693.2.2.el7.x86_64
# para a maquina do Emerson Bona Dias

scp root@192.168.8.7:/Storage/Install/Linux/Softwares/BlackMagic/Blackmagic_Desktop_Video_Linux_10.11.4.tar.gz .
tar -xvf Blackmagic_Desktop_Video_Linux_10.11.4.tar.gz
cd Blackmagic_Desktop_Video_Linux_10.11.4/rpm/x86_64/
chmod -R 777 *
rpm -ivh desktopvideo-10.11.4a9.x86_64.rpm
rpm -ivh desktopvideo-gui-10.11.4a9.x86_64.rpm
rpm -ivh desktopvideo-scanner-10.11.4a9.x86_64.rpm
rpm -ivh mediaexpress-3.5.7a5.x86_64.rpm 