{ lib
, pkgs
, ...
}:

{
  imports = [
    ./kitty.nix
    ./media.nix
    ./xdg.nix
    ./system-tools.nix
    ./git.nix
  ];

  programs = {
    chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
        { id = "bkkmolkhemgaeaeggcmfbghljjjoofoh"; }
      ];
    };
  };

}
