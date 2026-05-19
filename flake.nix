{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs: {
<<<<<<< HEAD
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
=======
>>>>>>> c9c6230 (feat: add home manager to configuration file and add hosts folder)
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
	inputs.nix-flatpak.nixosModules.nix-flatpak
	inputs.home-manager.nixosModules.default
      ];
    };
  };
}
