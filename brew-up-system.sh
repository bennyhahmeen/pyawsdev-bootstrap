#!/bin/sh
binaries=(
  trash
  git
  mosh
  tmux
  screen
  zsh
  mackup
  pyenv
  ctags-exuberant
  wget
  npm
)

# Apps
apps=(
  dropbox
  google-drive
  google-chrome
  firefox
  mailbox
  slack
  telegram
  skype
  spotify
  vlc
  flash
  transmission
  alfred
  iterm2
  appcleaner
  qlprettypatch
  qlstephen
  quicklook-json
  qlmarkdown
  perian
  rescuetime
  teamviewer
  ghc
  cyberduck
  psequel
  mamp
  vmware-fusion
  monodraw
  mendeley-desktop
  textmate
  atom
  league-of-legends
  battle-net
  minecraft
  steam
  #eve-online
  #sunrise
  #palua
)

export LC_CTYPE=en.US.UTF-8
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:${PATH}"

# Make sure xcode command line tools are installed
xcode-select --install

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


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


# Install neovim
brew tap neovim/neovim
brew install --HEAD neovim


# Install python versions
eval "$(pyenv init -)"
pyenv install 2.7.9
pyenv install 3.4.2
pyenv rehash
pyenv global 2.7.9
#sudo easy_install pip


# Install macvim
brew install macvim --override-system-vim --with-lua --with-luajit --with-python3 --HEAD
# Install haskell vim 
curl -o - https://raw.githubusercontent.com/begriffs/haskell-vim-now/master/install.sh | bash


# Setup cabal
cabal update && cabal install alex happy
