#!/bin/sh
# DESCRICAO: Instalar NVIDIA Driver
# SINOPSE: Efetua a Instalacao de Drive no CentOS 7 ou 8
# USO/EXEMPLO: ./setup.Centos_Nvidia.sh
#
# OPCOES: 
# AUTHOR: Raphael Maria <http://raphaelmaria.com.br>
# VERSAO: 1.0.1 in 6 de Agosto de 2020
# LICENCA: LICENSE GPL <http://gnu.org/licenses/gpl.html>
# Fonte: https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-centos-8

# Download do Drive de repositorio Interno (atualizado em 06/08/2020)
cd /root
wget http://192.168.8.7/app/linux/Drivers/NVIDIA/NVIDIA-Linux-x86_64-440.100.run
# Aplicando permissoes
chmod 777 NVIDIA-Linux-x86_64-*.*.run
chmod +X NVIDIA-Linux-x86_64-*.*.run

dnf groupinstall "Development Tools"
dnf install libglvnd-devel elfutils-libelf-devel

grub2-editenv - set "$(grub2-editenv - list | grep kernelopts) nouveau.modeset=0"

echo "@reboot root /root/continueGPU.sh" >> /etc/crontab
touch /root/continueGPU.sh
chmod 777 /root/continueGPU.sh
chmod +X /root/continueGPU.sh

echo "
#!/bin/sh
# Continuacao da Instalacao do Drive da NVIDIA
init 3
bash /root/NVIDIA-Linux-x86_64-*.*.run
rm -rf /root/continueGPU.sh
rm -rf /setup.Centos_Nvidia.sh
rm -rf /root/NVIDIA-Linux-x86_64-*.*.run
sed -i 's/^@reboot/#@reboot' /etc/crontab
reboot
"
reboot
