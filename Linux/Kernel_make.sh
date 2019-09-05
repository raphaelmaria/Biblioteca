wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.20.12.tar.xz
unzx -v linux-4.20.12.tar.xz
xz -d -v linux-4.20.12.tar.xz
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.20.12.tar.sign
gpg --verify linux-4.20.12.tar.sign
gpg --recv-keys 79BE3E4300411886
gpg --verify linux-4.20.12.tar.sign
tar xvf linux-4.20.12.tar
cd linux-4.20.12
cp -v /boot/config-$(uname -r) .config
yum group install "Development Tools"
yum install ncurses-devel bison flex elfutils-libelf-devel openssl-devel
make menuconfig
make gconfig
make menuconfig
make
make -j $
make modules_install
make install
grub2-mkconfig -o /boot/grub2/grub.cfg
grubby --set-default /boot/vmlinuz-4.20.12
grubby --info=ALL | more
grubby --default-index
grubby --default-kernel


