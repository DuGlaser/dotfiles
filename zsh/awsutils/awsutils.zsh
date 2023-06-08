function awsutils() {
  if type "zx" > /dev/null 2>&1;then
    zx $HOME/dotfiles/zsh/awsutils/main.mjs $@
  else
    echo "Error: Please install zx! `npm install -g zx`" 1>&2
    exit 1
  fi
}
zle -N awsutils
