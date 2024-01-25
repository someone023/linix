{
  pkgs,
  lib,
  ...
}: {
  hardware.bluetooth = {
    enable = false;
    powerOnBoot = false;
  };

  boot.blacklistedKernelModules = ["bluetooth" "btusb"];
}
