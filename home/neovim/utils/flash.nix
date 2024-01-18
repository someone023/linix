{
  programs.nixvim = {
    plugins.flash = {
      enable = true;
      search = {
        mode = "fuzzy";
      };
      jump = {
        autojump = true;
      };
      label = {
        uppercase = false;
        rainbow = {
          enabled = false;
          shade = 5;
        };
      };
    };
    keymaps = [
      {
        mode = ["n" "x" "o"];
        key = "r";
        action = "<cmd>lua require('flash').jump()<cr>";
        options = {
          desc = "Flash";
        };
      }
      {
        mode = ["x" "o"];
        key = "R";
        action = "<cmd>lua require('flash').treesitter_search()<cr>";
        options = {
          desc = "Treesitter Search";
        };
      }
    ];
  };
}
