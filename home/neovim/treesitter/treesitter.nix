{config, ...}: {
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      indent = true;
      nixvimInjections = true;
      nixGrammars = true;
      ensureInstalled = [
        "c"
        "lua"
        "nix"
        "python"
        "vim"
        "help"
        "query"
        "rust"
      ];
      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        lua
        luadoc
        luap
        c
        rust
        cmake
        nix
        python
        vim
        vimdoc
        yaml
        toml
        make
        regex
        bash
        markdown
        markdown_inline
      ];
    };
  };
}
