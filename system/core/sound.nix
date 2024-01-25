{
  sound.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    audio.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse.wantedBy = ["default.target"];
  };
}
