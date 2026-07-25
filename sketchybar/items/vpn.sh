#!/bin/bash

vpn=(
  icon="󰒄"
  icon.font="$FONT:Regular:16.0"
  icon.color=0xff6c7086
  label="Off"
  label.color=0xff6c7086
  update_freq=5
  script="$PLUGIN_DIR/vpn.sh"
)

sketchybar --add item vpn right \
           --set vpn "${vpn[@]}"
