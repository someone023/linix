{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
    # images
    imv
    libcaca
    pavucontrol
  ];

  programs = {
    mpv = {
      enable = true;
      #defaultProfiles = [ "gpu-hq" ];
      scripts = [pkgs.mpvScripts.mpris];
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
}
