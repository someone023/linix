{
  description = "nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    chaotic = {
      url = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    chaotic,
    ...
  } @ inputs: let
    overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system overlays;
    };

    inherit (self) outputs;
  in {
    nixosConfigurations = {
      linix = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs outputs pkgs;};
        modules = [
          ({...}: {
            nixpkgs.overlays = overlays;
          })
          chaotic.nixosModules.default
          ./host
          ./system
        ];
      };
    };
  };
}
