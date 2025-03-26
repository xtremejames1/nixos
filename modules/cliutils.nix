{ pkgs, ...}:
{
  home.packages = with pkgs; [
        eza
        zoxide
        ripgrep
        atuin
        bat
        fzf
        fd
        broot
        tldr
        unzip
        delta
        dust
        duf
        bottom
        gping
        yazi
        ianny
  ];
}
