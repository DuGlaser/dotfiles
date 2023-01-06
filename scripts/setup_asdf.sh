#!/bin/bash

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2

# shellcheck disable=1091
source "$HOME/.asdf/asdf.sh"
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
