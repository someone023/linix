{ lib
, pkgs
, ...
}:


let
  colorschemePath = "/org/gnome/desktop/interface/color-scheme";
  dconf = "${pkgs.dconf}/bin/dconf";

  dconfDark = lib.hm.dag.entryAfter [ "dconfSettings" ] ''
    ${dconf} write ${colorschemePath} "'prefer-dark'"
  '';
  dconfLight = lib.hm.dag.entryAfter [ "dconfSettings" ] ''
    ${dconf} write ${colorschemePath} "'prefer-light'"
  '';
in
{
  imports = [
    ./kitty.nix
    ./media.nix
    ./xdg.nix
    ./system-tools.nix
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
