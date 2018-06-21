#!/bin/bash
# coding: utf-8

PYTHONVERSION="3.6.5"

binaries=(
  coreutils
  findutils
  bash
  grep
  openssl
  awscli
  git
  pyenv
)

# Apps
apps=(
  docker
)


export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"


# Make sure xcode command line tools are installed
xcode-select --install

echo ">>> installing homebrew..."
if [ ! -x `which brew` ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi 

# Update homebrew recipes
brew update


echo ">>> installing binaries..."
for binary in "${binaries[@]}"
do
  brew list $binary &>/dev/null
  if [ $? -ne 0 ]; then
    brew install $binary
  else
    brew upgrade $binary
  fi
done


# Install apps via homebrew cask (we loop, because some might fail)
echo ">>> installing apps..."
for app in "${apps[@]}"
do
  brew list $app &>/dev/null
  if [ $? -ne 0 ]; then
    brew cask install $app
  else
    brew cask upgrade $app
  fi
done
brew cleanup


# Install python versions
echo ">>> installing pyenv and python versions..."
eval "$(pyenv init -)"
pyenv uninstall -f $PYTHONVERSION
env PYTHON_CONFIGURE_OPTS="--enable-shared" \
  pyenv install $PYTHONVERSION
pyenv rehash
pyenv global $PYTHONVERSION


echo ">>> updating and installing python modules..."
python -m pip install --upgrade setuptools pip wheel pipenv


echo ">>> setting up bash..."
grep '\$(pyenv init -)' ~/.bash_profile &>/dev/null
if [ $? -ne 0 ]; then
  echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
fi

grep 'PIPENV_VENV_IN_PROJECT' ~/.bash_profile &>/dev/null
if [ $? -ne 0 ]; then
  echo 'export PIPENV_VENV_IN_PROJECT=true' >> ~/.bash_profile
fi
