{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
  ];

  programs = {
    ssh.startAgent = true;

    # make HM-managed GTK stuff work
    dconf.enable = true;

    kdeconnect.enable = true;

    seahorse.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  xdg.portal = {
    enable = true;

    config = {
      common = {
        # Use xdg-desktop-portal-gtk for every portal interface...
        default = [
          "gtk"
        ];
        # except for the secret portal, which is handled by gnome-keyring
        "org.freedesktop.impl.portal.Secret" = [
          "gnome-keyring"
        ];
      };
    };

    # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1
    # This will make xdg-open use the portal to open programs,
    # which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers.
    # xdg-open is used by almost all programs to open a unknown file/uri
    # alacritty as an example, it use xdg-open as default, but you can also custom this behavior
    # and vscode has open like `External Uri Openers`
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk # for gtk
    ];
  };

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # normal fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      (google-fonts.override {fonts = ["Inter"];})

      # nerdfonts
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Inter" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
