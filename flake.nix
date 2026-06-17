{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    musnix.url = "github:musnix/musnix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs: {
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
    };
  };
}
