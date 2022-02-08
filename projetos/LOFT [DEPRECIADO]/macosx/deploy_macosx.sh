#!\bin\sh
echo "INFORME OS 4 ULTIMOS DIGITOS DO PATRIMONIO: "
read PATRIMONIO 
#$HOSTNAME="LOFT-SPM-"
sudo scutil --set HostName "LOFT-M"$PATRIMONIO
sudo scutil --set LocalHostName "LOFT-M"$PATRIMONIO
sudo scutil --set ComputerName "LOFT-M"$PATRIMONIO

sudo open LOFT.mobileconfig

curl -s https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/macos/install_agent_and_serviceaccount.sh -o $TMPDIR/install_agent_and_serviceaccount.sh && sudo bash $TMPDIR/install_agent_and_serviceaccount.sh -k ef10c8ee36a34a414100d8c1eb2d93f26464acc5 && rm $TMPDIR/install_agent_and_serviceaccount.sh