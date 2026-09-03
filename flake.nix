{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    musnix.url = "github:musnix/musnix";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {
    nixosConfigurations = {
      vostro = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/vostro/configuration.nix
          inputs.nix-flatpak.nixosModules.nix-flatpak

          inputs.home-manager.nixosModules.default {
	        home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.user = ./hosts/vostro/home.nix;
	  }
        ];
      };
      g15 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  inherit (final) config;
                  inherit (final.stdenv.hostPlatform) system;
                };
              })
            ];
          }
          ./hosts/g15/configuration.nix
	  inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.musnix.nixosModules.musnix

	  inputs.home-manager.nixosModules.default {
	    home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.davy = ./hosts/g15/home.nix;
	  }
       ];
      };
      t480 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  inherit (final) config;
                  inherit (final.stdenv.hostPlatform) system;
                };
              })
            ];
          }
          ./hosts/t480/configuration.nix
          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.musnix.nixosModules.musnix

          inputs.home-manager.nixosModules.default {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.davi = ./hosts/t480/home.nix;
	  }
        ];
      };
    };
  };
}
