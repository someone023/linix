{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./gui
    ./dev
    ./services
    ./terminal
    # outputs.homeManagerModules.example
    inputs.nix-index-db.hmModules.nix-index

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
  ];

  home = {
    username = "wasd";
    homeDirectory = "/home/wasd";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  programs = {
    home-manager.enable = true;

    nix-index-database.comma.enable = true;
  };

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  news.display = "silent";

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  home.stateVersion = "24.05";
}
