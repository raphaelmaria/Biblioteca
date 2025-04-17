#!/bin/bash
# Empresa: O2 Produções Artisticas e Cinematográficas Ltda.
# Desenvolvedor: Raphael Alan de Oliveira Maria
# CPF: 373.401.578-24
# Cargo: Administrador de Redes
# Versão 1.0
# Criado em 23/04/2019
# Ticket Origem:
# Solicitante: Emerson Bona Dias
# Descrição: para instalação da placa Startech de 10 G, pacote criado pelo Uira.
# Código com comentários:

## Efetua copia do servidor com usuário autenticado
scp -r root@192.168.8.7:/Storage/Install/Linux/Drivers/Rede/Startech/Tehuti_TN4010_Linux-ESXI_PCIe_10_Gigabit_Network_Card .
## entra na pasta 
cd Tehuti_TN4010_Linux-ESXI_PCIe_10_Gigabit_Network_Card/Linux
## executa a instalação do KO
make install
## reinicia a maquina
reboot

