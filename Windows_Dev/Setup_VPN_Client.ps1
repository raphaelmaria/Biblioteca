#Set-VpnConnection -Name "O2Pos_VPN_X3" -ServerAddress "179.191.69.146" -TunnelType L2TP -L2tpPsk "1DDBDA8CB14E7202" -Force -AuthenticationMethod MSChapv2 -SplitTunneling $True -EncryptionLevel "Optional"
################################
# VARIABLES
$Name = "[NOME DA CONEXAO]"
$ServerAddress = "[ENDERECO DO SERVIDOR]" # IP Address or FQDN
$TunnelType = "[TIPO DE TUNEL]" # Values: PPTP | L2TP | SSTP | IKEv2 | Automatic
$L2tpPsk = "{CHAVE L2TP}"
$AuthenticationMethod = "[NIVEL DE AUTENTICACAO]" # Values: PAP | CHAP | MSCHAPv2 | EAP
$EncryptionLevel = "[CRIPTOGRAFIA]" # Values: NoEncryption | Optional | Required | Maximum
$UseWinlogonCredential = $false
$RememberCredential = $true
$SplitTunneling = $true
$DnsSuffix = '[DNS LOCAL]'
################################

Add-VpnConnection -Name $Name -AllUserConnection $true -ServerAddress $ServerAddress -TunnelType $TunnelType -EncryptionLevel $EncryptionLevel -AuthenticationMethod $AuthenticationMethod -DnsSuffix $DnsSuffix -L2tpPsk $L2tpPsk -Force
Set-VpnConnection -Name $Name -AllUserConnection -SplitTunneling $SplitTunneling -UseWinlogonCredential $UseWinlogonCredential -RememberCredential $RememberCredential

pause
route -p ADD 192.168.7.0 MASK 255.255.0.0 172.16.10.0
route -p ADD 192.168.8.0 MASK 255.255.0.0 172.16.10.0
route -p ADD 192.168.9.0 MASK 255.255.0.0 172.16.10.0
route -p ADD 192.168.10.0 MASK 255.255.0.0 172.16.10.0
route -p ADD 192.168.11.0 MASK 255.255.0.0 172.16.10.0
route print >> %userprofile%\O2_Router_Logs.txt
route print