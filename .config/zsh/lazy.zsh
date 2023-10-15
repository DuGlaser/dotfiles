alias v="nvim"
alias l="exa -a -1"
alias cls="clear"
alias rg="rg --colors 'match:bg:yellow' --colors 'match:fg:black' --colors 'match:style:nobold' --colors 'path:fg:green' --colors 'path:style:bold' --colors 'line:fg:yellow' --colors 'line:style:bold'"
alias gg="lazygit"

function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

function peco-src () {
  local selected_dir=$(ghq list -p | fzf)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src


# start tmux
if type "tmux" > /dev/null 2>&1; then
  if [[ ! -n $TMUX ]]; then
    # get the IDs
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
      tmux -u new-session
      return
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | fzf | cut -d: -f1`"

    if [[ "$ID" = "${create_new_session}" ]]; then
      tmux -u new-session
    elif [[ -n "$ID" ]]; then
      tmux -u attach-session -t "$ID"
    fi
  fi
fi

# load env
local env_script_dir="$HOME/.config/zsh/env"

if [ -d "/mnt/c" ]; then
  source "$env_script_dir/wsl.zsh"
fi

if [[ "$(uname)" == "Darwin" ]]; then
  source "$env_script_dir/darwin.zsh"
fi

unset env_script_dir

# setup rtx
eval "$(rtx activate zsh)"
