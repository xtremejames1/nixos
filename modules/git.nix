{pkgs, ...}: {
  home.packages = with pkgs; [
    lazygit
  ];

  programs.git = {
    enable = true;
    settings.user.name = "James Xiao";
    settings.user.email = "xtremejames1@gmail.com";
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
