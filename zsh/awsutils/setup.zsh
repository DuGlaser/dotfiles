readonly local awsutils_script_dir=$(dirname "$0")

function awsutils() {
  target_file="$awsutils_script_dir/src/main.ts"
  $target_file $@
}

zle -N awsutils
