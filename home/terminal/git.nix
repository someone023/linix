{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    act # local github actions
    zsh-forgit # zsh plugin to load forgit via `git forgit`
    gitflow
    lazygit
  ];
  programs = {
    gh = {
      enable = true;
      gitCredentialHelper.enable = false;
      extensions = with pkgs; [
        gh-dash # dashboard with pull requests and issues
        gh-eco # explore the ecosystem
        gh-cal # contributions calender terminal viewer
      ];
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

    git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userEmail = "a.erkol@tu-braunschweig.de";
      userName = "someone023";

      extraConfig = {
        delta = {
          enable = true;
          options.dark = true;
          line-numbers = true;
          options.navigate = true;
          features = "decorations side-by-side navigate";
        };

        init.defaultBranch = "main";
        diff.colorMoved = "default";
        merge.conflictstyle = "diff3";

        push = {
          default = "current";
          followTags = true;
        };

        core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        color.ui = "auto";

        rebase = {
          autoSquash = true;
          autoStash = true;
        };

        rerere = {
          autoupdate = true;
          enabled = true;
        };
      };

      lfs.enable = true;

      ignores = [
        ".cache/"
        ".ccls-cache/"
        ".idea/"
        "*.swp"
        "*.elc"
        ".~lock*"
        "auto-save-list"
        ".direnv/"
        "node_modules"
        "result"
        "result-*"
      ];

      #signing = {
      #key = "CE16E2CA94DC8D6A";
      #signByDefault = true;
      # };

      extraConfig.gpg.format = "ssh";
    };
  };
}
