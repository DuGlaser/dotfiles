#!/bin/bash

git clone --recursive https://github.com/DuGlaser/dotfiles.git $HOME/dotfiles

cd $HOME/dotfiles
make init
