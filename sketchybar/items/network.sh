#!/bin/bash

network=(
  icon.drawing=off
  label="↓ --  ↑ --"
  label.font="$FONT:Semibold:12"
  update_freq=2
  script="$PLUGIN_DIR/network.sh"
)

sketchybar --add item network right \
           --set network "${network[@]}"
