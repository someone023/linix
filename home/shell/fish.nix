{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    fishPlugins.async-prompt
    fishPlugins.fzf-fish
    fishPlugins.pure
    #starship
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
    starship init fish | source
      set fish_greeting # Disable greeting
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      # Manually packaging and enable a plugin

  ];
  shellAliases = {
    c = "clear";
    ls = "eza";
    la = "eza -a";
    ll = "eza --color=auto -la";
  };

};


}