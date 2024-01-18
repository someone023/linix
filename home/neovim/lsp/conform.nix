{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      formatOnSave = {
        lspFallback = true;
        timeoutMs = 1000;
      };
      notifyOnError = true;
      formattersByFt = {
        lua = ["stylua"];
        python = ["black"];
        nix = ["alejandra"];
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
