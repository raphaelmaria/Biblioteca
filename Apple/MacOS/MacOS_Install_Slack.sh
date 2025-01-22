# Script to download, Silent Install and then clean up once installed Slack
# Writen by twitter.com/richhickson
# www.RichardHickson.com

#Kill Old Version
killall Slack

#Remove Old Version of Slack
sudo rm -rf /Applications/Slack.app/

#Make temp folder for downloads.
mkdir "/tmp/slack/";
cd "/tmp/slack/";

#Download Slack.
curl -L -o /tmp/slack/slack.dmg "https://slack.com/ssb/download-osx";

#Mount DMG
hdiutil attach /tmp/slack/slack.dmg -nobrowse;

#Copy App to Applications
sudo cp -R "/Volumes/Slack/Slack.app" /Applications;

#Open Slack
open /Applications/Slack.app

#Unmount DMG
hdiutil detach /Volumes/Slack -force;

#tidy up
sudo rm -rf "/tmp/slack";