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

      iio-hyprland.url = "github:JeanSchoeller/iio-hyprland";

      hyprland.url = "github:hyprwm/Hyprland";
      hyprgrass = {
        url = "github:horriblename/hyprgrass";
        inputs.hyprland.follows = "hyprland"; # IMPORTANT
      };

      # nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
      # # Optional, to download less. Neither the module nor the overlay uses this input.
      # nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "";
      nix-doom-emacs-unstraightened = {
        url = "github:marienz/nix-doom-emacs-unstraightened";
        inputs.nixpkgs.follows = "";
      };

      doom-config.url = "https://github.com/xtremejames1/doomconfig/tree/main";
      doom-config.flake = false;

      nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-wsl, home-manager, ... }@inputs:
    {
      nixosConfigurations = {
        xtremecomputer1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
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
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            nixos-wsl.nixosModules.default

            {
              system.stateVersion = "24.05";
              wsl.enable = true;
              wsl.defaultUser = "xtremejames1";
              wsl.wslConf.network.hostname = "xtremelaptop3";
            }
            ./hosts/xtremelaptop3/configuration.nix
            ./hosts/xtremelaptop3/hardware-configuration.nix
            ./users/xtremejames1.nix
            ./variables.nix
          ];
        };
        xtremelaptop3b = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/xtremelaptop3b/configuration.nix
            ./users/xtremejames1.nix
            ./variables.nix
          ];
        };
      };
      homeConfigurations = {
        "xtremejames1" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance

          extraSpecialArgs = {inherit inputs;};

          modules = [
            ./hosts/xtremelaptop2/home.nix];
        };
      };
    };
}
