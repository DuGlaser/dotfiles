#!/bin/bash

TMP_DIR=/tmp/dotfiles/ccls

git clone --depth=1 --recursive https://github.com/MaskRay/ccls $TMP_DIR
cd $TMP_DIR || exit 1

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release
sudo cmake --build Release --target install

rm -rf $TMP_DIR
