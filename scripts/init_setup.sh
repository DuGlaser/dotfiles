#!/bin/bash

set -u

echo "link home directory dotfiles"

dotfiles="$HOME/dotfiles"

ln -sfnv "$dotfiles/.ideavimrc" "$HOME/.ideavimrc"
ln -sfnv "$dotfiles/.rtx.tmpl.toml" "$HOME/.rtx.toml"
ln -sfnv "$dotfiles/.tigrc" "$HOME/.tigrc"
ln -sfnv "$dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -sfnv "$dotfiles/.zshenv" "$HOME/.zshenv"
ln -sfnv "$dotfiles/.zshrc" "$HOME/.zshrc"

dotfiles_config="$dotfiles/.config"
config="$HOME/.config"
mkdir -p "$HOME/.config"

ln -sfnv "$dotfiles_config/.atc.toml" "$config/.atc.toml"
ln -sfnv "$dotfiles_config/alacritty" "$config/alacritty"
ln -sfnv "$dotfiles_config/bat" "$config/bat"
ln -sfnv "$dotfiles_config/fish" "$config/fish"
ln -sfnv "$dotfiles_config/git" "$config/git"
ln -sfnv "$dotfiles_config/karabiner" "$config/karabiner"
ln -sfnv "$dotfiles_config/lazygit" "$config/lazygit"
ln -sfnv "$dotfiles_config/nvim" "$config/nvim"
ln -sfnv "$dotfiles_config/skhd" "$config/skhd"
ln -sfnv "$dotfiles_config/starship.toml" "$config/starship.toml"
ln -sfnv "$dotfiles_config/yabai" "$config/yabai"

echo "linked dotfiles complete!"
