{
  imports = [
    ./keyd.nix
    ./location.nix
    ./gnome-services.nix
    ./power.nix
  ];

  services = {
    dbus.implementation = "broker";

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
