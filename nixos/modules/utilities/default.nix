# /home/px/.config/nixos/modules/utilities/default.nix
{ config, pkgs, inputs, ... }: let
  rebuild = pkgs.writeScriptBin "rebuild" (builtins.readFile ./scripts/rebuild);
in {
  environment.systemPackages = with pkgs; [
    # Audio control
    pamixer
    playerctl

    # Brightness
    # light

    # System utilities
    # wofi
    wl-clipboard
    # grim
    # slurp
    wev       # wayland event viewer
    # socat
    # mako

    # File management
    # ranger
    # xfce.thunar

    # Terminal
    # foot
    # tmux

    # Custom scripts
    #volumectl
    #lightctl
    #wofiEmoji
    #hyprFixSpecial
    rebuild
    #footTmux
  ];
}
