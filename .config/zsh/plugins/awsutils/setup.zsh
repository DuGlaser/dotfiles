function awsutils() {
  local script_dir="$HOME/.config/zsh/plugins/awsutils"
  local target_file="$script_dir/src/main.ts"
  local node_modules="$script_dir/node_modules"
  if [ ! -d "$node_modules" ]; then
    (cd $script_dir && npm install)
  fi

  $target_file $@
}

zle -N awsutils
