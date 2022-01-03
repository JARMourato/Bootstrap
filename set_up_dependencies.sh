#!/bin/bash

################################################################################
### Install Dependencies
################################################################################

set -e # Immediately rethrows exceptions
# set -x # Logs every command on Terminal

echo "🚀 Starting setup"

# Ask for the administrator password upfront
sudo -v

# Install Homebrew if not already installed
if test ! $(which brew); then
	echo "🍺 Installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# In case paths have not been set up yet
source ~/.zshrc

echo "🍺 Updating homebrew..."
brew update

if test ! $(xcode-select -p); then
	# Install Xcode 
	brew install --cask xcodes
	/bin/bash -c "$(open -a xcodes)"
	read -p "Press enter to continue after installing Xcode..." < /dev/tty

	if test ! $(xcode-select -p); then
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
echo "🍺 Installing brew packages..."
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
echo "🍺 Installing cask apps..."
brew install --cask ${CASKS[@]}

GEMS=(
	fastlane -NV
	bundler
)
echo "💎 Installing Ruby gems..."
sudo gem install ${GEMS[@]} -N

echo "🧼 Cleaning up..."
brew cleanup -s

echo "🎉 Dependencies Setup complete!"