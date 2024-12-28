{
  description = "Nixos config flake";

  inputs = 
  {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";


    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";

    iio-hyprland.url = "github:JeanSchoeller/iio-hyprland";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };
 };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, neorg-overlay, ... }@inputs:
  {
    nixosConfigurations = {
      xtremecomputer1 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/xtremecomputer1/configuration.nix
          ./users/xtremejames1.nix
          ./variables.nix
        ];
      };

      jxchromenix = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/chromebook/configuration.nix
          ./users/xtremejames1.nix
          ./variables.nix
        ];
      };
      xtremelaptop3 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
            # home-manager.nixosModules.home-manager {
            #   nixpkgs.overlays = [neorg-overlay.overlays.default];
            # }
          ./hosts/xtremelaptop3/configuration.nix
          ./hosts/xtremelaptop3/hardware-configuration.nix
          ./users/xtremejames1.nix
          ./variables.nix
        ];
      };
    };
    homeConfigurations = {
      "xtremejames1" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance

        extraSpecialArgs = {inherit inputs;};

        modules = [./hosts/xtremelaptop2/home.nix];
      };
    };
  };
}
