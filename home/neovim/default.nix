{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./ui
    ./utils
    ./lsp
    ./treesitter
    ./core.nix
    ./keymaps.nix
    ./hardtime.nix

    ./bufferline.nix

    ./colorscheme.nix

    ./neo-tree.nix

    ./cmp.nix

    ./none-ls.nix

    ./lualine.nix

    ./telescope.nix
  ];
  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      vim-startuptime
      dressing-nvim
      nui-nvim
      plenary-nvim
    ];
    # Highlight and remove extra white spaces
    highlight.ExtraWhitespace.bg = "red";
    match.ExtraWhitespace = "\\s\\+$";
  };
}
