export BROWSER="powershell.exe /c start"
export IS_WSL=true
alias open="powershell.exe /c start"
alias copy="win32yank.exe -i"

function docker() {
  if [ ! "$(pgrep -x dockerd)" ]; then
    echo "Starting docker daemon..."
    sudo service docker start
  fi

  command docker "$@"
}
