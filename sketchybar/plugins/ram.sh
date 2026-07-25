#!/bin/bash

STATS=$(vm_stat)
PAGE_SIZE=$(pagesize)

PAGES_FREE=$(echo "$STATS" | awk '/Pages free/ {gsub(/\./, "", $3); print $3}')
PAGES_INACTIVE=$(echo "$STATS" | awk '/Pages inactive/ {gsub(/\./, "", $3); print $3}')
PAGES_SPECULATIVE=$(echo "$STATS" | awk '/Pages speculative/ {gsub(/\./, "", $3); print $3}')
PAGES_TOTAL=$(sysctl -n hw.memsize | awk -v ps="$PAGE_SIZE" '{printf "%d", $1/ps}')

PAGES_AVAIL=$((PAGES_FREE + PAGES_INACTIVE + PAGES_SPECULATIVE))
PAGES_USED=$((PAGES_TOTAL - PAGES_AVAIL))

PERCENT=$((PAGES_USED * 100 / PAGES_TOTAL))

sketchybar --set ram label="${PERCENT}%"
