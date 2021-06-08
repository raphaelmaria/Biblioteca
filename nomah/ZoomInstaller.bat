REM Script de Instalacao de Executaveis EXE e MSI
@echo.
@echo Empresa: Nomah
@echo Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
REM "Cargo: Analista de Suporte"
@echo Versaoo 2.1
@echo Criado em 08 de Junho de 2021
@echo Atualizado em 08/06/2021
REM Ticket Origem:
REM Solicitante:
@echo Descricao: Automatiza a customizacao de novas maquinas.
REM Código com comentários:
@echo *****************************************************
@echo.
@echo *****************************************************
echo "Instalando Slack Legacy (Para TODOS os usuarios)"
REM    start /wait msiexec /package "C:\Suporte\SlackSetup.msi" /passive
@echo *****************************************************
@echo.
@echo *****************************************************
echo "Instalando Zoom (Para TODOS os usuarios)"
REM    start /wait msiexec /package  "C:\Suporte\ZoomSetup.msi" ZoomAutoUpdate="true" ZoomAutoStart="true" /passive
@echo *****************************************************
@echo.
@echo *****************************************************
rem echo "Instalando Fortnet - Client Endpoint with VPN"
rem start /wait msiexec /package "C:\Suporte\Setup_FortiClient.msi" /passive
@echo *****************************************************
@echo.
@echo =====================================================
echo "Removendo Pontos de Restauracao"
REM vssadmin delete shadows /All

@echo ">_ SET WALLPAPER DEFAULT"
REM reg add "HKEY_CURRENT_USER\control panel\desktop" /v wallpaper /t REG_SZ /d "" /f 
REM reg add "HKEY_CURRENT_USER\control panel\desktop" /v wallpaper /t REG_SZ /d C:\Suporte\2021_04_Wallpaper_Project.jpg /f
REM reg add "HKEY_CURRENT_USER\control panel\desktop" /v WallpaperStyle /t REG_SZ /d 2 /f
REM UNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 

@echo ">_ Registrando Team Viewer Padroes Loft"
REM reg import C:\Suporte\TeamViewer_Settings.reg
REM reg import C:\Suporte\TeamViewer_Settings.reg /reg:32
REM reg import C:\Suporte\TeamViewer_Settings.reg /reg:64
exit

