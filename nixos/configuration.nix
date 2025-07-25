# /home/px/.config/nixos/configuration.nix
{ config, pkgs, inputs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shares.nix
    ./hardware-configuration.nix
    ./modules
  ];

  # Docker
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "px" ];

  # Add ~/.local/bin to PATH
  environment.sessionVariables = {
    PATH = [
      "\${HOME}/.local/bin"
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  system.stateVersion = "23.11";
}
