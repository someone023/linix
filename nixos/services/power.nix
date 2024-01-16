{lib, ...}: {
  services = {
    thermald = {
      enable = lib.mkDefault true;
    };
    power-profiles-daemon.enable = true;

    # battery info
    upower.enable = true;
  };
}
