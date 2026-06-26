{ config, pkgs, ... }:

{
  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/nixos/modules/home/dotfiles/nvim/";
}
