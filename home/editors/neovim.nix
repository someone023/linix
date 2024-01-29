{pkgs, ...}: {
  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    #plugins = with pkgs.vimPlugins; [
    #];

    extraPackages = with pkgs; [neovide ripgrep fd nixd stylua lua-language-server alejandra gnumake];

  };
}
