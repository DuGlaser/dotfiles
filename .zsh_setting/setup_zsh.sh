set -u

echo "Set up zsh!"

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".gitmodules" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  # [[ "$f" == ".p10k.zsh" ]] && continue

  ln -sfnv ~/Dotfiles/zsh_setting/$f ~/$f 
  echo $f
done

echo "linked dotfiles complete!"
