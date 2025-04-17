# Como configurar a placa de rede como IP estatico.

## Onde fica alocado o arquivo.

$ cat /etc/network/interfaces

## Exemplo de configuração do arquivo.

-----
# The Loopback network interfaces
auto lo
iface lo inet loopback

# The primary network interface
auto [interface]
iface [interface] inet static
    address 0.0.0.0
    netmask 0.0.0.0
    gateway 0.0.0.0
    dns-nameservers x.x.x.x y.y.y.y a.a.a.a