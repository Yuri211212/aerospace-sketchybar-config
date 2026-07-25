#!/usr/bin/env bash

source "$(dirname "$0")/icon_map_fn.sh"
icon_map "$1"
echo "$icon_result"
