readonly local awsutils_script_dir=$(dirname "$0")

function awsutils() {
  local target_file="$awsutils_script_dir/src/main.ts"
  local node_modules="$thanos_script_dir/node_modules"
  if [ ! -d "$node_modules" ]; then
    (cd $awsutils_script_dir && npm install)
  fi

  $target_file $@
}

zle -N awsutils
