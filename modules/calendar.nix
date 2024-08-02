{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wyrd
    remind
  ];
}
