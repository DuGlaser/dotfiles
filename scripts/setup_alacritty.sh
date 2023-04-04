#!/bin/bash

TMP_DIR=/tmp/dotfiles/alacritty

git clone https://github.com/alacritty/alacritty.git $TMP_DIR
cd $TMP_DIR || exit 1
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

if  [ "$(uname)" == 'Linux' ]; then
  cargo build --release

  sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database
else
  rm -rf /Applications/Alacritty.app
  make app
  cp -r target/release/osx/Alacritty.app /Applications/
fi

rm -rf $TMP_DIR
