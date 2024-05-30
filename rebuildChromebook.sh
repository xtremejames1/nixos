#!/usr/bin/env bash

sudo nixos-rebuild switch --flake '/home/xtremejames1/nixos#chromebook' --show-trace --impure --upgrade
