{pkgs, ...}: {
  services = {
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];

    gnome = {
      gnome-keyring.enable = true;
      glib-networking.enable = true;
    };

    gvfs.enable = true;
  };

  security.pam.services = {
    login = {
      enableGnomeKeyring = true;
      gnupg = {
        enable = true;
        noAutostart = true;
        storeOnly = true;
      };
    };
  };

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;
    seahorse.enable = true;
  };
}
