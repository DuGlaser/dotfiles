#!/bin/bash
if  [ "$(uname)" == 'Linux' ]; then
  if type xclip > /dev/null 2>&1; then
    xclip -selection c
  fi
else
 pbcopy
fi
