{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    delta = {
      enable = true;
      options.dark = true;
      options.features = "decorations";
    };

    extraConfig = {
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
    };

    ignores = ["*~" "*.swp" "*result*" ".direnv" "node_modules"];

    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519";
      signByDefault = true;
    };

    extraConfig.gpg.format = "ssh";

    userEmail = "a.erkol@tu-braunschweig.de";
    userName = "Ali Erkol";
  };
}
