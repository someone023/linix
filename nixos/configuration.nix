# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    ../modules/nixos/core-desktop.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-ocl
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
      ];
    };

    enableRedistributableFirmware = lib.mkDefault true;
    brillo.enable = true;
  };

  services = {
    thermald = {
      enable = lib.mkDefault true;
    };
    fwupd = {
      enable = lib.mkDefault true;
    };

    power-profiles-daemon.enable = true;

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    # battery info & stuff
    upower.enable = true;

  };

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
      nixpkgs.config.allowUnfree = lib.mkForce true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    # Register each flake input
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    # Specify a custom Nix path
    nixPath = [ "/etc/nix/path" ];

    # Set Nix daemon settings
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  #This will add each flake input as a registry
  #To make nix3 commands consistent with your flake
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

  networking.hostName = "linix";

  console.keyMap = "us";

  documentation.dev.enable = true;

  programs = {
    less.enable = true;

    git =
      {
        enable = true;
        config = {
          user.name = "Ali Erkol";
          user.email = "a.erkol@tu-braunschweig.com";
       };
      };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        patterns = { " rm - rf * " = " fg=black,bg=red"; };
        styles = { "alias" = "fg=magenta"; };
        highlighters = [ "main" "brackets" "pattern" ];
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    psmisc # killall/pstree/prtstat/fuser/...
    lm_sensors
    ethtool
    btop
    wget
    curl
  ];


  users.users = {
    wasd = {
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhqO14oVhYp3iAYnKH1h43czDOxy6C/zU0FRvTQ2MP9 ali"
      ];
      extraGroups = [ "input" "libvirtd" "networkmanager" "plugdev" "transmission" "video" "wheel" ];
    };
  };

  networking.networkmanager.enable = true;
  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  nix.settings = {
    trusted-users = [ "wasd" ];

    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  system.stateVersion = "24.05"; # Did you read the comment?

}
