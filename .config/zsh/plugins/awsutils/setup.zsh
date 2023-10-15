function awsutils() {
  local script_dir="$HOME/.config/zsh/plugins/awsutils"
  local source_file="$script_dir/src/main.ts"
  local target_dir="$script_dir/dist"
  local target_file="$target_dir/main.mjs"
  local node_modules="$script_dir/node_modules"

  if [ ! -d "$node_modules" ]; then
    echo "Installing dependencies..."
    (cd $script_dir && bun install --production --flozen-lockfile)
    echo ""
  fi

  if [ ! -f "$target_file" ]; then
    mkdir -p $target_dir
    echo "Building..."

    cat << EOF >> $target_file
#!/usr/bin/env node
import { createRequire } from 'node:module'
var require = createRequire(import.meta.url);
EOF
    bunx esbuild $source_file --bundle --platform=node --format=esm >> $target_file

    chmod +x $target_file
    echo ""
  fi

  $target_file $@
}
