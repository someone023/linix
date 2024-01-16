{pkgs, ...}: {
  imports = [
    ./qt.nix
    ./xdg.nix
    ./git.nix
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    psmisc # killall/pstree/prtstat/fuser/...
    lm_sensors
    ethtool
    btop
    wget
    curl
  ];

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;

    kdeconnect.enable = true;

    seahorse.enable = true;
  };
}
