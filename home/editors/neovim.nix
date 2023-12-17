{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      LazyVim
      neoconf-nvim
    ];

    extraPackages = with pkgs; [ lazygit ];

  };
}
