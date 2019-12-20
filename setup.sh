set -u

echo "link home directory dotfiles"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/Dotfiles/.zprezto/runcoms/^README.md(.N); do
  ln -sfnv "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

ln -sfnv ~/Dotfiles/.zprezto ~/.zprezto 
ln -sfnv ~/Dotfiles/.zshrc ~/.zshrc
ln -sfnv ~/Dotfiles/.config ~/.config

echo "linked dotfiles complete!"
