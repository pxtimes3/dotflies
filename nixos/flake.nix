# /home/px/.config/nixos/flake.nix
{
  description = "PX's NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, hyprland, ... }@inputs: {
    nixosConfigurations."pxbeard" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        {
          # Make unstable packages available
          nixpkgs.overlays = [
            (final: prev: {
              unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
            })
          ];
        }
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
