### Preseed for Ubuntu 22.04
# Derived from: https://help.ubuntu.com/lts/installation-guide/example-preseed.txt


### Unattended Installation
d-i auto-install/enable boolean true
d-i debconf/priority select critical

### Localization
d-i debian-installer/locale string en_US.UTF-8
d-i localechooser/supported-locales multiselect en_US.UTF-8, de_DE.UTF-8
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/xkb-keymap select us

### Network configuration
d-i netcfg/choose_interface select auto
d-i netcfg/hostname string device
d-i netcfg/get_hostname string device
d-i netcfg/get_domain string unnamed
d-i hw-detect/load_firmware boolean true

### Mirror settings
d-i mirror/country string manual
d-i mirror/http/hostname string archive.ubuntu.com
d-i mirror/http/directory string /ubuntu
d-i mirror/http/proxy string

### Account setup
d-i passwd/root-login boolean true
d-i passwd/root-password-crypted password !!
d-i passwd/make-user boolean false

# The root password is disabled by default. In case you want to use a root
# password, please generate a password with the following command
#   printf "please-change-password" | mkpasswd -s -m sha-512
# and update the passwd/root-password-crypted variable accordingly. Furthermore
# you need to remove the call to "usermod" below.

### Clock and time zone setup
d-i clock-setup/utc boolean true
d-i time/zone string America/Sao_Paulo
d-i clock-setup/ntp boolean true
d-i clock-setup/ntp-server string ntp.ubuntu.com

### Do NOT install on the USB stick(!)
#
# The Debian installer will install on the first disk it finds which can
# sometimes be the USB stick itself. Work around this by rolling our own auto
# detect logic which disallows installing on USB devices.
d-i partman/early_command string \
  USBDEV_LIST="$(mktemp)"; \
  list-devices usb-partition | sed "s/\(.*\)./\1/" > "$USBDEV_LIST"; \
  BOOTDEV="$(list-devices disk | grep -vf "$USBDEV_LIST" | head -n 1)"; \
  debconf-set partman-auto/disk "$BOOTDEV"; \
  debconf-set grub-installer/bootdev "$BOOTDEV"; \
  while /bin/true; do sleep 0.01; rm -f /target/etc/grub.d/30_os-prober; done &

### Partitioning
d-i preseed/early_command string umount /media || true
d-i partman-auto/method string lvm
d-i partman-auto-lvm/guided_size string max
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-auto-lvm/new_vg_name string main
d-i partman-md/device_remove_md boolean true
d-i partman-md/confirm boolean true
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman-basicmethods/method_only boolean false

### GPT
d-i partman-basicfilesystems/choose_label string gpt
d-i partman-basicfilesystems/default_label string gpt
d-i partman-partitioning/choose_label string gpt
d-i partman-partitioning/default_label string gpt
d-i partman/choose_label string gpt
d-i partman/default_label string gpt

### EFI
d-i partman-efi/non_efi_system boolean true

### Grub
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean true

### Disk layout

# Keep 25% free space
d-i partman-auto/expert_recipe string         \
  boot-root ::                                \
    1 1 1 free                                \
      $bios_boot{ }                           \
      method{ biosgrub }                      \
    .                                         \
    256 256 256 fat32                         \
      $primary{ }                             \
      $iflabel{ gpt }                         \
      $reusemethod{ }                         \
      method{ efi } format{ }                 \
      mountpoint{ /boot/efi }                 \
    .                                         \
    512 512 512 ext4                          \
      $primary{ }                             \
      $bootable{ }                            \
      method{ format } format{ }              \
      use_filesystem{ } filesystem{ ext4 }    \
      mountpoint{ /boot }                     \
    .                                         \
    1024 102400000 1000000000 ext4            \
      $lvmok{ }                               \
      method{ format } format{ }              \
      use_filesystem{ } filesystem{ ext4 }    \
      mountpoint{ / }                         \
      lv_name{ root }                         \
    .                                         \
    256 25600000 1000000000 ext4              \
      $lvmok{ }                               \
      method{ keep }                          \
      lv_name{ placeholder }                  \
    .                                         \
    200% 200% 200% linux-swap                 \
      $lvmok{ }                               \
      method{ swap } format{ }                \
      lv_name{ swap }                         \
    .

# Use entire disk
#d-i partman-auto/expert_recipe string         \
#  boot-root ::                                \
#    1 1 1 free                                \
#      $bios_boot{ }                           \
#      method{ biosgrub }                      \
#    .                                         \
#    256 256 256 fat32                         \
#      $primary{ }                             \
#      $iflabel{ gpt }                         \
#      $reusemethod{ }                         \
#      method{ efi } format{ }                 \
#      mountpoint{ /boot/efi }                 \
#    .                                         \
#    512 512 512 ext4                          \
#      $primary{ }                             \
#      $bootable{ }                            \
#      method{ format } format{ }              \
#      use_filesystem{ } filesystem{ ext4 }    \
#      mountpoint{ /boot }                     \
#    .                                         \
#    1024 102400000 1000000000 ext4            \
#      $lvmok{ }                               \
#      method{ format } format{ }              \
#      use_filesystem{ } filesystem{ ext4 }    \
#      mountpoint{ / }                         \
#      lv_name{ root }                         \
#    .                                         \
#    200% 200% 200% linux-swap                 \
#      $lvmok{ }                               \
#      method{ swap } format{ }                \
#      lv_name{ swap }                         \
#    .

### Base system installation
d-i base-installer/install-recommends boolean true
d-i base-installer/kernel/image string linux-generic

### Apt setup
d-i apt-setup/restricted boolean true
d-i apt-setup/universe boolean true
d-i apt-setup/backports boolean true
d-i apt-setup/use_mirror boolean false
d-i apt-setup/services-select multiselect security, updates
d-i apt-setup/security_host string security.ubuntu.com
d-i apt-setup/security_path string /ubuntu

### Package selection
d-i tasksel/first multiselect none
d-i pkgsel/include string openssh-server python
d-i pkgsel/upgrade select full-upgrade
d-i pkgsel/update-policy select unattended-upgrades

### Finishing up the installation
d-i preseed/late_command string \
 cp -r /custom /target/custom; \
 in-target sh -c 'lvremove -f --noudevsync main/placeholder || true'; \
 in-target sh -c 'usermod -p "!" root'; \
 in-target sh -c 'mkdir -p --mode=0700 /root/.ssh && cat /custom/userkey.pub > /root/.ssh/authorized_keys && chmod 0600 /root/.ssh/authorized_keys';  \
 in-target sh -c 'sed -i "s/^#PermitRootLogin.*\$/PermitRootLogin prohibit-password/g" /etc/ssh/sshd_config'; \
 in-target sh -c 'rm -f /etc/ssh/ssh_host_*_key* && mkdir -p /usr/lib/systemd/system && cp /custom/ssh-host-keygen.service /usr/lib/systemd/system/ssh-host-keygen.service && systemctl enable ssh-host-keygen.service'; \
 in-target sh -c 'echo "IPv4: \\\4" >> /etc/issue && echo "IPv6: \\\6" >> /etc/issue && echo "" >> /etc/issue'; \
 in-target sh -c 'eject || true'; \
 rm -r /target/custom;
d-i debian-installer/splash boolean false
d-i cdrom-detect/eject boolean true

### Shutdown machine
d-i finish-install/reboot_in_progress note
d-i debian-installer/exit/poweroff boolean true