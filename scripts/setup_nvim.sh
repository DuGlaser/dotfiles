#!/bin/bash

TMP_DIR=/tmp/dotfiles/neovim

git clone https://github.com/neovim/neovim $TMP_DIR
cd $TMP_DIR || exit 1

sudo make CMAKE_BUILD_TYPE=Release install

rm -rf $TMP_DIR
