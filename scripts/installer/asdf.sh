#!/bin/bash

if [[ -d "$HOME/.asdf" ]]; then
	rm -rf "$HOME/.asdf"
fi
git clone https://github.com/asdf-vm/asdf "$HOME/.asdf" --branch v0.10.2

echo "load asdf..."
# shellcheck disable=1091
source "$HOME/.asdf/asdf.sh"

echo "Install nodejs plugin..."
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
echo "Installation of nodejs plugin is completed!"
