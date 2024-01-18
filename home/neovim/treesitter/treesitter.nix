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
      ];
      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        lua
        luadoc
        luap
        c
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
