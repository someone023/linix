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
      deadnix
      nil
      rnix-lsp
      vimPluginsUpdater
    ];
  };
}
