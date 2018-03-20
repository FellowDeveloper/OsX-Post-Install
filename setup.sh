#!/bin/bash
set -euo pipefail

###############################################################################
# Cask CASKS_TO_INSTALL:

declare -ar CASKS_TO_INSTALL=(
  "alfred"
  "iterm2"
  "keepassx"
  "skype"
  "telegram"
  "whatsapp"
  "slack"
  "google-chrome"
  "firefox"
  "opera"
  "visual-studio-code"
  "dropbox"
  "sourcetree"
  "evernote"
  "android-studio"
  "scroll-reverser"
  "vlc"
  "java8"
)
###############################################################################
#Brew PACKAGES_TO_INSTALL

declare -ar PACKAGES_TO_INSTALL=(
  "jenkins"
)
###############################################################################
#Gems

declare -ar GEMS_TO_INSTALL=(
  "cocoapods"
  "xcpretty"
)

###############################################################################
#Install/update homebrew

echo "Checking homebrew installation..."
if ! which brew; then
  echo "Homebrew is not installed. Installing..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew is already installed. Updating..."
  brew update
fi

###############################################################################
# Cask:

echo "Checking brew cask installation"
if brew info cask &>/dev/null; then
  echo "Cask is installed"
else
  echo "Cask is not installed. Installing..."
  brew tap caskroom/cask
  brew tap caskroom/versions
fi


## now loop through the above array
for app in "${CASKS_TO_INSTALL[@]}"
do
  echo "Checking $app installation"
  if brew cask ls --versions "$app" > /dev/null; then
    echo "$app is already installed"
  else
    brew cask install "$app"
  fi
done


for package in "${PACKAGES_TO_INSTALL[@]}"
do
  if brew ls --versions "$package" > /dev/null; then
    echo "$package is already installed"
  else
    echo "$package is not installed. Installing..."
    brew install "$package"
  fi
done


for gem in "${GEMS_TO_INSTALL[@]}"
do
  if gem spec "$gem" > /dev/null 2>&1; then
    echo "$gem is already installed."
  else
    echo "$gem is not installed. Installing..."
    sudo gem install "$gem"
  fi
done

###############################################################################

brew cleanup
brew cask cleanup
