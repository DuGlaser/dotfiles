export EDITOR=nvim

typeset -gx -U path
path=(
    /usr/local/bin(N-/)
    /usr/local/go/bin(N-/)
    ~/bin(N-/)
    $HOME/go/bin(N-/)
    "$path[@]"
)

typeset -gx -U fpath
fpath=(
  $HOME/.zsh/pure
  $HOME/.asdf/completions(N-/)
  $fpath
)
