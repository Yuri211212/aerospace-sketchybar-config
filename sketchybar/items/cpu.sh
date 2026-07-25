#!/bin/bash

cpu_percent=(
  label.font="$FONT:Heavy:12"
  label=CPU
  y_offset=0
  padding_right=15
  width=55
  icon="󰻠"
  icon.font="$FONT:Regular:14.0"
  icon.drawing=on
  update_freq=4
  mach_helper="$HELPER"
)

sketchybar --add item cpu.percent right          \
           --set cpu.percent "${cpu_percent[@]}"
