#!/usr/bin/env bash

tmux kill-session -t wayvnc 2>/dev/null
swaymsg output "$1" unplug 2>/dev/null
