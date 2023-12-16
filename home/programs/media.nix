{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer

    # images
    imv
    loupe

    # videos
    celluloid

  ];

  programs = {
    mpv = {
      enable = true;
    };
  };

}
