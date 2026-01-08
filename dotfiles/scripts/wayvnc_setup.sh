#!/usr/bin/env bash

# Source credentials
cd ~/nixos/dotfiles/scripts
source ./credentials

swaymsg create_output HEADLESS-1
echo "Created output"
sleep 1
output=$(swaymsg -t get_outputs | rg "(HEADLESS-.+)\"" -or '$1')

echo "Output: $output"
swaymsg output "$output" mode 2200x1440
echo "Set resolution"
tmux new-session -d -s "wayvnc"
tmux send-keys -t wayvnc "wayvnc 0.0.0.0 --output=\"$output\" &" Enter
echo "Initialized WayVNC"

sleep 2

INTERFACE="wlp2s0"
IP=$(ip -4 addr show $INTERFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

if [ -z "$IP" ]; then
    echo "No IP found on $INTERFACE"
    exit 1
fi

curl -u "$PUSHBULLET_API_KEY": https://api.pushbullet.com/v2/pushes \
  -d type=note \
  -d title="VNC_IP" \
  -d body="$IP"

echo "Sent IP: $IP"
