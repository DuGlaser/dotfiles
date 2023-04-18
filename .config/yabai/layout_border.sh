#!/usr/bin/env bash

BSP_LAYOUT_BORDER_COLOR=0xff7fc06e
STACK_LAYOUT_BORDER_COLOR=0xff00cccc

CURRENT_COLOR=$(yabai -m config active_window_border_color)

if [ "$(yabai -m query --windows --window | jq -r '.["stack-index"]')" -eq 0  ]; then
  [ $CURRENT_COLOR != $BSP_LAYOUT_BORDER_COLOR ] && yabai -m config active_window_border_color $BSP_LAYOUT_BORDER_COLOR
else
  [ $CURRENT_COLOR != $STACK_LAYOUT_BORDER_COLOR ] && yabai -m config active_window_border_color $STACK_LAYOUT_BORDER_COLOR
fi
