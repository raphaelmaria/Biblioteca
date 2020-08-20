echo "Script para configuração de rotas - Windows"
echo "Equipe de TI da O2 Pos Producoes"
echo "Adicionando ROTAS PERMANENTES dos servidores"
route -p ADD 192.168.7.0 MASK 255.255.0.0 172.16.10.0
route -p ADD 192.168.8.0 MASK 255.255.0.0 172.16.10.0
route -p ADD 192.168.9.0 MASK 255.255.0.0 172.16.10.0
route -p ADD 192.168.10.0 MASK 255.255.0.0 172.16.10.0
route -p ADD 192.168.11.0 MASK 255.255.0.0 172.16.10.0
route print >> %userprofile%\O2_Router_Logs.txt
route print
echo " Script executado com sucesso "
exit