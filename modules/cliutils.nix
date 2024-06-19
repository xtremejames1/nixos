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
        cargo
        dust
        duf
        bottom
        gping
  ];
}
