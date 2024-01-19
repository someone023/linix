{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      nix = ["statix"];
      lua = ["selene"];
      rust = ["clippy"];
    };
  };
}
