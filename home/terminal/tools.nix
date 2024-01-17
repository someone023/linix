{pkgs, ...}: {
  home.packages = with pkgs; [
    # grep replacement
    ripgrep

    # dns client
    dogdns

    # neofetch but for git repos
    onefetch

    # man pages for tiktok attention span mfs
    tealdeer

    # faster find
    fd

    # syncthnig for acoustic people
    rsync
  ];

  programs = {
    man.enable = true;
    eza.enable = true;
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'eza --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = true;
        };
      };
    };
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "catppuccin-mocha";
      };
      themes = {
        catppuccin-mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
          file = "Catppuccin-mocha.tmTheme";
        };
      };
    };
  };
}
