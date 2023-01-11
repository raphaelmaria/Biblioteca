#!/bin/bash



sudo apt update
sudo apt upgrade -y
sudo apt -y install snort

# Install Guardian
cd /opt
sudo wget https://www.chaotic.org/guardian/guardian-1.7.tar.gz
sudo tar -zxvf guardian-1.7.tar.gz

# colocar o endereço de rede

# pasta de instalacao
# /etc/snort

cat snort.conf.orig | grep -v ^# | grep . | sudo tee -a snort.conf 
case local in {
    1) Configurar ranger IP local
    2) Não sei a ranger de IP local

}
esac

Case externa in
1) 
;;
2)
;;

}


sudo touch /var/log/snort/alert
sudo chmod 755 /var/log/snort/alert

# CONFIGURANDO O Guardian
Mudar a repositorio que armazena o alert, apontando para o arquivo do logs do Snort

sudo cp /opt/guardian-1.7/guardian.conf /etc 
echo [IP ADDRESS] > /etc/guardian.ignore
echo 192.168.15.102 > /etc/guardian.ignore
echo [0.0.0.0/24] > sudo tee -a /etc/guardian.target

sudo cp /opt/guardian-1.7/scripts/iptables_block.sh /sbin/guardin_block.sh
sudo cp /opt/guardian-1.7/scripts/iptables_unblock.sh /sbin/guardin_unblock.sh
sudo cp /opt/guardian-1.7/guardian.pl /sbin/guardian.pl

sudo touch /var/log/guardian.log
sudo chmod 755 /var/log/guardian.log

echo "#!/bin/bash
test -f /sbin/guardian.pl || exit 0
case "$1" in
start)
    guardian.pl -c /etc/guardian.conf
;;
stop)
    kill -9 $(pgrep guardian.pl)
    ;;
    *)
    echo "Opcao Invalida"
    exit 2
    ;;
esac
exit 0" | sudo tee -a /etc/init.d/guardian

sudo chmod 755 /etc/init.d/guardian