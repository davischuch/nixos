{ pkgs, config, lib, ... }:

{
  imports = [
    # dotfiles
    ../.././modules/dotfiles/nvim.nix
    ../.././modules/dotfiles/foot.nix
    ../.././modules/dotfiles/tmux.nix

    # direnv flakes
    #../.././modules/direnv/embeded.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "davi";
  home.homeDirectory = "/home/davi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # basics
    keepassxc
    xfce.thunar
    thunderbird
    kdePackages.kleopatra
    libreoffice
    obsidian
    firefox

    # terminal
    fastfetch
    tmux
    
    # extensions
    gnomeExtensions.caffeine
    gnome-tweaks

    # dev kinda
    wireshark
    tor-browser
    distrobox

    # games
    steam

    # music prod
    ardour
    calf
    x42-plugins
    helm

    # misc
    unetbootin
    copyq
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
 
  programs.git = {
    enable = true;
    settings = {
      user.name = "davischuch";
      user.email = "davischuch@proton.me";
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''PS1="\n\e[0;32m\e[m\u@\h [\e[0;32m\w\e[m \$]\e[0;32m─╼\e[m "'';
  };

  programs.foot = {
    settings = {
      main = {
        term = "xterm-256color";
        font = "monospace:size=24";
        pad = "15x5";
      };
    };
  };

  programs.librewolf = {
    enable = false;
    settings = {
      # vertical tabs config
      "sidebar.verticalTabs" = true;
      "sidebar.revamp" = true;
      "sidebar.main.tools" = " ";
      "sidebar.new-sidebar.has-used" = true;
      "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;

      # toolbar
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.uiCustomization.navBarWhenVerticalTabs" = ''["sidebar-button","vertical-spacer","customizableui-special-spring1","customizableui-special-spring8","back-button","forward-button","stop-reload-button","urlbar-container","customizableui-special-spring9","customizableui-special-spring6","customizableui-special-spring2","fxa-toolbar-menu-button","reset-pbm-toolbar-button","unified-extensions-button","ublock0_raymondhill_net-browser-action"]'';
      "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":["downloads-button"],"unified-extensions-area":["addon_darkreader_org-browser-action"],"nav-bar":["sidebar-button","vertical-spacer","customizableui-special-spring1","customizableui-special-spring8","back-button","forward-button","stop-reload-button","urlbar-container","customizableui-special-spring9","customizableui-special-spring6","customizableui-special-spring2","fxa-toolbar-menu-button","reset-pbm-toolbar-button","unified-extensions-button","ublock0_raymondhill_net-browser-action","keepassxc-browser_keepassxc_org-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["reset-pbm-toolbar-button","developer-button","screenshot-button","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","keepassxc-browser_keepassxc_org-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","toolbar-menubar","TabsToolbar","PersonalToolbar","widget-overflow-fixed-list","unified-extensions-area"],"currentVersion":24,"newElementCount":9}'';
    };
    policies = {
      ExtensionSettings = {
        "uBLock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/addon@darkreader.org/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser@keepassxc.org/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = false;
          default_area = "menupanel";
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = { # vimium
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{d7742d87-e61d-4b78-b8a1-b469842139fa}/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };
      };
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
