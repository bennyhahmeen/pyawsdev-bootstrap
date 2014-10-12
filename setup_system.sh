binaries=(
  python
  sshfs
  trash
  git
  mosh
  irssi
  tmux
  screen
  macvim
  zsh
  mackup
)

# Apps
apps=(
  dropbox
  google-chrome
  transmission
  appcleaner
  firefox
  qlmarkdown
  spotify
  flash
  iterm2
  qlprettypatch
  virtualbox
  mailbox
  qlstephen
  vlc
  quicklook-json
  skype
  transmission
  textmate
  cyberduck
  totalterminal
)


# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup

brew install caskroom/cask/brew-cask

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}