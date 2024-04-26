{
  description = "Nixos config flake";

  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";


    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    unstable = nixpkgs-unstable.legacyPackages.${system};
  in
  {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/default/configuration.nix
          ./users/xtremejames1.nix
          ./variables.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      xtremecomputer1 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit unstable;
        };
        modules = [
          ./hosts/xtremecomputer1/configuration.nix
          ./users/xtremejames1.nix
          ./variables.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
