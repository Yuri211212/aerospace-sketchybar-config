#!/bin/bash

# A real VPN tunnel (utun with inet address); system utun0-3 only have inet6
VPN_INTERFACE=$(ifconfig 2>/dev/null | awk '/^utun/{iface=$1} iface && /inet [0-9]/{print iface; exit}')

# Also check macOS built-in VPN connections
SCUTIL_VPN=$(scutil --nc list 2>/dev/null | grep "Connected" | head -1)

if [ -n "$VPN_INTERFACE" ] || [ -n "$SCUTIL_VPN" ]; then
  # Try to get VPN name from scutil
  VPN_NAME=$(scutil --nc list 2>/dev/null | grep "Connected" | sed 's/.*"\(.*\)".*/\1/' | head -1)
  [ -z "$VPN_NAME" ] && VPN_NAME="VPN"

  sketchybar --set vpn \
    icon="󰒃" \
    icon.color=0xff89b4fa \
    label="$VPN_NAME" \
    label.color=0xff89b4fa
else
  sketchybar --set vpn \
    icon="󰒄" \
    icon.color=0xff6c7086 \
    label="Off" \
    label.color=0xff6c7086
fi
