{
  imports = [
    ./keyd.nix
    ./location.nix
    ./gnome-services.nix
    ./power.nix
  ];

  services.   xserver = {
    layout = "de";
    xkbVariant = "us";
  };
}
