for f in *;do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  if [ -d "$f" ]; then

  ln -sfnv ~/dotfiles/.config/$f ~/.config/$f 
  echo $f

  fi
done
