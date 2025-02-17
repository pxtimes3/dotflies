# /home/px/.config/nixos/modules/users.nix
{ config, pkgs, ... }:

{
  users.users.px = {
    isNormalUser = true;
    description = "px";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
    shell = pkgs.fish;
  };

  # Enable Fish shell system-wide
  programs.fish = {
    enable = true;
  };
}
