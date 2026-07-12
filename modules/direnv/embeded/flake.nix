{
  description = "A Nix-flake-based PlatformIO development environment";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # unstable Nixpkgs
    #nixpkgs-esp-dev.url = "github:mirrexagon/nixpkgs-esp-dev";
  };

  outputs =
    {
      self,
      nixpkgs,
      #nixpkgs-esp-dev,
      ...
    }@inputs:

    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
              #overlays = [ (import "${nixpkgs-esp-dev}/overlay.nix") ];
              #config.permittedInsecurePackages = [
              #  "python3.13-ecdsa-0.19.2"
              #];
            };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs, system }:
        {
          default = pkgs.mkShellNoCC {
            packages =
              with pkgs;
              [
                clang-tools
                cmake
                codespell
                conan
                cppcheck
                doxygen
                gtest
                lcov
                platformio
                vcpkg
                vcpkg-tool
                self.formatter.${system}
                stm32cubemx
                #arduino-ide
                #esp-idf-full
                vscodium-fhs
              ]
              ++ pkgs.lib.optionals (stdenv.hostPlatform.system != "aarch64-darwin") [ gdb ];

            shellHook = ''
              export PLATFORMIO_CORE_DIR=$PWD/.platformio
            '';
          };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);
    };
}
