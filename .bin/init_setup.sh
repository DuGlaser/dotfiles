#!/bin/bash

set -u

echo "link home directory dotfiles"

dotfiles="$HOME/dotfiles"

mkdir -p $HOME/.config/git

ln -sfnv "$dotfiles/.gitconfig" "$HOME/.config/git/config"
ln -sfnv "$dotfiles/.gitignore_global" "$HOME/.config/git/ignore"
ln -sfnv "$dotfiles/.gitmessage.txt" "$HOME/.gitmessage.txt"
ln -sfnv "$dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -sfnv "$dotfiles/.asdfrc" "$HOME/.asdfrc"
ln -sfnv "$dotfiles/.ideavimrc" "$HOME/.ideavimrc"
ln -sfnv "$dotfiles/.zshrc" "$HOME/.zshrc"
ln -sfnv "$dotfiles/.zshenv" "$HOME/.zshenv"

dotfiles_config="$dotfiles/.config"
config="$HOME/.config"

ln -sfnv "$dotfiles_config/alacritty" "$config/alacritty"
ln -sfnv "$dotfiles_config/bat" "$config/bat"
ln -sfnv "$dotfiles_config/fish" "$config/fish"
ln -sfnv "$dotfiles_config/karabiner" "$config/karabiner"
ln -sfnv "$dotfiles_config/nvim" "$config/nvim"
ln -sfnv "$dotfiles_config/starship.toml" "$config/starship.toml"

echo "linked dotfiles complete!"
