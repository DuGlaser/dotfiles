#!/bin/bash

TMP_DIR=/tmp/dotfiles/rust

mkdir -p $TMP_DIR
cd $TMP_DIR || exit 1

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o sh.rustup.rs
chmod +x sh.rustup.rs
./sh.rustup.rs -y

rm -rf $TMP_DIR
