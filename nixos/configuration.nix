# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/programs.nix
    ./modules/users.nix
    ./modules/waybar
  ];

  system.stateVersion = "23.11";
}
