source "$HOME/.zplugin/bin/zplugin.zsh"

autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

# Two regular plugins loaded without tracking.
zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting

# Load Git plugin from OMZ
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin cdclear -q

# # Plugin history-search-multi-word loaded with tracking.
# ice wait'!0' zplugin load zdharma/history-search-multi-word

zplugin load momo-lab/zsh-abbrev-alias 
zplugin load zsh-users/zsh-syntax-highlighting 
zplugin load zsh-users/zsh-completions 

# zplugin light sorin-ionescu/prezto

zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-completions
zplugin light b4b4r07/enhancd

# Source Prezto.
autoload -Uz compinit
compinit

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

clear

# Customize to your needs...
source ~/.zplugin/plugins/b4b4r07---enhancd/init.sh
export PATH="$PATH:$HOME/Development/flutter/bin"
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$(go env GOPATH)/bin

# alias
alias v="nvim"
alias cls="clear"

bindkey -v

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
