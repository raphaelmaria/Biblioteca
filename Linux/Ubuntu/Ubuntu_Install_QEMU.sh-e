#!/usr/bin/env bash

sudo apt update
sudo apt -y install cpu-checker
sudo apt -y install bridge-utils cpu-checker libvirt-clients libvirt-daemon qemu qemu-kvm
sudo apt -y install libvirt-daemon-system virtinst virt-manager libvirt-bin

sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
sudo usermod -aG libvirtd $USER

sudo chmod u+s /usr/lib/qemu/qemu-bridge-helper
echo "allow all" | sudo tee /etc/qemu/${USER}.conf
echo "include /etc/qemu/${USER}.conf" | sudo tee --append /etc/qemu/bridge.conf
sudo chown root:${USER} /etc/qemu/${USER}.conf
sudo chmod 640 /etc/qemu/${USER}.conf