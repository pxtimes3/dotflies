# /home/px/.config/nixos/configuration.nix
{ config, pkgs, inputs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/programs.nix
    ./modules/users.nix
    ./modules/vscode/default.nix

    # utils, scripts etc...
    ./modules/utilities/default.nix
  ];

  # Docker
  virtualisation.docker.enable = true;

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
