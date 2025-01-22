# Script to download, Silent Install and then clean up once installed Keka 
# Writen by twitter.com/richhickson 
# www.RichardHickson.com 

# Make temp folder for downloads. 
mkdir "/tmp/keka/"; cd "/tmp/keka/"; 

#Download Keka. 
curl -L -o /tmp/keka/keka.dmg "https://d.keka.io/"; 

#Mount DMG
hdiutil attach /tmp/keka/keka.dmg; 

#Copy App to Applications 
sudo cp -R "/Volumes/Keka/Keka.app" /Applications; 

#Unmount DMG 
hdiutil detach /Volumes/Keka; 

#Remove Temp Files 
sudo rm -rf "/tmp/keka/";