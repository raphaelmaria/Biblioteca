:: Instalacao automatica Windows
:: Compativel com Windows 10, 7 e 8
:: Criado por Raphael Maria
::
::

:: montagem storage
net use I: \\10.0.0.116\suporte 1234 /user:raphael /permanent:yes
mkdir c:\suporte

:: Instalando softwares padrões
start /w \\10.0.0.116\suporte\01.Essencial\7z1604-x64.exe
start /w \\10.0.0.116\suporte\01.Essencial\AdbeRdr11000_pt_BR.exe
start /w \\10.0.0.116\suporte\01.Essencial\AdobeAIRInstaller.exe
start /w \\10.0.0.116\suporte\01.Essencial\ChromeSetup.exe
start /w \\10.0.0.116\suporte\01.Essencial\vlc-2.2.4-win32.exe

:: Instalando softwares de escritorio
start /w "\\10.0.0.116\suporte\02.Escritorio\Office 2019 Canal de Tudo\setup.exe"

:: Instalando pasta suporte
start /w \\10.0.0.116\suporte\11.Suporte\UltraViewer_setup_6.2_pt.exe
copy \\10.0.0.116\suporte\11.Suporte\AnyDesk.exe C:\Suporte
copy \\10.0.0.116\suporte\11.Suporte\tvqs.exe C:\Suporte