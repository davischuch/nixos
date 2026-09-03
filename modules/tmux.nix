{ config, pkgs, ... }:

{
  home.file.".config/tmux/".source = config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/nixos/modules/dotfiles/tmux/";
}
