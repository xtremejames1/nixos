{ pkgs, ... }:
{

   home.packages = with pkgs; [
      lazygit
   ];

   programs.git = {
       enable = true;
       userName  = "James Xiao";
       userEmail = "xtremejames1@gmail.com";
   };
   programs.gh = {
      enable = true;
   };
}
