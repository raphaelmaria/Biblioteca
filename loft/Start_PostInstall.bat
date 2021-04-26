REM Powershell.exe -Command "& {Start-Process Powershell.exe -Verb RunAs}"
REM powershell -Command "Start-Process PowerShell -Verb RunAs -f C:\Suporte\Install_JumpCloud.ps1"
Start-Process powershell -verb runas -ArgumentList "-file C:\Suporte\Install_JumpCloud.ps1"


del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Start_PostInstall.bat"
REM del "C:\Suporte\Install_JumpCloud.ps1"
REM del "C:\Suporte\crowdstrike-facon-ps.ps1"