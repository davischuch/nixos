{ pkgs, config, ... }:

{
    home.file."projects/embeded/flake.nix".source = config.lib.file.mkOutOfStoreSymlink "/home/user/nixos/modules/home/direnv/embeded/flake.nix";
    home.file."projects/embeded/flake.lock".source = config.lib.file.mkOutOfStoreSymlink "/home/user/nixos/modules/home/direnv/embeded/flake.lock";
    home.file."projects/embeded/.envrc".source = config.lib.file.mkOutOfStoreSymlink "/home/user/nixos/modules/home/direnv/embeded/.envrc";
}
