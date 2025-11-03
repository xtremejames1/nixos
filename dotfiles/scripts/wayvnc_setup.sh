#!/usr/bin/env bash

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
