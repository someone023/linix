{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      alejandra
      nix-init
      nix-tree
      nix-update
      nix-output-monitor
      nixpkgs-review
      statix
      nil
      rnix-lsp
      vimPluginsUpdater
    ];
  };
}
