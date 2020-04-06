source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zplugin's installer chunk

# Two regular plugins loaded without tracking.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting

# Plugin history-search-multi-word loaded with tracking.
zinit load zdharma/history-search-multi-word

# Load OMZ Git library
zinit snippet OMZ::lib/git.zsh

# Load Git plugin from OMZ
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit cdclear -q # <- forget completions provided up to this moment
zinit ice depth=1; zinit light romkatv/powerlevel10k

# # # Plugin history-search-multi-word loaded with tracking.
# # ice wait'!0' zinit load zdharma/history-search-multi-word
#
# zinit load momo-lab/zsh-abbrev-alias 
# zinit load zsh-users/zsh-completions 
#
# # zinit light sorin-ionescu/prezto
#
# zinit light zsh-users/zsh-autosuggestions
zinit ice proto'git' pick'init.sh'
zinit light b4b4r07/enhancd

# # Source Prezto.
# autoload -Uz compinit
# compinit



if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

clear

# Customize to your needs...
source ~/.zinit/plugins/b4b4r07---enhancd/init.sh
source ~/.zinit/bin/zinit.zsh
export PATH="$PATH:$HOME/Development/flutter/bin"
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/12/bin

# export LANG=ja_JP.UTF-8
# export KCODE=u 

defaults write -g InitialKeyRepeat -int 12 
defaults write -g KeyRepeat -int 2 

# alias
alias v="nvim"
alias cls="clear"
alias ls="exa"
alias l="exa -a -1"
alias ll="exa -a -1 --icons"
alias rg="rg --colors 'match:bg:yellow' --colors 'match:fg:black' --colors 'match:style:nobold' --colors 'path:fg:green' --colors 'path:style:bold' --colors 'line:fg:yellow' --colors 'line:style:bold'"
alias grep="rg"

cdmkdir(){
  \mkdir "$@" && cd "$@"
}
alias mmkdir="cdmkdir"

cdls() {
  \cd "$@" && l
}
alias cl="cdls"


bindkey -v

setopt print_eight_bit

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# fzf
fb() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# tmux setting
function _left-pane() {
  tmux select-pane -L
}
zle -N left-pane _left-pane

function _down-pane() {
  tmux select-pane -D
}
zle -N down-pane _down-pane

function _up-pane() {
  tmux select-pane -U
}
zle -N up-pane _up-pane

function _right-pane() {
  tmux select-pane -R
}
zle -N right-pane _right-pane

function _backspace-or-left-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle backward-delete-char
  elif [[ ! -z ${TMUX} ]]; then
    zle left-pane
  fi
}
zle -N backspace-or-left-pane _backspace-or-left-pane

function _kill-line-or-up-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle kill-line
  elif [[ ! -z ${TMUX} ]]; then
    zle up-pane
  fi
}
zle -N kill-line-or-up-pane _kill-line-or-up-pane

function _accept-line-or-down-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle accept-line
  elif [[ ! -z ${TMUX} ]]; then
    zle down-pane
  fi
}
zle -N accept-line-or-down-pane _accept-line-or-down-pane

bindkey '^k' kill-line-or-up-pane
bindkey '^l' right-pane
bindkey '^h' backspace-or-left-pane
bindkey '^j' accept-line-or-down-pane

# ghq
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# anyenv
eval "$(anyenv init -)"

functon ninoSudo(){
  imgcat ~/Documents/nino.png
  sudo $@
}

alias nsudo='ninoSudo'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ "$TERM_PROGRAM" = "alacritty" ]; then
  if [[ ! -n $TMUX && $- == *l* ]]; then
    # get the IDs
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
      tmux new-session
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | $PERCOL | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
      tmux new-session
    elif [[ -n "$ID" ]]; then
      tmux attach-session -t "$ID"
    else
      :  # Start terminal normally
    fi
  fi
fi
