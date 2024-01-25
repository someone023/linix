{lib, ...}: {
  security.polkit.enable = true;
  systemd.enableUnifiedCgroupHierarchy = lib.mkForce true;

  fileSystems."/home/wasd/.cache/mozilla/firefox" = {
    device = "tmpfs";
    fsType = "tmpfs";
    noCheck = true;
    options = [
      "noatime"
      "nodev"
      "nosuid"
      "size=128M"
    ];
  };
}
