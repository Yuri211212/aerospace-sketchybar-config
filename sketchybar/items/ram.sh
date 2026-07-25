#!/bin/bash

ram=(
  icon="󰍛"
  icon.font="$FONT:Regular:14.0"
  label="RAM"
  update_freq=5
  script="$PLUGIN_DIR/ram.sh"
)

sketchybar --add item ram right \
           --set ram "${ram[@]}"
