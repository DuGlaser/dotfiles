set -u

echo "Set up fish!"

fish_setting="$HOME/dotfiles/.fish_setting"

ln -sfnv "$fish_setting/.tmux.conf" "$HOME/.tmux.conf"

echo "finish!"
