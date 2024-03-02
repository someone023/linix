{pkgs, ...}: {
  imports = [
    ./keyd.nix
    ./location.nix
    ./power.nix
    ./resolved.nix
    ./openssh.nix
    ./seatd.nix
  ];

  services = {
    dbus = {
      enable = true;
      implementation = "broker";
    };

    fwupd = {
      enable = true;
    };
    psd = {
      enable = true;
      resyncTimer = "60m";
    };
  };
  console = {
    keyMap = "us";
  };
}
