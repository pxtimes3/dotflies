# /etc/nixos/configuration.nix
{ config, pkgs, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/programs.nix
    ./modules/users.nix
    ./modules/hyprland/default.nix
    ./modules/waybar/default.nix
    ./modules/foot/default.nix

    # utils, scripts etc...
    ./modules/utilities/default.nix
  ];

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
