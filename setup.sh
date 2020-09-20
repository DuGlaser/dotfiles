set -u

echo "link home directory dotfiles"

# setopt EXTENDED_GLOB
# for rcfile in "${ZDOTDIR:-$HOME}"/Dotfiles/.zprezto/runcoms/^README.md(.N); do
#   ln -sfnv "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
# done

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".gitmodules" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  # [[ "$f" == ".p10k.zsh" ]] && continue

  ln -sfnv ~/Dotfiles/$f ~/$f 
  echo $f
done

echo "linked dotfiles complete!"
