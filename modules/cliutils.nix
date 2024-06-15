{ inputs, pkgs, config, ...}:
{
  home.packages = with pkgs; [
        eza
        zoxide
        ripgrep
        atuin
        lazygit
        gh
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
