function awsutils() {
  target_dir="$HOME/dotfiles/zsh/awsutils"
  target_file="$target_dir/awsutils"

  if [ -f "$target_file" ]; then
    $target_file $@
  else
    if type "deno" > /dev/null 2>&1; then
      make -C $target_dir
    else
      echo "Error: Please install deno!" 1>&2
      return 1
    fi

  fi
}
zle -N awsutils
