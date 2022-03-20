export EDITOR=nvim

typeset -gx -U path
path=(
    /usr/local/bin(N-/)
    ~/bin(N-/)
    $HOME/go/bin
    "$path[@]"
)

typeset -gx -U fpath
fpath=(
  $HOME/.zsh/pure
  ${ASDF_DIR}/completions(N-/)
  $fpath
)
