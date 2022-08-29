#!/bin/bash
cd ~ || exit
sudo rm -r neovim
git clone https://github.com/neovim/neovim
cd neovim || exit
git reset --hard 6cc6e11929ad76a2dc5204aed95cb9ed1dafde23
sudo make CMAKE_BUILD_TYPE=Release install
cd ~ || exit
sudo rm -r neovim
