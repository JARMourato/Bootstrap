#!/bin/bash

################################################################################
### Configure macOS's helpful UserDefaults (aka simply `defaults`)
################################################################################

# Prerequisite:
# - SourceTree
# - GPG Suite

set -e # Immediately rethrows exceptions
set -x # Logs every command on Terminal

################################################################################
# Script Setup                                                                 #
################################################################################

# Close any open instances of the following programs, to prevent them from
# overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'
osascript -e 'tell app "Xcode" to quit'
osascript -e 'tell app "SourceTree" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

################################################################################
# Misc User Experience                                                         #
################################################################################

# Maximizes the application upon double clicking its navigation bar
defaults write -g AppleActionOnDoubleClick -string "Maximize"

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

################################################################################
# Trackpad                                                                     #
################################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Silent clicking
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0

# Haptic feedback
# 0: Light
# 1: Medium
# 2: Firm
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0

# Tracking Speed
# 0: Slow
# 3: Fast
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

# Enable swipe between pages
defaults write AppleEnableSwipeNavigateWithScrolls -bool false

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# wvous-tl-corner: Top Left corner
# wvous-tr-corner: Top Right corner
# wvous-bl-corner: Bottom Left corner
# wvous-br-corner: Bottom Right corner

# Top left screen corner → Desktop
defaults write com.apple.dock wvous-tl-corner -int 4
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 3
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom right screen corner → Desktop
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0

################################################################################
# Screenshots                                                                  #
################################################################################

# Create a Screenshots folder inside Pictures, if needed
mkdir -p ~/Pictures/Screenshots
# Save screenshots in the given folder
defaults write com.apple.screencapture location -string "~/Pictures/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Set shadows in screenshots as disabled
defaults write com.apple.screencapture disable-shadow -bool false

################################################################################
# Finder                                                                       #
################################################################################

# Set Desktop as the default location for new Finder windows
# For Desktop, use `PfDe` and `file://${HOME}/Desktop/`
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Whether icons for HDD, servers, and removable media should show on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool false

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the view modes: `icnv`, `clmv`, `glyv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

################################################################################
# Dock                                                                         #
################################################################################

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 40

# Set the large size of Dock items when over magnification effect
defaults write com.apple.dock largesize -float 64

# Enable magnification of the Dock
defaults write com.apple.dock magnification -bool true

# Enable the animation to minimize the application to the app icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Changes the orientation of the Dock
defaults write com.apple.dock orientation -string "bottom"

# Don’t automatically rearrange Spaces based on most recent use, as this shuffles the Spaces unexpectedly
defaults write com.apple.dock mru-spaces -bool false

# Don’t show recent applications in Dock
#defaults write com.apple.dock show-recents -bool false

# Add applications to Dock
defaults write com.apple.dock persistent-others -array-add "<dict>
    <key>tile-data</key>
    <dict>
        <key>arrangement</key>
        <integer>1</integer>
        <key>displayas</key>
        <integer>0</integer>
        <key>file-data</key>
        <dict>
            <key>_CFURLString</key>
            <string>file:///Applications/</string>
            <key>_CFURLStringType</key>
            <integer>15</integer>
        </dict>
        <key>preferreditemsize</key>
        <string>-1</string>
        <key>showas</key>
        <integer>0</integer>
    </dict>
    <key>tile-type</key>
    <string>directory-tile</string>
</dict>"

################################################################################
# Terminal                                                                     #
################################################################################

# Enable Secure Keyboard Entry in Terminal.app. Secure keyboard entry can
# prevent other apps on your computer or the network from detecting and
# recording what you type in Terminal.
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.Terminal SecureKeyboardEntry -bool true

################################################################################
# App Store                                                                    #
################################################################################

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

################################################################################
# Photos                                                                       #
################################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

################################################################################
# Xcode                                                                        #
################################################################################

# Automatically trim trailing whitespaces, including whitespace-only lines
defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines -bool YES

# Don't indent Swift switch case
defaults write com.apple.dt.Xcode DVTTextIndentCase -bool FALSE

# Indent text on paste
defaults write com.apple.dt.Xcode DVTTextIndentOnPaste -bool YES

# Set editor overscroll to small
defaults write com.apple.dt.Xcode DVTTextOverscrollAmount -float 0.25

# Hide authors panel
defaults write com.apple.dt.Xcode DVTTextShowAuthors -bool FALSE

# Hide minimap panel
defaults write com.apple.dt.Xcode DVTTextShowMinimap -bool FALSE

# Show all build steps on activity log
defaults write com.apple.dt.Xcode IDEActivityLogShowsAllBuildSteps -bool YES

# Analyzer results on activity log
defaults write com.apple.dt.Xcode IDEActivityLogShowsAnalyzerResults -bool YES

# Show errors on activity log
defaults write com.apple.dt.Xcode IDEActivityLogShowsErrors -bool YES

# Show warnings on activity log
defaults write com.apple.dt.Xcode IDEActivityLogShowsWarnings -bool YES

# Command-click jumps to definition
defaults write com.apple.dt.Xcode IDECommandClickOnCodeAction -int 1

# Show Indexing numeric progress
defaults write com.apple.dt.Xcode IDEIndexerActivityShowNumericProgress -bool YES

# Enable project build time
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

defaults write com.apple.dt.Xcode IDEEditorCoordinatorTarget_DoubleClick -string "SameAsClick"
defaults write com.apple.dt.Xcode IDEEditorNavigationStyle_DefaultsKey -string "IDEEditorNavigationStyle_OpenInPlace"
defaults write com.apple.dt.Xcode IDEIssueNavigatorDetailLevel -int 4
defaults write com.apple.dt.Xcode IDESearchNavigatorDetailLevel -int 4

################################################################################
# SourceTree                                                                   #
################################################################################

# Preferred dimensions
defaults write com.torusknot.SourceTreeNotMAS SidebarWidth_ -int 140
defaults write com.torusknot.SourceTreeNotMAS commitPaneHeight -int 242

# Also show diff for *.lock files
defaults write com.torusknot.SourceTreeNotMAS diffSkipFilePatterns -string "*.pbxuser, *.xcuserstate, Cartfile.resolved"

# Sets the GPG binary location
defaults write com.torusknot.SourceTreeNotMAS gpgProgram -string "/usr/local/MacGPG2/bin"

defaults write com.torusknot.SourceTreeNotMAS fileStatusStagingViewMode -int 1
defaults write com.torusknot.SourceTreeNotMAS fileStatusViewMode2 -int 0
# Skip tutorials
defaults write com.torusknot.SourceTreeNotMAS showStagingTip -bool false
defaults write com.torusknot.SourceTreeNotMAS DidShowGettingStarted -bool true
# Don't restore windows on startup
defaults write com.torusknot.SourceTreeNotMAS windowRestorationMethod -int 1
# Use fixed-width font for commit messages
defaults write com.torusknot.SourceTreeNotMAS useFixedWithCommitFont -bool true
# Display column guide in commit message at character: 50
defaults write com.torusknot.SourceTreeNotMAS commitColumnGuideWidth -int 50
# Keep bookmarks closed on startup
defaults write com.torusknot.SourceTreeNotMAS bookmarksClosedOnStartup -bool true
# Ask to bookmark upon opening new repo
defaults write com.torusknot.SourceTreeNotMAS bookmarksWindowOpen -bool false

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

################################################################################
# Finish                                                                       #
################################################################################

echo "Done. Please reboot your system for the changes to take effect."
