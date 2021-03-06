#!/bin/bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sudo spctl --master-enable
brew install --cask xquartz
brew tap homebrew/cask-versions
winetricks macdriver=x11
brew install --cask --no-quarantine wine-crossover
sudo spctl --master-disable

