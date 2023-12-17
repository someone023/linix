{ config
, lib
, pkgs
, pkgs-unstable
, ...
}: {
  imports = [
  ];

  environment.variables.NIXOS_OZONE_WL = "1";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };



  # https://github.com/rvaiya/keyd
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        settings = {
          main = {
            # overloads the capslock key to function as both escape (when tapped) and control (when held)
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

  security.polkit.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  services = {
    xserver =
      {
        layout = "de";
        xkbVariant = "us";
      };

    clight = {
      enable = true;
      settings = {
        verbose = true;
        backlight.disabled = true;
        dpms.timeouts = [ 900 300 ];
        dimmer.timeouts = [ 870 270 ];
        gamma.long_transition = true;
        screen.disabled = true;
      };
    };

    gvfs.enable = true;


    gnome.gnome-keyring.enable = true;



    dbus.packages = [ pkgs.gcr ];
    geoclue2.enable = true;

    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];
  };

  location.provider = "geoclue2";

  programs = {

    ssh.startAgent = true;

    # make HM-managed GTK stuff work
    dconf.enable = true;

    kdeconnect.enable = true;

    seahorse.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
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
      (google-fonts.override { fonts = [ "Inter" ]; })

      # nerdfonts
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Inter" "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
