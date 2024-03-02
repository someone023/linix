{
  config,
  lib,
  pkgs,
  ...
}: {
  # greetd display manager

  services = {
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "wasd";
        };
        default_session = initial_session;
      };
    };
  };
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  #security.pam.services.greetd.enableGnomeKeyring = true;
}
