{
  osConfig,
  config,
  lib,
  ...
}: {
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSshSupport = true;
      extraConfig = "allow-preset-passphrase";
      enableZshIntegration = true;
    };
  };

  # Allow manually restarting gpg-agent in case of failure
  systemd.user.services.gpg-agent.Unit.RefuseManualStart = lib.mkForce false;

  programs = {
    gpg = {
      enable = true;
    };
  };
}
