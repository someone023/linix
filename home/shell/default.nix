{config, ...}: {
  imports = [
    ./cli.nix
    ./fish.nix
  ];

  # add environment variables
  home.sessionVariables = {

    # enable scrolling in git diff
    DELTA_PAGER = "less -R";

    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    DIRENV_LOG_FORMAT = "";

    # auto-run programs using nix-index-database
    NIX_AUTO_RUN = "1";
  };
}
