{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    deadnix
    statix

    # grep replacement
    ripgrep

    fzf
    bash
    telescope

    # profiling tool
    hyperfine

    # ping, but with cool graph
    gping

    # faster find
    fd

    ffmpeg-full

    # syncthnig for acoustic people
    rsync

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoringecho nvim_get_runtime_file('parser', v:true

    lsof # list open files

    psmisc # killall/pstree/prtstat/fuser/...
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    eza = {
      enable = true;
      icons = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
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

    # man pages for tiktok attention span mfs
    tealdeer = {
      enable = false;
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
  };
}
