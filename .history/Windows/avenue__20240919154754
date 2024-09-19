@echo off
mode con:cols=120 lines=40
title Resolume Firewall Block by shdevnull

:: request admin permissions
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd","/c %~s0 ::","","runas",1)(window.close) && exit
cd /d "%~dp0"

:: menu
:Menu
echo Select an option:
echo 1. block Resolume
echo 2. unblock Resolume
set /p choice="enter your choice (1-2): "

if "%choice%"=="1" (
    call :ToggleAccess block
) else if "%choice%"=="2" (
    call :ToggleAccess unblock
) else (
    echo.
    echo.
    echo.
    echo.
    echo there are two options and you choose neither of those. are you alright? haha please enter either 1 or 2.
    echo.
    goto :Menu
)

:: function to block or unblock internet access for Resolume applications
:ToggleAccess
set action=%1

if /i "%action%"=="block" (
    echo blocking internet access for all Resolume applications...
    echo blocking Arena..
    netsh advfirewall firewall show rule name="Block Arena" | find "No rules match the specified criteria" >nul && (
        netsh advfirewall firewall add rule name="Block Arena" dir=out action=block program="C:\Program Files\Resolume Arena\Arena.exe" enable=yes
    )
    timeout /t 1 >nul
    echo blocking Avenue..
    netsh advfirewall firewall show rule name="Block Avenue" | find "No rules match the specified criteria" >nul && (
        netsh advfirewall firewall add rule name="Block Avenue" dir=out action=block program="C:\Program Files\Resolume Avenue\Avenue.exe" enable=yes
    )
    timeout /t 1 >nul
    echo blocking Wire..
    netsh advfirewall firewall show rule name="Block Wire" | find "No rules match the specified criteria" >nul && (
        netsh advfirewall firewall add rule name="Block Wire" dir=out action=block program="C:\Program Files\Resolume Wire\Wire.exe" enable=yes
    )
    timeout /t 1 >nul
    echo internet access for all Resolume applications has been blocked
    timeout /t 3 >nul
    echo closing..
    timeout /t 1 >nul
) else if /i "%action%"=="unblock" (
    echo unblocking internet access for all Resolume applications..
    echo unblocking Arena..
    netsh advfirewall firewall show rule name="Block Arena" | find "No rules match the specified criteria" >nul || (
        netsh advfirewall firewall delete rule name="Block Arena" program="C:\Program Files\Resolume Arena\Arena.exe"
    )
    timeout /t 1 >nul
    echo unblocking Avenue..
    netsh advfirewall firewall show rule name="Block Avenue" | find "No rules match the specified criteria" >nul || (
        netsh advfirewall firewall delete rule name="Block Avenue" program="C:\Program Files\Resolume Avenue\Avenue.exe"
    )
    timeout /t 1 >nul
    echo unblocking Wire..
    netsh advfirewall firewall show rule name="Block Wire" | find "No rules match the specified criteria" >nul || (
        netsh advfirewall firewall delete rule name="Block Wire" program="C:\Program Files\Resolume Wire\Wire.exe"
    )
    timeout /t 1 >nul
    echo internet access for all Resolume applications has been unblocked
    timeout /t 3 >nul
    echo closing..
    timeout /t 1 >nul
)
goto :eof
