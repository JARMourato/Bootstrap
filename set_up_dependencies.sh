#!/bin/bash

################################################################################
### Install Dependencies
################################################################################

# set -e # Immediately rethrows exceptions
# set -x # Logs every command on Terminal

echo "๐ Starting setup"

# Ask for the administrator password upfront
sudo -v

# Install Homebrew if not already installed
if test ! $(which brew); then
	echo "๐บ Installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# In case paths have not been set up yet
source ~/.zshrc

echo "๐บ Updating homebrew..."
brew update

# Check Xcode
xcode=`ls /Applications | grep 'Xcode-'`

if [[ ! -z "$xcode" ]]; then
	echo "Xcode is already installed ๐"
else
	# Install Xcode 
	brew install --cask xcodes
	/bin/bash -c "$(open -a Xcodes)"
	read -p "Press enter to continue after installing Xcode..." < /dev/tty
	
	if [[ -z "$xcode" ]]; then
		echo "Xcode not installed"
		exit 1
	fi
fi

# Install utilities and apps
PACKAGES=(
	detekt
	ktlint
	hub
	python
	ruby
	swiftformat
	swiftlint
)
echo "๐บ Installing brew packages..."
brew install ${PACKAGES[@]}

CASKS=(
	android-studio
	bitwarden
	google-chrome
	gpg-suite-no-mail
	iina
	setapp
	sf-symbols
	slack
	sourcetree
	spotify
	sublime-text
	telegram
	whatsapp
)
echo "๐บ Installing cask apps..."
brew install --cask ${CASKS[@]}

GEMS=(
	fastlane -NV
	bundler
)
echo "๐ Installing Ruby gems..."
sudo gem install ${GEMS[@]} -N

echo "๐งผ Cleaning up..."
brew cleanup -s

echo "๐ Dependencies Setup complete!"
