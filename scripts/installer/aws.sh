#!/bin/bash

mkdir -p tmp/aws-cli
cd tmp/aws-cli || exit 0

if [ "$(uname)" == 'Linux' ]; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
else
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
fi

cd ../../
rm -rf tmp/aws-cli
