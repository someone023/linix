{
  pkgs,
  config,
  ...
}: let
  browser = ["firefox.desktop"];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv.desktop"];
    "application/json" = browser;

    "text/plain" = ["Helix"];
    "inode/directory" = ["yazi"];
  };
in {
  xdg = {
    enable = true;
    portal.xdgOpenUsePortal = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/other";
      download = "${config.home.homeDirectory}/download";
      videos = "${config.home.homeDirectory}/other";
      music = "${config.home.homeDirectory}/other";
      pictures = "${config.home.homeDirectory}/pics";
      desktop = "${config.home.homeDirectory}/other";
      publicShare = "${config.home.homeDirectory}/other";
      templates = "${config.home.homeDirectory}/other";
    };
    mimeApps.enable = true;
    mimeApps.associations.added = associations;
    mimeApps.defaultApplications = associations;
  };
}
