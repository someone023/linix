{...}: {
  imports = [
    ./starship.nix
    ./zsh.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "";
    NIXPKGS_ALLOW_UNFREE = 1;

    # auto-run programs using nix-index-database
    NIX_AUTO_RUN = "1";
  };
}
