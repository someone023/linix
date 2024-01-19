{
  programs.nixvim = {
    plugins.notify = {
      enable = true;
      backgroundColour = "#000000";
      fps = 60;
      render = "default";
      timeout = 4000;
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
        action = ''
          <cmd>lua require("notify").dismiss({ silent = true, pending = true })<cr>
        '';
        options.desc = "Clear Messages";
      }
    ];
  };
}
