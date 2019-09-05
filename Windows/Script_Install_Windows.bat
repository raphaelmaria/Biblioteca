:: Instalação em Windows Inicial
:: Criado por raphael maria
:: Versao 0.1

:: Conectando ao servidor
net use I: \\192.168.8.7\Install kaira1206 /user:raphaelmaria /persistent:yes
net use R: \\192.168.8.200\RRender o22009render /user:render /persistent:yes

mkdir C:\Suporte

cp "I:\Windows\Softwares\AutoDesk\Maya_2017\Autodesk_Maya_2017_Update5_x64.exe" C:\Suporte
:: cp "I:\Windows\Softwares\

:: Instalação do Kit Basico
# start /w "<programa.exe" /start

:: start /i I:\Windows\Softwares\Adobe\Creative_Cloud_Set-Up.exe
start /i "I:\Windows\Softwares\Padrao 3D\__O2 Installers\AutoMounter_install.exe"
start /i "I:\Windows\Softwares\Padrao 3D\__O2 Installers\\o2Pauta_setup.exe"


:: Instalação de Programas
:: msiexec /i "<programa.msi>" /qn /norestart
msiexec /i "I:\Windows\Softwares\BlackMagic\Fusion\Blackmagic_Fusion_Studio_16.0_Windows\Install Fusion Render Node v16.0.msi" /qn /norestart
msiexec /i "I:\Windows\Softwares\BlackMagic\Fusion\Blackmagic_Fusion_Studio_16.0_Windows\Install Fusion Studio v16.0.msi" /qn /norestart

:: Instalação de Plugins
:: start /w "Windows\Softwares\Boris FX\Continuum\Continuum_2019_Adobe_12_0_0_Windows.exe" /start


:: <Programa.exe> /s /norestart


:: Instalação de Farms e Renders
start /w R:\bin\win\rrWorkstation_installer.exe /start
