#!/bin/bash

set -u

echo "link home directory dotfiles"

dotfiles="$HOME/dotfiles"

ln -sfnv "$dotfiles/.gitconfig" "$HOME/.config/git/config"
ln -sfnv "$dotfiles/.gitignore_global" "$HOME/.config/git/ignore"
ln -sfnv "$dotfiles/.gitmessage.txt" "$HOME/.gitmessage.txt"
ln -sfnv "$dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -sfnv "$dotfiles/.asdfrc" "$HOME/.asdfrc"

rm "$HOME/.peco"
ln -sfnv "$dotfiles/.peco" "$HOME/.peco"

dotfiles_config="$dotfiles/.config"
config="$HOME/.config"

ln -sfnv "$dotfiles_config/alacritty" "$config/alacritty"
ln -sfnv "$dotfiles_config/bat" "$config/bat"
ln -sfnv "$dotfiles_config/fish" "$config/fish"
ln -sfnv "$dotfiles_config/karabiner" "$config/karabiner"
ln -sfnv "$dotfiles_config/nvim" "$config/nvim"

chmod +x $HOME/dotfiles/.config/setup_config.sh

echo "linked dotfiles complete!"
