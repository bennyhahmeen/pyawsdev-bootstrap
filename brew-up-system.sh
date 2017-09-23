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
  readline
  xz
  openssl
  idris
)

# Apps
apps=(
  dropbox
  google-backup-and-sync
  google-chrome
  firefox
  skype
  todoist
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
# KakaoTalk, Slack and others are installed through the App Store.

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

# Install python versions
echo ">>> installing pyenv and python versions..."
eval "$(pyenv init -)"
CFLAGS="-I$(brew --prefix openssl)/include" \
LDFLAGS="-L$(brew --prefix openssl)/lib" \
pyenv install 2.7.14
CFLAGS="-I$(brew --prefix openssl)/include" \
LDFLAGS="-L$(brew --prefix openssl)/lib" \
pyenv install 3.6.2
pyenv rehash
pyenv global 3.6.2

# Setup ruby
rbenv install 2.4.2

# Install some python packages
pyenv shell 3.6.2
pip install neovim
pip install flake8
pyenv shell 2.7.14
pip install neovim
pip install flake8
pyenv shell 3.6.2

# Install some NPM packages
npm install -g jshint jsonlint eslint csslint ternjs purescript pulp bower
 
# Install neovim
echo ">>> installing neovim..."
brew tap neovim/neovim
brew install neovim

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

brew cleanup

echo ">>> setting up dot files..."
# Clone down dot files
mkdir -p ~/GitHub/Tehnix
cd ~/GitHub/Tehnix
git clone git@github.com:Tehnix/dot-files.git
cd dot-files


echo ">>> opening links to apps that had no casks..."
open https://developer.apple.com/safari/download/

# Install some ruby packages
sudo gem install rsense mdl

# Install oh-my-zsh 
# NOTE: Do this last, since it will drop you into a zsh shell!
echo ">>> installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"