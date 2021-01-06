:: Instalacao animbot
:: Script de instalacao
:: Criado em 07 de Agosto de 2019
:: Mediante ao ticket 1632 para a maquina do Abner Cirelli do 3D
:: Versão 1.0
::
::
:: ################################################

net use I: \\{IP ADDRESS}\{PATH} {PASSWORD} /user:{USER}
mkdir %userprofile%\Documents\maya\animBot_enterprise
copy "i:\Windows\Padrao 3D\animBot\animBot_1_1_16_Ongoing\animBot" %userprofile%\Documents\maya\animBot_enterprise /Y
copy "i:\Windows\Padrao 3D\animBot\animBot_1_1_16_Ongoing\config.json" %userprofile%\Documents\maya\animBot_enterprise /Y
copy "i:\Windows\Padrao 3D\animBot\animBot_1_1_16_Ongoing\Maya.env" %userprofile%\Documents\maya\2017 /Y