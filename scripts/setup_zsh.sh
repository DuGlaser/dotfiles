#!/bin/zsh
sudo rm -rf "$HOME/.zsh"
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
git clone https://github.com/agkozak/zsh-z.git "$HOME/.zsh/zsh-z"

find $HOME/.zsh -name '*?.zsh' | xargs -I@ zsh -c "zcompile @"
zcompile "$HOME/.zshrc"
