{ config, pkgs, ... }: let
  volumectl = pkgs.writeScriptBin "volumectl" (builtins.readFile ./scripts/volumectl);
  lightctl = pkgs.writeScriptBin "lightctl" (builtins.readFile ./scripts/lightctl);
  wofiEmoji = pkgs.writeScriptBin "wofi-emoji" (builtins.readFile ./scripts/wofi-emoji);
  hyprFixSpecial = pkgs.writeScriptBin "hypr-fix-special" (builtins.readFile ./scripts/hypr-fix-special);
  rebuild = pkgs.writeScriptBin "rebuild" (builtins.readFile ./scripts/rebuild);
  footTmux = pkgs.writeScriptBin "foot-tmux" ''
    #!/usr/bin/env bash
    exec ${pkgs.foot}/bin/foot ${pkgs.tmux}/bin/tmux
  '';
  windowSwitcher = pkgs.writeScriptBin "window-switcher" ''
    #!/usr/bin/env bash
    hyprctl clients -j | \
      jq -r '[.[] | select(.mapped == true) | {class: .class, title: .title, address: .address}]' | \
      jq -r '.[] | .class + ": " + .title + "\u0000icon\u001f" + .class + "\u000info\u001f" + .address' | \
      wofi --show dmenu \
           --insensitive \
           --allow-images \
           --width 600 \
           --height 400 \
           --prompt "Switch to:" \
           --cache-file /dev/null \
           --define "hide_scroll=true" \
           --define "matching=fuzzy" | \
      sed 's/.*\x0info\x1f//' | xargs hyprctl dispatch focuswindow
  '';
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

    # Terminal
    foot
    tmux

    # Our custom scripts
    volumectl
    lightctl
    wofiEmoji
    hyprFixSpecial
    rebuild
    footTmux
  ];
}
