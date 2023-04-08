#!/bin/bash

TMP_DIR=/tmp/dotfiles/aws-cli

mkdir -p $TMP_DIR 
cd $TMP_DIR || exit 1

if [ "$(uname)" == 'Linux' ]; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
else
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
fi

sudo rm -rf $TMP_DIR
