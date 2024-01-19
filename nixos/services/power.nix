{lib, ...}: {
  services = {
    thermald = {
      enable = lib.mkDefault true;
    };

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

    power-profiles-daemon.enable = false;

    acpid.enable = true;

    # battery info
    upower.enable = true;
  };
}
