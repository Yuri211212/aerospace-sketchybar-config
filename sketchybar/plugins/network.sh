#!/bin/bash

INTERFACE=$(route get default 2>/dev/null | grep interface | awk '{print $2}')
[ -z "$INTERFACE" ] && INTERFACE="en0"

CACHE_FILE="/tmp/sketchybar_network_$INTERFACE"
NOW=$(date +%s)

STATS=$(netstat -ibn | awk -v iface="$INTERFACE" '$1 == iface && /Link/ {print $7, $10; exit}')
IN=$(echo "$STATS" | awk '{print $1}')
OUT=$(echo "$STATS" | awk '{print $2}')

format_speed() {
  local b=$1
  if [ "$b" -lt 1024 ]; then
    printf "%dB" "$b"
  elif [ "$b" -lt 1048576 ]; then
    printf "%dK" "$((b / 1024))"
  else
    printf "%.1fM" "$(echo "scale=1; $b / 1048576" | bc)"
  fi
}

if [ -f "$CACHE_FILE" ]; then
  read -r PREV_TIME PREV_IN PREV_OUT < "$CACHE_FILE"
  DIFF=$(( NOW - PREV_TIME ))

  if [ "$DIFF" -gt 0 ]; then
    IN_SPEED=$(( (IN - PREV_IN) / DIFF ))
    OUT_SPEED=$(( (OUT - PREV_OUT) / DIFF ))
    [ "$IN_SPEED" -lt 0 ] && IN_SPEED=0
    [ "$OUT_SPEED" -lt 0 ] && OUT_SPEED=0

    sketchybar --set network \
      label="↓ $(format_speed $IN_SPEED)/s  ↑ $(format_speed $OUT_SPEED)/s"
  fi
fi

echo "$NOW $IN $OUT" > "$CACHE_FILE"
