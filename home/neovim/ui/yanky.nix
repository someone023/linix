{
  programs.nixvim = {
    plugins.yanky.enable = true;
    plugins.yanky.highlight.timer = 200;

    keymaps = [
      {
        mode = "n";
        key = "<leader>p";
        action = ":lua require('telescope').extensions.yank_history.yank_history({ })<CR>";
      }
      {
        mode = "n";
        key = "y";
        action = "<Plug>(YankyYank)";
      }
      {
        mode = "x";
        key = "y";
        action = "<Plug>(YankyYank)";
      }
      {
        mode = "n";
        key = "p";
        action = "<Plug>(YankyPutAfter)";
      }
      {
        mode = "x";
        key = "p";
        action = "<Plug>(YankyPutAfter)";
      }
      {
        mode = "n";
        key = "P";
        action = "<Plug>(YankyPutBefore)";
      }
      {
        mode = "x";
        key = "P";
        action = "<Plug>(YankyPutBefore)";
      }
      {
        mode = "n";
        key = "[y";
        action = "<Plug>(YankyCycleForward)";
      }
      {
        mode = "n";
        key = "]y";
        action = "<Plug>(YankyCycleBackward)";
      }
      {
        mode = "n";
        key = "]p";
        action = "<Plug>(YankyPutIndentAfterLinewise)";
      }
      {
        mode = "n";
        key = "[p";
        action = "<Plug>(YankyPutIndentBeforeLinewise)";
      }
      {
        mode = "n";
        key = "]P";
        action = "<Plug>(YankyPutIndentAfterLinewise)";
      }
      {
        mode = "n";
        key = "[P";
        action = "<Plug>(YankyPutIndentBeforeLinewise)";
      }
      {
        mode = "n";
        key = ">p";
        action = "<Plug>(YankyPutIndentAfterShiftRight)";
      }
      {
        mode = "n";
        key = "<p";
        action = "<Plug>(YankyPutIndentAfterShiftLeft)";
      }
      {
        mode = "n";
        key = ">P";
        action = "<Plug>(YankyPutIndentBeforeShiftRight)";
      }
      {
        mode = "n";
        key = "<P";
        action = "<Plug>(YankyPutIndentBeforeShiftLeft)";
      }
      {
        mode = "n";
        key = "=p";
        action = "<Plug>(YankyPutAfterFilter)";
      }
      {
        mode = "n";
        key = "=P";
        action = "<Plug>(YankyPutBeforeFilter)";
      }
    ];
  };
}
