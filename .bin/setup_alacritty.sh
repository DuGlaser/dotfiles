#!/bin/bash
cd ~ || exit
rm -rf alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty || exit
cargo build --release

sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

cd ../
rm -rf alacritty
