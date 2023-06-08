# alias
alias v="nvim"
alias l="exa -a -1"
alias cls="clear"
alias rg="rg --colors 'match:bg:yellow' --colors 'match:fg:black' --colors 'match:style:nobold' --colors 'path:fg:green' --colors 'path:style:bold' --colors 'line:fg:yellow' --colors 'line:style:bold'"
alias hub="echo 'ghを使え' # "

if [ -d "/mnt/c" ]; then
  source "$HOME/dotfiles/zsh/wsl.zsh"
fi

# Ctrl-sでフリーズしないようにする
stty -ixon

# color
autoload -Uz colors ; colors

# prompt
autoload -U promptinit; promptinit
prompt pure

# pushd
setopt auto_pushd
setopt pushd_ignore_dups

# fix typo
setopt correct

# enable comment out
setopt interactive_comments

# vi keybindings
bindkey -v
bindkey "^?" backward-delete-char

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt SHARE_HISTORY
setopt hist_ignore_dups
setopt hist_ignore_all_dups

# Use modern completion system
autoload -Uz compinit
compinit

export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion::complete:*' use-cache true

# set lang
export LANG=ja_JP.UTF-8

# tmux
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

# custom setting
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line

# ghq + peco
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

# custom source
source "$HOME/dotfiles/zsh/awsutils/awsutils.zsh"

# plugins
## zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^e' autosuggest-accept

## zsh-z
source ~/.zsh/zsh-z/zsh-z.plugin.zsh

## setup rtx
eval "$(rtx activate zsh)"
