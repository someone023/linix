{
  pkgs,
  lib,
  ...
}: {
  programs.helix.languages = {
    language = [
      {
        name = "bash";
        auto-format = true;
        formatter = {
          command = "${pkgs.shfmt}/bin/shfmt";
          args = ["-i" "2"];
        };
      }
      {
        name = "nix";
        auto-format = true;
        language-servers = [{name = "nil";}];
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
      }
    ];
    language-server = {
      bash-language-server = {
        command = "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server";
        args = ["start"];
      };

      clangd = {
        command = "${pkgs.clang-tools}/bin/clangd";
        clangd.fallbackFlags = ["-std=c++2b"];
      };

      nil.command = "${pkgs.nil}/bin/nil";
    };
  };
}
