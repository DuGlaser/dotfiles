function source {
  ensure_zcompiled $1
  builtin source $1
}
function ensure_zcompiled {
  local compiled="$1.zwc"
  if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
    echo "Compiling $1..."
    zcompile $1
  fi
}
ensure_zcompiled ~/.zshrc

## setup sheldon
zshrc_dir="$HOME/.config/zsh"
cache_dir="$zshrc_dir/sheldon"
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$cache_dir/plugins.toml"
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $cache_dir
  sheldon source > $sheldon_cache
fi

source "$sheldon_cache"
source "$zshrc_dir/options.zsh"
zsh-defer source "$zshrc_dir/lazy.zsh"
zsh-defer unfunction source
unset cache_dir sheldon_cache sheldon_toml
