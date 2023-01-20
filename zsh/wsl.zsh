export BROWSER="powershell.exe /c start"
export IS_WSL=true
alias open="powershell.exe /c start"

path=(
    $HOME/dotfiles/global_scripts
    "$path[@]"
)
