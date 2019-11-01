# instalando ZFS


yum -y install zlib-devel libuuid-devel libattr-devel libblkid-devel libselinux-devel libudev-devel
yum -y install libacl-devel libaio-devel device-mapper-devel openssl-devel libtirpc-devel elfutils-libelf-devel
yum -y install kernel-devel-$(uname -r)

yum -y install kernel-devel-$(uname -r)
yum -y install epel-release
yum -y install python36 python36-devel python36-setuptools python36-cffi




RAID 5 (RAIDZ)
zpool create -f storage raidz /dev/sd[b-e]1