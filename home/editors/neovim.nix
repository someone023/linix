{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    programs.neovim.extraConfig = lib.fileContents ~/.config/nvim/init.vim;

  };
}
