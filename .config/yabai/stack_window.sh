#!/usr/bin/env bash

dir=$1
window=$(yabai -m query --windows --window | jq -r '.id') 

yabai -m window $window --stack $dir 

if [[ $? -ne 0 ]] && (yabai -m query --windows --window | jq -e '."stack-index" != 0'); then
    yabai -m window --insert $dir \
    && yabai -m window $window --toggle float \
    && yabai -m window $window --toggle float
fi

if [[ $(yabai -m query --spaces --space | jq -r '.type') = "stack" ]]; then
  yabai -m space --layout bsp
fi
