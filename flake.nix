{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    #stm32cubeide.url = "path:./modules/nixos/stm32cubeide";
    #platformio.url = "path:./modules/nixos/platformio";

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
	  inputs.home-manager.nixosModules.default
	  #inputs.stm32cubeide.nixosModules.default
	  #inputs.platformio.nixosModules.default

	  #({ ... }: {
          #  programs.stm32cubeide = {
          #    enable = true;
	  #  };
          #})
	];
      };
    };
  };
}
