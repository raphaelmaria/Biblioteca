#!/usr/bin/env bash
# Team Identifier: 6ENJ69K633

varCylance="https://rmtechfiles.s3.amazonaws.com/ScriptFiles/LOFT/BlackberryCylance/CylancePROTECT.pkg"

sudo mkdir -p /tmp/cylance
cd /tmp/cylance
sudo /usr/sbin/spctl kext-consent add 6ENJ69K633

curl -O $varCylance
echo VPF8wqbahVRTgeUIqXIpD0tta > cyagent_install_token
sudo installer -pkg CylancePROTECT.pkg -target /
  
