{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      LazyVim
    ];

    extraPackages = with pkgs; [ gcc ripgrep fd ];

  };
}
