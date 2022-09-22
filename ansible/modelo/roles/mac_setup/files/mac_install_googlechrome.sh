#!/bin/sh

# Script to download, Silent Install and then clean up once installed Slack
# Writen by twitter.com/richhickson
# www.RichardHickson.com

#Kill Old Version
killall chrome

#Remove Old Version of Google Chrome
sudo rm -rf /Applications/"Google Chrome.app"/

#Make temp folder for downloads.
mkdir "/tmp/googlechrome/";
cd "/tmp/googlechrome/";

#Download Google Chrome.
curl -L -o /tmp/slack/googlechrome.dmg "https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg";

#Mount DMG
hdiutil attach /tmp/googlechrome/googlechrome.dmg -nobrowse;

#Copy App to Applications
sudo cp -R "/Volumes/googlechrome/Google Chrome.app" /Applications;

#Open Google Chrome
open "/Applications/Google Chrome.app"

#Unmount DMG
hdiutil detach /Volumes/googlechrome -force;

#tidy up
sudo rm -rf "/tmp/googlechrome";
