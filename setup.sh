#!/bin/bash 
set -e

###############################################################################
#Install/update homebrew

echo "Checking homebrew installation..."
which brew
if [[ $? != 0 ]] ; then
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

###############################################################################
# Cask apps:

declare -a apps=(
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
  "java8"
)

## now loop through the above array
for app in "${apps[@]}"
do
  echo "Checking $app installation"
  if brew cask ls --versions "$app" > /dev/null; then
    echo "$app is already installed"
  else
    brew cask install "$app"
  fi
done

###############################################################################
#Brew packages
declare -a packages=(
  "jenkins"
)

for package in "${packages[@]}"
do
  if brew ls --versions "$package" > /dev/null; then
    echo "$package is already installed"
  else
    echo "$package is not installed. Installing..."
    brew install "$package"
  fi
done

###############################################################################
#Gems

declare -a gems=(
  "cocoapods"
  "xcpretty"
)

for gem in "${gems[@]}"
do
  if gem spec "$gem" > /dev/null 2>&1; then
    echo "$gem is already installed."
  else
    echo "$gem is not installed. Installing..."
    sudo gem install "$gem"
  fi
done

###############################################################################