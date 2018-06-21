#!/bin/sh
# coding: utf-8

PYVERSION="3.6.5"

binaries=(
  coreutils
  findutils
  bash
  grep
  openssl
  awscli
  git
  pyenv
  docker
)

# Apps
apps=(
)

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

echo ">>> installing binaries..."
brew install ${binaries[@]}

brew cleanup

# Install apps via homebrew cask (we loop, because some might fail)
echo ">>> installing apps..."
for app in "${apps[@]}"
do
   brew cask install $app
done


# Install python versions
echo ">>> installing pyenv and python versions..."
eval "$(pyenv init -)"
CFLAGS="-I$(brew --prefix openssl)/include" \
LDFLAGS="-L$(brew --prefix openssl)/lib" \
pyenv install $PYTHONVERSION
pyenv rehash
pyenv global $PYTHONVERSION

brew cleanup
