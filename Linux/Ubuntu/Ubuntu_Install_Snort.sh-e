#!/bin/bash

# Atualize o sistema
sudo apt update
sudo apt upgrade -y

# Instale as dependências do Snort
sudo apt install -y build-essential libpcap-dev libpcre3-dev libdumbnet-dev bison flex zlib1g-dev liblzma-dev openssl libssl-dev

# Baixe e descompacte o código-fonte do Snort
wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz
tar -xvf daq-2.0.7.tar.gz
cd daq-2.0.7
./configure && make && sudo make install
cd ..

wget https://www.snort.org/downloads/snort/snort-2.9.20.tar.gz
tar -xvf snort-2.9.*.tar.gz
cd snort-2.9.20
./configure --enable-sourcefire && make && sudo make install
cd ..

sudo apt -y install snort

# Crie o diretório de configuração do Snort
sudo mkdir /etc/snort

# Crie o diretório de regras do Snort
sudo mkdir /etc/snort/rules

# Crie o diretório de logs do Snort
sudo mkdir /var/log/snort

# Crie um arquivo de configuração básico
sudo touch /etc/snort/snort.conf

# Copie as regras de exemplo
sudo cp snort-2.9.20/etc/* /etc/snort/

# Atualize as permissões
sudo chmod -R 5775 /etc/snort/
sudo chmod -R 5775 /var/log/snort/
sudo chmod -R 5775 /usr/local/lib/snort_dynamicrules

# Configure as variáveis de ambiente
sudo echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
source ~/.bashrc

# Reinicie o serviço do Snort
sudo ldconfig
sudo snort -V


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