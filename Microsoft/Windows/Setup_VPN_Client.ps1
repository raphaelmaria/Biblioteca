#Set-VpnConnection -Name "O2Pos_VPN_X3" -ServerAddress "179.191.69.146" -TunnelType L2TP -L2tpPsk "1DDBDA8CB14E7202" -Force -AuthenticationMethod MSChapv2 -SplitTunneling $True -EncryptionLevel "Optional"
################################
# VARIABLES
$Name = "{NOME CONEXAO}"
$ServerAddress = "{URL/IP ADDRESS}" # IP Address or FQDN
$TunnelType = "{TIPO}" # Values: PPTP | L2TP | SSTP | IKEv2 | Automatic
$L2tpPsk = "{CHAVE}"
$AuthenticationMethod = "{AUTENTICACAO}" # Values: PAP | CHAP | MSCHAPv2 | EAP
$EncryptionLevel = "{LEVEL}" # Values: NoEncryption | Optional | Required | Maximum
$UseWinlogonCredential = $false
$RememberCredential = $true
$SplitTunneling = $true
$DnsSuffix = '{DNS INTERNO DA EMPRESA}'
################################

Add-VpnConnection -Name $Name -AllUserConnection $true -ServerAddress $ServerAddress -TunnelType $TunnelType -EncryptionLevel $EncryptionLevel -AuthenticationMethod $AuthenticationMethod -DnsSuffix $DnsSuffix -L2tpPsk $L2tpPsk -Force
Set-VpnConnection -Name $Name -AllUserConnection -SplitTunneling $SplitTunneling -UseWinlogonCredential $UseWinlogonCredential -RememberCredential $RememberCredential

pause
route -p ADD {IP INTERNO} MASK 255.255.0.0 {RANGE VPN}
route -p ADD 192.168.8.0 MASK 255.255.0.0 172.16.10.0
route print >> %userprofile%\Route_Logs.txt
route print