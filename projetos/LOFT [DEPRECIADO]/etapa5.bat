@echo ">_ SET WALLPAPER DEFAULT"
reg add "HKEY_CURRENT_USER\control panel\desktop" /v wallpaper /t REG_SZ /d "" /f 
reg add "HKEY_CURRENT_USER\control panel\desktop" /v wallpaper /t REG_SZ /d C:\Suporte\2021_04_Wallpaper_Project.jpg /f
reg add "HKEY_CURRENT_USER\control panel\desktop" /v WallpaperStyle /t REG_SZ /d 2 /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 

@echo ">_ Registrando Team Viewer Padroes Loft"
reg import C:\Suporte\TeamViewer_Settings.reg
reg import C:\Suporte\TeamViewer_Settings.reg /reg:32
reg import C:\Suporte\TeamViewer_Settings.reg /reg:64

REM INSTALACA DO NETSKOPE
msiexec /I NSClient.msi token=30UcayRWz0vgImspSxOe host=loft-br.de.goskope.com autoupdate=on

del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Start_PostInstall.bat"