{pkgs, ...}: {
  imports = [
    ./wayland
    ./firefox.nix
    ./xdg.nix
    ./media.nix
    ./gtk.nix
  ];

  home.packages = with pkgs; [
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
