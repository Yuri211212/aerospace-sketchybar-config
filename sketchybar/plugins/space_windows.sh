#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')

reload_workspace_icon() {
  local sid=$1
  local apps
  apps=$(aerospace list-windows --workspace "$sid" 2>/dev/null | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  if [ -n "${apps}" ]; then
    local icon_strip=" "
    while read -r app; do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
    sketchybar --animate sin 10 --set space.$sid label="$icon_strip" display=$MONITOR
  else
    sketchybar --set space.$sid display=0
  fi
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  # обновить предыдущий и текущий workspace
  reload_workspace_icon "$AEROSPACE_PREV_WORKSPACE"
  reload_workspace_icon "$AEROSPACE_FOCUSED_WORKSPACE"

  # подсветка текущего
  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE \
    icon.highlight=true \
    label.highlight=true \
    background.border_color=$GREY \
    display=$MONITOR

  # снять подсветку с предыдущего
  sketchybar --set space.$AEROSPACE_PREV_WORKSPACE \
    icon.highlight=false \
    label.highlight=false \
    background.border_color=$BACKGROUND_2
fi
