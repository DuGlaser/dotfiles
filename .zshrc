### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi

source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit wait lucid light-mode for \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

zinit light zdharma/fast-syntax-highlighting

zinit cdclear -q # <- forget completions provided up to this moment
zinit ice depth=1; zinit light romkatv/powerlevel10k

# if you get "shift:505 occured" error, you can run the following command
# zinit cclear
zinit ice proto'git' pick'init.sh'
zinit light b4b4r07/enhancd

clear

source "$HOME/.zsh_custom/.zsh_path"
source "$HOME/.zsh_custom/.zsh_alias"
source "$HOME/.zsh_custom/.zsh_tmux"
source "$HOME/.zsh_custom/.zsh_complete"


### zsh setting
bindkey -v
bindkey "^?" backward-delete-char

setopt print_eight_bit

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000



### key repeat setting
defaults write -g InitialKeyRepeat -int 12
defaults write -g KeyRepeat -int 1.2 
KEYTIMEOUT=1



### ghq setting
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



### anyenv setting
eval "$(anyenv init -)"

functon ninoSudo(){
  imgcat ~/Documents/nino.png
  sudo $@
}
alias nsudo='ninoSudo'



### powerlevel10k setting
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



### alacritty setting
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
