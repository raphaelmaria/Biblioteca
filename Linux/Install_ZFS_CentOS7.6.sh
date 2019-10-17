# instalando ZFS


yum install zlib-devel libuuid-devel libattr-devel libblkid-devel libselinux-devel libudev-devel
yum install libacl-devel libaio-devel device-mapper-devel openssl-devel libtirpc-devel elfutils-libelf-devel
yum install kernel-devel-$(uname -r)

yum install kernel-devel-$(uname -r)
yum install epel-release
yum install python36 python36-devel python36-setuptools python36-cffi




RAID 5 (RAIDZ)
zpool create -f storage raidz /dev/sd[b-e]1