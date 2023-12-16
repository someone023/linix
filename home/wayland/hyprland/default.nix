{ inputs
, lib
, pkgs
, ...
}: {
  imports = [
    #./binds.nix
    #./rules.nix
    #./config.nix
  ];

  home.packages = [
    # inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  # start swayidle as part of hyprland, not sway
  # systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];

  # enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;
  };
  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hypr.conf;

}
