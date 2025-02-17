{ config, pkgs, ... }: let
  volumectl = pkgs.writeScriptBin "volumectl" (builtins.readFile ./scripts/volumectl);
  lightctl = pkgs.writeScriptBin "lightctl" (builtins.readFile ./scripts/lightctl);
  wofiEmoji = pkgs.writeScriptBin "wofi-emoji" (builtins.readFile ./scripts/wofi-emoji);
  hyprFixSpecial = pkgs.writeScriptBin "hypr-fix-special" (builtins.readFile ./scripts/hypr-fix-special);
  rebuild = pkgs.writeScriptBin "rebuild" (builtins.readFile ./scripts/rebuild);
in {
  environment.systemPackages = with pkgs; [
    # Audio control
    pamixer
    playerctl

    # Brightness
    light

    # System utilities
    wofi
    wl-clipboard
    grim
    slurp
    jq
    socat

    # File management
    ranger
    xfce.thunar

    # Our custom scripts
    volumectl
    lightctl
    wofiEmoji
    hyprFixSpecial
    rebuild
  ];
}
