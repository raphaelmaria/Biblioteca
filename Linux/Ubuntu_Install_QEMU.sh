#!/usr/bin/env bash

sudo apt update
sudo apt -y install cpu-checker
sudo apt -y install bridge-utils cpu-checker libvirt-clients libvirt-daemon qemu qemu-kvm
sudo apt -y install libvirt-daemon-system virtinst virt-manager libvirt-bin

sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
sudo usermod -aG libvirtd $USER

