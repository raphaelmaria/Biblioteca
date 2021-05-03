Powershell.exe -Command "& {Start-Process Powershell.exe -Verb RunAs C:\Suporte\Install_JumpCloud.ps1}"

@echo "SET WALLPAPER DEFAULT"
reg add "HKEY_CURRENT_USER\control panel\desktop" /v wallpaper /t REG_SZ /d "" /f 
reg add "HKEY_CURRENT_USER\control panel\desktop" /v wallpaper /t REG_SZ /d C:\Suporte\2021_04_Wallpaper_Project.jpg /f
reg add "HKEY_CURRENT_USER\control panel\desktop" /v WallpaperStyle /t REG_SZ /d 2 /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 

reg import C:\Suporte\TeamViewer_Settings.reg

del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Start_PostInstall.bat"

