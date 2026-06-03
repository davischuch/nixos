{ config, pkgs, ... }:

{
  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "/home/user/nixos/modules/home/dotfiles/nvim/";
}
