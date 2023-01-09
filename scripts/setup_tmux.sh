#!/bin/bash

TPM_DIR=~/.tmux/plugins/tpm

rm -rf $TPM_DIR
git clone https://github.com/tmux-plugins/tpm $TPM_DIR
bash "${TPM_DIR}/bindings/install_plugins"
