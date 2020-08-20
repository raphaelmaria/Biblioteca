#Set-VpnConnection -Name "O2Pos_VPN_X3" -ServerAddress "179.191.69.146" -TunnelType L2TP -L2tpPsk "1DDBDA8CB14E7202" -Force -AuthenticationMethod MSChapv2 -SplitTunneling $True -EncryptionLevel "Optional"
################################
# VARIABLES
$Name = "O2Pos_VPN_X3"
$ServerAddress = "o2filmes-sp.fxo-i.net" # IP Address or FQDN
$TunnelType = "L2TP" # Values: PPTP | L2TP | SSTP | IKEv2 | Automatic
$L2tpPsk = "1DDBDA8CB14E7202"
$AuthenticationMethod = "MSCHAPv2" # Values: PAP | CHAP | MSCHAPv2 | EAP
$EncryptionLevel = "Optional" # Values: NoEncryption | Optional | Required | Maximum
$UseWinlogonCredential = $false
$RememberCredential = $true
$SplitTunneling = $true
$DnsSuffix = 'o2pos.com.br'
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