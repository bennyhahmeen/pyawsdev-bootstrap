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
  mypy
  icu4c
  pandoc
  llvm
  wemux
  go
)

# Apps
apps=(
  alfred
  atom
  atom-beta
  basictex
  battle-net
  bettertouchtool
  cyberduck
  discord
  dropbox
  font-hasklig
  google-backup-and-sync
  google-chrome
  iterm2
  keybase
  mamp
  mendeley-desktop
  monodraw
  nix
  oni
  psequel
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-json
  skype
  spotify
  steam
  teamviewer
  transmission
  twitch
  typora
  vimr
  visual-studio-code
  vlc
)
# KakaoTalk, Slack and others are installed through the App Store.

export LC_CTYPE=en.US.UTF-8
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"

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

# Install scalafmt
brew install --HEAD olafurpg/scalafmt/scalafmt
scalafmt --version

brew cleanup

# Install apps via homebrew cask (we loop, because some might fail)
echo ">>> installing apps..."
for app in "${apps[@]}"
do
   brew cask install $app
done

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
pyenv global 2.7.14 3.6.2

# Setup ruby
rbenv install 2.4.2

# Install some python packages
pyenv rehash
pyenv shell 2.7.14 3.6.2
pyenv global 2.7.14 3.6.2
pip install neovim
pip install flake8
pip3 install neovim
pip3 install flake8

# Install some NPM packages
npm install -g jshint jsonlint eslint csslint ternjs bower
npm install -g psvm psc-package pulp

# Install the Puresript compiler.
psvm install v0.11.7 
psvm use v0.11.7
 
# Install neovim
echo ">>> installing neovim..."
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
./link.sh


echo ">>> opening links to apps that had no casks..."
open https://developer.apple.com/safari/download/

# Install some haskell packages
stack install ghc-mod
stack install hlint
stack install ghcid
stack install hasktags
stack install hoogle
stack install pointfree 
stack install pointful 
stack install cabal-install
stack install hindent
stack install stylish-haskell
stack install brittany
stack install hpack
#stack install hpack-convert

# Build local hoogle database
stack hoogle

# Install rustup.
curl https://sh.rustup.rs -sSf | sh
# Install the Rust Language Server (RLS).
rustup update
rustup component add rls-preview rust-analysis rust-src

# Install the Go LSP.
go get -u github.com/sourcegraph/go-langserver

# Install the Python LSP.
pip install python-language-server
pip3 install python-language-server

# Get composer and install the PHP LSP.
brew install homebrew/php/composer
composer require felixfbecker/language-server

# Install spaceneovim (will require exiting nvim)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tehnix/spaceneovim/master/install.sh)"

# Install some ruby packages (requires sudo, so will need interaction)
sudo gem install rsense mdl

# Install oh-my-zsh 
# NOTE: Do this last, since it will drop you into a zsh shell!
echo ">>> installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"