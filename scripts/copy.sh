#!/bin/bash
# for tig

if  [ "$(uname)" == 'Linux' ]; then
  if [ "$IS_WSL" == 'true' ]; then
    win32yank.exe -i
  else
    if type xclip > /dev/null 2>&1; then
      xclip -selection c
    fi
  fi
else
 pbcopy
fi
