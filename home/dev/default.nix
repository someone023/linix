{pkgs, ...}: {
  imports = [./python.nix ./nix.nix];

  home.packages = with pkgs; [
    #-- c/c++
    cmake
    cmake-language-server
    gnumake
    checkmake
    gcc # c/c++ compiler, required by nvim-treesitter!
    llvmPackages.clang-unwrapped # c/c++ tools with clang-tools such as clangd
    gdb
    lldb

    stylua
    lua-language-server
    # misc
    tree-sitter
    telescope
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
}
