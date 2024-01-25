{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = (import ./config.nix).config;
  };
}
