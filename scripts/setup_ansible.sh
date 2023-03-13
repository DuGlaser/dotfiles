#!/bin/bash

if  [ "$(uname)" == 'Linux' ]; then
  sudo apt install ansible -y
else
  xcode-select --install
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install ansible
fi

mkdir -p ~/.ansible/tmp
sudo chown -R "$(whoami)" ~/.ansible/tmp
