
# Escrever ZEROS em uma unidade, serve para testar a escrita de capacidade e fincionalidade da UNIDADE
sudo dd if=/dev/zero of=/dev/[ UNIDADE ] bs=4096 status=progress

# Formatando em FAT 32
sudo mkfs.vfat -F32 /dev/[ UNIDADE ]

# Formatando em EXT4
sudo mkfs.ext4 /dev/[ UNIDADE ]