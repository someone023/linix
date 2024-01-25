{
  pkgs,
  config,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        size = "standard";
        accents = ["blue"];
        variant = "mocha";
        tweaks = ["normal"];
      };
    };

    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine";
    };

    font = {
      name = "JetBrainsMono";
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "Catppuccin-Mocha-Dark-Cursors";
      size = 24;
    };

    packages = with pkgs; [
      qt5.qttools
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      breeze-icons
    ];
    sessionVariables = {
      XCURSOR_SIZE = "24";
      GTK_USE_PORTAL = "1";
    };
  };
  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "Catppuccin-Mocha-Dark";
      package = pkgs.catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["blue"];
        winDecStyles = ["modern"];
      };
    };
  };
}
