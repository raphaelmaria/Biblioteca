#!/bin/env sh
(
Comandos AQUI

echo "finaliza" > $HOME/fim
) & > /dev/null 2>&1
echo "Iniciando Instalação"
echo -ne "["
while true; do
echo -ne "#"
sleep 2s
   [[ -e $HOME/fim ]] && {
   rm $HOME/fim
   break
   }
done
echo "]"
echo "Instalação Finalizada!"