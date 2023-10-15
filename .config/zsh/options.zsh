# Ctrl-sでフリーズしないようにする
stty -ixon

# color
autoload -Uz colors ; colors

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
bindkey '^P' up-history
bindkey '^N' down-history

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt SHARE_HISTORY
setopt hist_ignore_dups
setopt hist_ignore_all_dups

# Use modern completion system
autoload -Uz compinit
[ ! "$(find ~/.zcompdump -mtime 1)" ] || compinit
compinit -C

zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion::complete:*' use-cache true

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line
