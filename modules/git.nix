{ pkgs, ... }:
{

   home.packages = with pkgs; [
      lazygit
         gh
   ];

   programs.git = {
       enable = true;
       userName  = "James Xiao";
       userEmail = "xtremejames1@gmail.com";
   };
}
