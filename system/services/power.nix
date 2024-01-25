{
  lib,
  config,
  ...
}: {
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
    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "Hibernate";
    };
  };
  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
      cpupower
    ];
  };
}
