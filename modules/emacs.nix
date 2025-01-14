{ pkgs, ... }:
let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-medium dvisvgm latexmk pgf nicematrix;
  };
in
{
  home.packages = with pkgs; [
    graphviz
    sqlite
    tex
  ];
  programs.doom-emacs = {
    enable = true;
    doomDir = /home/xtremejames1/doomdir;
  };
}
