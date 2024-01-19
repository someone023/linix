{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      formatOnSave = {
        lspFallback = true;
        timeoutMs = 500;
      };

      notifyOnError = true;
      formattersByFt = {
        lua = ["stylua"];
        nix = ["alejandra"];
        rust = ["rustfmt"];
      };
    };

    # keymaps = [
    # {
    #   mode = ["n" "v"];
    #   key = "<leader>cf";
    #   action = "<cmd>lua require('conform').format()<cr>";
    #   options = {
    #     silent = true;
    #     desc = "Format";
    #   };
    # }
    # ];
  };
}
