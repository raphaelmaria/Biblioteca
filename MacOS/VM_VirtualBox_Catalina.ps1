cd "C:\Program Files\Oracle\VirtualBox\"
cmd /c VBoxManage.exe modifyvm "Catalina" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
cmd /c VBoxManage setextradata "Catalina" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
cmd /c VBoxManage setextradata "Catalina" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
cmd /c VBoxManage setextradata "Catalina" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
cmd /c VBoxManage setextradata "Catalina" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
cmd /c VBoxManage setextradata "Catalina" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
cmd /c VBoxManage setextradata "Catalina" VBoxInternal2/EfiGraphicsResolution 1280x720
