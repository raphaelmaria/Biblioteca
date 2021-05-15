@echo off
REM @echo INVENTARIO EM ANDAMENTO
REM set p/ patrimonio = Patrimonio da maquinas
REM cho Fazendo Inventario do Patrimonio %patrimonio%
REM :\Inventory\WinAudit\WinAudit.exe /r=goNtDabpmiG /f=Z:\Inventory\Hosts\LOFT-SPW-%patrimonio%.html /T=datetime
@echo *****************************************************
REM Script de Instalacao de Executaveis EXE e MSI
@echo.
@echo Empresa: Loft
@echo Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
REM "Cargo: Analista de Suporte"
@echo Versaoo 2.1
@echo Criado em 30 de Dezembro de 2020
REM Ticket Origem:
REM Solicitante:
@echo Descricao: Automatiza a customizacao de novas maquinas.
REM Código com comentários:
@echo *****************************************************
@echo.
@echo *****************************************************
reg import C:\Suporte\TeamViewer_Settings.reg
echo "Instalando Slack Legacy (Para TODOS os usuarios)"
    start /wait msiexec /package "C:\Suporte\SlackSetup.msi" /passive
@echo *****************************************************
@echo.
@echo *****************************************************
echo "Instalando Zoom (Para TODOS os usuarios)"
    start /wait msiexec /package  "C:\Suporte\ZoomSetup.msi" ZoomAutoUpdate="true" ZoomAutoStart="true" /passive
@echo *****************************************************
@echo.
@echo *****************************************************
@echo *****************************************************
REM cho "Removendo Pontos de Restauracao"
REM vssadmin delete shadows /All
@echo =====================================================

@echo ">_ SET WALLPAPER DEFAULT"
reg add "HKEY_CURRENT_USER\control panel\desktop" /v wallpaper /t REG_SZ /d "" /f 
reg add "HKEY_CURRENT_USER\control panel\desktop" /v wallpaper /t REG_SZ /d C:\Suporte\2021_04_Wallpaper_Project.jpg /f
reg add "HKEY_CURRENT_USER\control panel\desktop" /v WallpaperStyle /t REG_SZ /d 2 /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 

@echo ">_ Registrando Team Viewer Padroes Loft"
reg import C:\Suporte\TeamViewer_Settings.reg
reg import C:\Suporte\TeamViewer_Settings.reg /reg:32
reg import C:\Suporte\TeamViewer_Settings.reg /reg:64
exit


