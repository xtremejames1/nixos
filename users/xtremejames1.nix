{ lib, configs, pkgs, ... }:

{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xtremejames1 = {
    isNormalUser = true;
    description = "James Xiao";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      neovim
      firefox
    ];
  };

}
