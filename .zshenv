export EDITOR=nvim
export DENO_INSTALL_ROOT=$HOME/.deno

typeset -gx -U path
path=(
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $HOME/.local/bin(N-/)

    /usr/local/go/bin(N-/)
    $HOME/go/bin(N-/)
		$HOME/.cargo/bin(N-/)
    $DENO_INSTALL_ROOT/bin(N-/)
    $HOME/.cargo/env(N-/)
    "$path[@]"
)

if [ -e "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

typeset -gx -U fpath
fpath=(
  $HOME/.zsh/pure
  $fpath
)
