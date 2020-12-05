set -u

echo "Set up zsh!"

zsh_setting="$HOME/dotfiles/.zsh_setting"

ln -sfnv "$zsh_setting/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sfnv "$zsh_setting/.tmux.conf" "$HOME/.tmux.conf"
ln -sfnv "$zsh_setting/.zshenv" "$HOME/.zshenv"
ln -sfnv "$zsh_setting/.zshrc" "$HOME/.zshrc"

rm -rf "$HOME/.zsh_custom"
ln -sfnv "$zsh_setting/.zsh_custom" "$HOME/.zsh_custom"

echo "finish!"
