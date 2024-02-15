{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./gui
    ./services
    ./terminal
    ./editors
  ];

  home = {
    username = "wasd";
    homeDirectory = "/home/wasd";
    #extraOutputsToInstall = ["doc" "devdoc"];
  };

  programs = {
    home-manager.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Nicely reload system units when changing configs
  #systemd.user.startServices = "sd-switch";

  news.display = "silent";

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  home.stateVersion = "24.05";
}
