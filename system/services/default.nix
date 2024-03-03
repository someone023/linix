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

    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

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
