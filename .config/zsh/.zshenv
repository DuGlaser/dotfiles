export EDITOR=nvim
export DENO_INSTALL_ROOT=$HOME/.deno
export XDG_CONFIG_HOME=$HOME/.config
export SHELDON_CONFIG_DIR=$XDG_CONFIG_HOME/zsh/sheldon

export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LANG=ja_JP.UTF-8

if [ -e "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

typeset -gx -U path
path=(
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $HOME/.local/bin(N-/)
		$HOME/.cargo/bin(N-/)
    $DENO_INSTALL_ROOT/bin(N-/)
    $HOME/.cargo/env(N-/)
    $HOME/.rd/bin(N-/)
    "$path[@]"
)
