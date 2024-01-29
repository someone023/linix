{...}: {
  imports = [
    ./starship
    ./zsh.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "";
    NIXPKGS_ALLOW_UNFREE = 1;
  };
}
