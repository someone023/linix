{
  outputs,
  inputs,
  config,
  lib,
  ...
}: {
  nixpkgs = {
    # You can add overlays hereprograms.i18n
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
    config.nixpkgs.config.allowUnfree = lib.mkForce true;

    config.allowUnfree = lib.mkForce true;
  };

  nix = {
    # Register each flake input
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    # Specify a custom Nix path
    nixPath = ["/etc/nix/path"];

    # Set Nix daemon settings
    settings = {
      max-jobs = "auto";
      http-connections = 128;
      max-substitution-jobs = 128;
      builders-use-substitutes = true;

      keep-derivations = true;
      keep-outputs = true;

      log-lines = 25;

      # If set to true, Nix will fall back to building from source if a binary substitute
      # fails. This is equivalent to the –fallback flag. The default is false.
      fallback = true;

      warn-dirty = false;

      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";

      trusted-users = ["root" "wasd"];

      # Deduplicate and optimize nix store
      #auto-optimise-store = true;

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
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
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

  system.stateVersion = "24.05"; # Did you read the comment?
}
