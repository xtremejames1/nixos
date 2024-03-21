{ pkgs }:

pkgs.writeShellScriptBin "rebuildscript" ''
  sudo nixos-rebuild switch --flake /home/xtremejames1/nixos#default
''
