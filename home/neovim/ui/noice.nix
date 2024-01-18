{
  programs.nixvim = {
    plugins.notify = {
      enable = true;
    };

    plugins.noice = {
      enable = true;
      notify.enabled = true;
      popupmenu = {
        enabled = true;
        backend = "nui";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>fm";
        action = "<cmd>lua require('noice').cmd('telescope')<CR>";
        options.desc = "Find Messages";
      }
      {
        mode = "n";
        key = "<leader>C";
        action = "<cmd>lua require('noice').cmd('dismiss')<CR>";
        options.desc = "Clear Messages";
      }
    ];
  };
}
