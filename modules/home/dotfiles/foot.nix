{ config, pkgs, ... }:

{
  home.file.".config/foot/".source = config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/nixos/modules/home/dotfiles/foot/";
}
