{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [./languages.nix];

  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default.overrideAttrs (old: {
      makeWrapperArgs = with pkgs;
        old.makeWrapperArgs
        or []
        ++ [
          "--suffix"
          "PATH"
          ":"
          (lib.makeBinPath [
            clang-tools
            marksman
            nil
            lldb
          ])
        ];
    });

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        auto-format = true;
        auto-completion = true;
        color-modes = true;
        cursorline = true;
        completion-replace = true;
        mouse = true;
        rulers = [80];
        soft-wrap.enable = true;
        bufferline = "always";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        lsp.display-inlay-hints = true;
        statusline.center = ["position-percentage"];
        true-color = true;
        whitespace.characters = {
          newline = "↴";
          tab = "⇥";
        };
      };

      keys.normal.space.u = {
        f = ":format"; # format using LSP formatter
        w = ":set whitespace.render all";
        W = ":set whitespace.render none";
      };
    };
  };
}
