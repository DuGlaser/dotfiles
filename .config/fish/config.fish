# linuxbrew setting
set -x PATH /home/linuxbrew/.linuxbrew/bin $PATH
set -g fish_user_paths "/home/linuxbrew/.linuxbrew/sbin" $fish_user_paths

# fish-ghq setting
set GHQ_SELECTOR peco

set -U fish_color_normal normal
set -U fish_color_command 99cc99
set -U fish_color_quote ffcc66
set -U fish_color_redirection d3d0c8
set -U fish_color_end cc99cc
set -U fish_color_error f2777a
set -U fish_color_param d3d0c8
set -U fish_color_comment ffcc66
set -U fish_color_match 6699cc
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 6699cc
set -U fish_color_escape 66cccc
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 747369
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

set PATH $HOME/.cargo/bin $PATH

# pure prompt setting
_pure_set_default pure_show_system_time false

# asdf setting
source ~/.asdf/asdf.fish

# lang
# set -xg LANG es_US.UTF-8

if test -z $TMUX
    attach_tmux_session_if_needed
end

# load profile
bass source /etc/profile

# alias
alias v="nvim"
alias l="exa -a -1"
alias cls="clear"
alias rg="rg --colors 'match:bg:yellow' --colors 'match:fg:black' --colors 'match:style:nobold' --colors 'path:fg:green' --colors 'path:style:bold' --colors 'line:fg:yellow' --colors 'line:style:bold'"
alias grep="rg"

# default EDITOR
set -gx EDITOR nvim
