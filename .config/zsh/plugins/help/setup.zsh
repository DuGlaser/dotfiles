function help() {
  local script_dir="$HOME/.config/zsh/plugins/help"
  local source_file="$script_dir/src/main.ts"
  local target_dir="$script_dir/dist"
  local target_file="$target_dir/main.mjs"
  local node_modules="$script_dir/node_modules"

  if [ ! -d "$node_modules" ]; then
    echo "Installing dependencies..."
    make -C $script_dir init
    echo ""
  fi

  if [ ! -f "$target_file" ]; then
		make -C $script_dir build link
    echo ""
  fi

  command help $@
}
