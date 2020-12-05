set -u

echo "Set up zsh!"

dotfiles="$HOME/dotfiles"

ln -sfnv "$dotfiles/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sfnv "$dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -sfnv "$dotfiles/.zshenv" "$HOME/.zshenv"
ln -sfnv "$dotfiles/.zshrc" "$HOME/.zshrc"
ln -sfnv "$dotfiles/.zsh_custom" "$HOME/.zsh_custom"

echo "finish!"
