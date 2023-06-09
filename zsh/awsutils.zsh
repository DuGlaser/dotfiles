function awsutils() {
  if type "zx" > /dev/null 2>&1;then
    zx $HOME/dotfiles/zsh/awsutils/main.mjs $@
  else
    echo "Error: Please install zx!" 1>&2
    return 1
  fi
}
zle -N awsutils
