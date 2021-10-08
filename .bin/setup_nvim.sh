#!/bin/bash
cd ~
sudo rm -r neovim
git clone https://github.com/neovim/neovim
cd neovim
git switch v0.5.1
sudo make CMAKE_BUILD_TYPE=Release install
cd ~
sudo rm -r neovim
