domain=.o2pos.com.br
ipaddress=192.168.10.

print ("Digite o Hostname da maquina?")
input HST
MQEND=HST[7:]
IPEND=MQIPEND + 100

hostnamectl set-hostname $HST.$domain
nmcli con show
input INTERFACE
nmcli con modify $INTERFACE ipv4.method manual ipv4.addresses $ipaddress+$IPEND/16 ipv4.gateway 192.168.8.1 ipv4.dns 192.168.8.100,192.168.8.110 ipv4.dns-search o2pos.com.br
nmcli con up $INTERFECE


