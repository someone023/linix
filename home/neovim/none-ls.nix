{
  programs.nixvim = {
    plugins.none-ls = {
      enable = false;

      enableLspFormat = true;
      updateInInsert = false;
      sources = {
        code_actions = {
          #gitsigns.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          statix = {
            enable = true;
          };
          luacheck = {
            enable = true;
          };
          flake8 = {
            enable = true;
          };
        };
        formatting = {
          alejandra = {
            enable = true;
          };
          rustfmt = {
            enable = true;
          };
          stylua = {
            enable = true;
          };
          black = {
            enable = true;
            withArgs = ''
              {
                extra_args = { "--fast" },
              }
            '';
          };
          jq = {
            enable = true;
          };
        };
      };
    };

    keymaps = [
      {
        mode = ["n" "v"];
        key = "<leader>cf";
        action = "<cmd>lua vim.lsp.buf.format()<cr>";
        options = {
          silent = true;
          desc = "Format";
        };
      }
    ];
  };
}
