:: Instalação em Windows Inicial
:: Criado por raphael maria
:: Versao 0.3
:: Instalação de Programas a serem rodados em background
::
:: Teste de Commit

reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

:: Conectando ao servidor
net use I: \\192.168.8.7\Install kaira1206 /user:raphaelmaria /persistent:yes
net use R: \\192.168.8.200\RRender o22009render /user:render /persistent:yes

mkdir C:\Suporte

:: copy "I:\Windows\Softwares\
copy "I:\Windows\Softwares\AutoDesk\Maya_2017\Autodesk_Maya_2017_Update5_x64.exe" C:\Suporte
copy "I:\Windows\Softwares\BlackMagic\Davinci\DaVinci_Resolve_15.2.3_Windows\DaVinci_Resolve_15.2.3_Windows.exe" C:\Suporte
copy "I:\Windows\Softwares\BlackMagic\Fusion\Blackmagic_Fusion_Studio_16.0_Windows\Install Fusion Render Node v16.0.msi" C:\Suporte
copy "I:\Windows\Softwares\BlackMagic\Fusion\Blackmagic_Fusion_Studio_16.0_Windows\Install Fusion Studio v16.0.msi" C:\Suporte
copy "I:\Windows\Softwares\Neatvideo\WIN\NeatOFXSetup64.exe" C:\Suporte
copy "I:\Windows\Padrao 3D\__O2 Installers\AutoMounter_install.exe" C:\Suporte
copy "I:\Windows\Padrao 3D\__O2 Installers\o2Pauta_setup.exe" C:\Suporte
copy "I:\Windows\Padrao 3D\Houdini\houdini-17.0.352-win64-vc141.exe" C:\Suporte
:: copy "I:\Windows\ C:\Suporte


:: Instalação do Kit Basico 
:: start /I /WAIT "<programa.exe" /start

:: start /i "C:\Suporte\ /start
start  /I /WAIT "AutoMount"  C:\Suporte\AutoMounter_install.exe
start /I /WAIT "Pauta" C:\Suporte\o2Pauta_setup.exe
start /I /WAIT "Houdini"C:\Suporte\houdini-17.0.352-win64-vc141.exe
start /I /WAIT "Neat Video" C:\Suporte\NeatOFXSetup64.exe
start /I /WAIT "DaVinci 15" C:\Suporte\DaVinci_Resolve_15.2.3_Windows.exe
start /I /WAIT "Autodesk Maya 2017" C:\Suporte\Autodesk_Maya_2017_Update5_x64.exe


:: Instalação de Programas
:: msiexec /i "<programa.msi>" /qn /norestart
msiexec /i C:\Suporte\"Install Fusion Render Node v16.0.msi" /qn /norestart
msiexec /i C:\Suporte\"Install Fusion Studio v16.0.msi" /qn /norestart

:: Instalação de Plugins
:: start /wait "Windows\Softwares\Boris FX\Continuum\Continuum_2019_Adobe_12_0_0_Windows.exe" /start



:: <Programa.exe> /s /norestart


:: Instalação de Farms e Renders
start /I /WAIT R:\bin\win\rrWorkstation_installer.exe /start

reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f