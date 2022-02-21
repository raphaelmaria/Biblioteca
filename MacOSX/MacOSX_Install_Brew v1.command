#!/bin/bash

#Install BREW
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install wget
brew install curl
brew install python@3.9
brew install archiver

# instala macOS apps, fontes e plugins, e outros programas não open source.
brew install --cask adobe-acrobat-reader
brew install --cask vlc
brew install --cask google-chrome
brew install --cask lulu



