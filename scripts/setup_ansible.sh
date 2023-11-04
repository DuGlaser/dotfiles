#!/bin/bash

if  [ "$(uname)" == 'Linux' ]; then
  sudo apt update
  sudo apt install -y software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt install -y ansible
else
  xcode-select --install
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  source "$HOME/dotfiles/.zshrc"
  brew install ansible
fi

mkdir -p ~/.ansible/tmp
sudo chown -R "$(whoami)" ~/.ansible/tmp
