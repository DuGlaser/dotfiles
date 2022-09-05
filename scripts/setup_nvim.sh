#!/bin/bash
cd ~ || exit
sudo rm -r neovim
git clone https://github.com/neovim/neovim
cd neovim || exit
sudo make CMAKE_BUILD_TYPE=Release install
cd ~ || exit
sudo rm -r neovim
