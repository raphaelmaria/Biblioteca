Como instalar VM usando o Virt por linha de comando

Comando: virt-install
Opções:
-- name > Nome de identificação da VM, será mostradon no painel
--description > Descrição da VM, pode conter detalhes como serviços ou a sua utilização
--ram > Quantidade de memoria Ram que será aplicada
--vcpus > Quantidade de CPU (processador) que será dedicado.
--disk path > Local onde será armazenado o disco virtual em formato qcow2 com o sistema, size=Tamanho do disco
--cdrom > Local onde esta armazenado o imagem ISO do sistema
--graphics > Protocolo de emulação de video em tela 

Exemplos 

Instalando um VM simples
# sudo virt-install --name=Ubuntu Server 20.04 \
> --description='Ubuntu server com Zabbix' \
> --ram=1024 \
> --vcpus=1 \
> --disk path=/mnt/ext/VMlow/zabbiz.qcow2,size=30 \
> --cdrom=/mnt/ext/ISOs/UbuntuServer2004.iso \
> --graphics none

Instalando um VM simples usando o VNC como emulador grafico.
# sudo virt-install --name=Ubuntu Server 20.04 \
> --description='Ubuntu server com Zabbix' \
> --ram=1024 \
> --vcpus=1 \
> --disk path=/mnt/ext/VMlow/zabbiz.qcow2,size=30 \
> --cdrom=/mnt/ext/ISOs/UbuntuServer2004.iso \
> --graphics vnc,port=5901,listen=0.0.0.0

Instalando um VM ( Meu padrão)
# sudo virt-install -p --name=Ubuntu Server 20.04 \
> --description='Ubuntu server com Zabbix' \
> --ram=1024 \
> --vcpus=1 \
> --disk path=/mnt/ext/VMlow/zabbiz.qcow2,size=30 \
> --cdrom=/mnt/ext/ISOs/UbuntuServer2004.iso \
> --graphics spice
> --network bridge=br0,model=virtio
> --cloud-init
> --autostart
