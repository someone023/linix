{
  inputs,
  system,
  ...
}: {
  imports = [
    #./yazi
    ./shell

    ./nix-index.nix
    ./btop.nix
    ./git.nix
    ./kitty.nix
    ./tools.nix
    ./nix-index.nix
    ./bat.nix
  ];
}
