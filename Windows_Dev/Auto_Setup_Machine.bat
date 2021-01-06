@echo off
@echo ***********************************************************
REM Script de Instalacao de MSI
@echo.
@echo Empresa: [EMPRESA]
@echo Desenvolvedor: Raphael xxxxx xx xxxxxxxxx Maria
REM "Cargo: Analista de Suporte"
@echo Versaoo 2.1
@echo Criado em 30 de Dezembro de 2020
REM Ticket Origem:
REM Solicitante:
@echo Descricao: Automatiza a customizacao de novas maquinas.
REM Código com comentários:
@echo ************************************************************
REM ATENCAO ISSO SAO EXEMPLOS
REM ESTUDE SEU AMBIENTE E FACA A HOMOLOGACAO
REM ANTES DE COLOCAR EM PRODUCAO
@echo.

REM echo "Instalando 7zip"
REM start /wait msiexec /I "C:\Suporte\Setup_7z.msi" /passive
REM NO POWERSHELL OPTAMOS EM FAZER O DOWNLOAD DIRETO DO SITE.
@echo ***********************************************
@echo.
@echo ***********************************************
echo Instalando Slack (Para TODOS os usuarios)
    start /wait msiexec /package "C:\Suporte\SlackSetup.msi" /passive
@echo ***********************************************
@echo.
@echo ***********************************************
echo Instalando Zoom (Para TODOS os usuarios)
    start /wait msiexec /package  "C:\Suporte\ZoomSetup.msi" ZoomAutoUpdate="true" ZoomAutoStart="true" /passive
@echo ***********************************************
@echo.
@echo ***********************************************
@echo ***********************************************


