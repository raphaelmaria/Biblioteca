$nsclient=(Get-WmiObject -Class Win32_Product -Filter "name='Netskope Client'" | Select-Object IdentifyingNumber)
$nsclientIN=($nsclient.IdentifyingNumber)
$netskopeID=($nsclientIN.Substring(1,$nsclientIN.Length -2))
Write-Host $netskopeID