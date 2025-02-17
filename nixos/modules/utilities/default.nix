# /home/px/.config/nixos/modules/utilities/default.nix
{ config, pkgs, inputs, ... }: let
  rebuild = pkgs.writeScriptBin "rebuild" (builtins.readFile ./scripts/rebuild);
  kitty_start = pkgs.writeScriptBin "kitty_start" (builtins.readFile ./scripts/kitty_start);
in {
  environment.systemPackages = with pkgs; [
    # Audio control
    pamixer
    playerctl

    wl-clipboard
    wev       # wayland event viewer

    # my scripts
    rebuild
    kitty_start
  ];
}
