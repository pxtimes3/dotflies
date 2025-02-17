# /etc/nixos/modules/utilities/default.nix
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Audio control
    pamixer        # Backend for volume control
    playerctl      # Media player control
    
    # Brightness
    light          # Alternative brightness control
    
    # System utilities
    wofi           # Application launcher
    wl-clipboard   # Clipboard management
    grim           # Screenshot utility
    slurp          # Area selection
    jq             # JSON processor
    socat          # Socket utility
    
    # File management
    ranger        # TUI file manager
    xfce.thunar        # GUI file manager
  ];

  environment.etc = {
    "utilities/volumectl".source = ./scripts/volumectl;
    "utilities/lightctl".source = ./scripts/lightctl;
    "utilities/wofi-emoji".source = ./scripts/wofi-emoji;
    "utilities/hypr-fix-special".source = ./scripts/hypr-fix-special;
    "utilities/rebuild".source = ./scripts/rebuild;
  };

  # Modified activation script
  system.activationScripts.utilities.text = ''
    mkdir -p /home/px/.local/bin
    for util in /etc/utilities/*; do
      name=$(basename "$util")
      cp -f "$util" "/home/px/.local/bin/$name"
      chmod +x "/home/px/.local/bin/$name"
    done
    chown -R px:users /home/px/.local/bin
  '';
}
