# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./shell
    ./wayland
    ./programs
    ./development
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.anyrun.homeManagerModules.default
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  news.display = "silent";

  nixpkgs = {

    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {

      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "wasd";
    homeDirectory = "/home/wasd";
  };


  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [


    xfce.thunar
    xfce.thunar-archive-plugin
    firefox

    # misc
    mako
    colord
    ffmpegthumbnailer
    imagemagick
    xdotool
    rizin
    xcolor
    ffmpeg
    nixpkgs-fmt
  ];

  programs = {
    home-manager.enable = true;

  };


    manual = {
      manpages.enable = false;
      html.enable = false;
      json.enable = false;
    };



  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
  };


  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        #tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "JetBrainsMono";
      size = 11;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
