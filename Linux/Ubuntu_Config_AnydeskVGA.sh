#!/bin/bash
sudo apt-get install xserver-xorg-video-dummy

echo "Section "Device"
    Identifier "intelgpu0"
    Driver "intel"
    Option "VirtualHeads" "2"
EndSection" | sudo tee -a /usr/share/X11/xorg.conf.d/20-intel.conf

echo "#!/bin/bash
/usr/bin/xrandr -d :0 --output VIRTUAL1 --primary --auto
/usr/bin/xrandr --newmode "1600x900_60.00" 118.25 1600 1696 1856 2112 900$
/usr/bin/xrandr --addmode VIRTUAL1 "1600x900_60.00"
/usr/bin/xrandr" | sudo tee -a vga.sh

echo "@reboot /scripts/vga.sh" | sudo tee -a /etc/crontab