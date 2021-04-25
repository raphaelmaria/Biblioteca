Start-Process -Path powershell.exe -Verbose RunAs -ArgumentList "-f C:\Suporte\DisableNIC.ps1" 

netsh interface set interface "Interface Name" Admin=disable
Start-Process "C:\Program Files\Corel\Program64\Draw.exe"
sleep 15
netsh interface set interface "Interface Name" Admin=enable