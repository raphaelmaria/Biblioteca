Start-Process -wait -FilePath powershell.exe -verb RunAs -ArgumentList "-file C:\Suporte\Install_JumpCloud.ps1"
Start-Process -wait -FilePath powershell.exe -verb RunAs -ArgumentList "-file C:\Suporte\crowdstrike-facon-ps.ps1"

msg %username% "Instalacao de CrowdStrike e JumpCloud efetuadas com sucesso!"

del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Start_PostInstall.bat"
REM del "C:\Suporte\Install_JumpCloud.ps1"
REM del "C:\Suporte\crowdstrike-facon-ps.ps1"