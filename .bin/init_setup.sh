set -u

echo "link home directory dotfiles"

dotfiles="$HOME/dotfiles"

ln -sfnv "$dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -sfnv "$dotfiles/.gitignore_global" "$HOME/.gitignore_global"
ln -sfnv "$dotfiles/.gitmessage.txt" "$HOME/.gitmessage.txt"
ln -sfnv "$dotfiles/.peco" "$HOME/.peco"
ln -sfnv "$dotfiles/.config" "$HOME/.config"

echo "linked dotfiles complete!"
