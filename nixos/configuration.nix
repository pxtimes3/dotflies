# /etc/nixos/configuration.nix
{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/programs.nix
    ./modules/users.nix
    ./modules/hyprland/default.nix  # Make sure this path is correct
    ./modules/waybar/default.nix
  ];

  system.stateVersion = "23.11";
}
