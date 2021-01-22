set -u

echo "link home directory dotfiles"

dotfiles="$HOME/dotfiles"

ln -sfnv "$dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -sfnv "$dotfiles/.gitignore_global" "$HOME/.gitignore_global"
ln -sfnv "$dotfiles/.gitmessage.txt" "$HOME/.gitmessage.txt"

rm -rf "$HOME/.peco"
ln -sfnv "$dotfiles/.peco" "$HOME/.peco"

chmod +x $HOME/dotfiles/.config/setup_config.sh
$HOME/dotfiles/.config/setup_config.sh

echo "linked dotfiles complete!"
