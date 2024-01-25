{pkgs, ...}: {
  imports = [
    ./greetd.nix
    ./keyd.nix
    ./location.nix
    ./gnome-services.nix
    ./power.nix
    ./resolved.nix
    ./openssh.nix
    ./seatd.nix
  ];

  services = {
    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [
        dconf
        gcr
        udisks2
        gnome.gnome-settings-daemon
      ];
    };

    udisks2.enable = true;

    fwupd = {
      enable = true;
    };
    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    xserver = {
      layout = "de";
      xkbVariant = "us";
    };
  };
  console = {
    keyMap = "us";
  };
}
