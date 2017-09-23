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
  rbenv
  ctags-exuberant
  wget
  npm
  tldr
)

# Apps
apps=(
  dropbox
  google-backup-and-sync
  google-chrome
  firefox
  slack
  skype
  spotify
  vlc
  transmission
  alfred
  iterm2
  qlprettypatch
  qlstephen
  quicklook-json
  qlmarkdown
  teamviewer
  cyberduck
  psequel
  mamp
  monodraw
  mendeley-desktop
  atom
  visual-studio-code
  steam
  battle-net
  #league-of-legends
  #eve-online
  #palua
)

export LC_CTYPE=en.US.UTF-8
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:${PATH}"

# Make sure xcode command line tools are installed
xcode-select --install

echo ">>> installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# Update homebrew recipes
brew update

echo ">>> installing common cli utils..."
# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash
# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

echo ">>> installing binaries..."
brew install ${binaries[@]}

brew cleanup

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo ">>> installing apps..."
brew cask install ${apps[@]}

# Install hasklig
echo ">>> installing the hasklig font..."
brew tap caskroom/fonts
brew cask install font-hasklig

# Install neovim
echo ">>> installing neovim..."
brew tap neovim/neovim
brew install neovim

# Install python versions
echo ">>> installing pyenv and python versions..."
eval "$(pyenv init -)"
pyenv install 2.7.14
pyenv install 3.6.2
pyenv rehash
pyenv global 3.6.2

# Install stack
echo ">>> installing stack..."
curl -sSL https://get.haskellstack.org/ | sh
stack setup

# Install spacemacs
echo ">>> installing spacmacs and emacs-plus..."
git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
brew tap d12frosted/emacs-plus
brew install emacs-plus --HEAD --with-natural-title-bars
brew linkapps emacs-plus 

# Install oh-my-zsh
echo ">>> installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew cleanup

echo ">>> setting up dot files..."
# Clone down dot files
mkdir -p ~/GitHub/Tehnix
cd ~/GitHub/Tehnix
git clone git@github.com:Tehnix/dot-files.git
cd dot-files
# Symlink them into home directory
ln -s spacemacs ~/.spacemacs
ln -s zshrc ~/.zshrc
ln -s gitignore_global ~/.gitignore_global
ln -s curlrc ~/.curlrc
ln -s irssi ~/.irssi


echo ">>> opening links to apps that had no casks..."
open https://developer.apple.com/safari/download/