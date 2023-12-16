{ pkgs
, pkgs-unstable
, ...
}: {

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

    rust-analyzer
    cargo # rust package manager
    rustfmt


    go

    stylua
    lua-language-server

    # db related

    # misc
    tree-sitter
    fzf
    telescope

    glow # markdown previewer
  ] ++ (if pkgs.stdenv.isLinux then [
    # Automatically trims your branches whose tracking remote refs are merged or gone
    # It's really useful when you work on a project for a long time.
    git-trim



    #mitmproxy # http/https proxy tool
    #insomnia # REST client
    #wireshark # network analyzer
  ] else [ ]);

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
}
