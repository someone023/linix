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
    streamlink
    libcaca

  ];

  programs = {
    mpv = {
      enable = true;
      #defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];
      config = {
        vo = "sdl";
        hwdec = "auto";
        video-sync = "display-desync";
        scale = "bilinear";
        vf = "scale=480:-1";
        framedrop = "vo";
      };
    };
  };


  services = {
    playerctld.enable = true;
  };
}
