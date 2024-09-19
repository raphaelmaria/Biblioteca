@echo off
mode con:cols=120 lines=40
title Resolume Firewall Block by shdevnull

:: Solicitar permissões de administrador
net session >nul 2>&1 || (
    mshta vbscript:CreateObject("Shell.Application").ShellExecute("%~0","::","","runas",1)(window.close) && exit
)
cd /d "%~dp0"

:: Menu
:Menu
echo Selecione uma opção:
echo 1. Bloquear Resolume
echo 2. Desbloquear Resolume
set /p choice="Digite sua escolha (1-2): "

if "%choice%"=="1" (
    call :ToggleAccess block
) else if "%choice%"=="2" (
    call :ToggleAccess unblock
) else (
    echo.
    echo.
    echo Por favor, insira 1 ou 2.
    echo.
    goto :Menu
)

:: Função para bloquear ou desbloquear acesso à internet
:ToggleAccess
set action=%1

if /i "%action%"=="block" (
    echo Bloqueando acesso à internet para todos os aplicativos Resolume...
    call :BlockApp "Arena" "C:\Program Files\Resolume Arena\Arena.exe"
    call :BlockApp "Avenue" "C:\Program Files\Resolume Avenue\Avenue.exe"
    call :BlockApp "Wire" "C:\Program Files\Resolume Wire\Wire.exe"
    echo Acesso à internet bloqueado com sucesso.
) else if /i "%action%"=="unblock" (
    echo Desbloqueando acesso à internet para todos os aplicativos Resolume...
    call :UnblockApp "Arena" "C:\Program Files\Resolume Arena\Arena.exe"
    call :UnblockApp "Avenue" "C:\Program Files\Resolume Avenue\Avenue.exe"
    call :UnblockApp "Wire" "C:\Program Files\Resolume Wire\Wire.exe"
    echo Acesso à internet desbloqueado com sucesso.
)
goto :eof

:BlockApp
echo Bloqueando
