# /etc/nixos/modules/utilities/default.nix
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Audio control
    pamixer        # Backend for volume control
    playerctl      # Media player control
    
    # Brightness
    brightness     # For lightctl
    light          # Alternative brightness control
    
    # System utilities
    wofi           # Application launcher
    wl-clipboard   # Clipboard management
    grim          # Screenshot utility
    slurp         # Area selection
    jq            # JSON processor
    socat         # Socket utility
    
    # File management
    ranger        # TUI file manager
    thunar        # GUI file manager
  ];

  # Create the utility scripts
  environment.etc = {
    "utilities/volumectl".source = ./scripts/volumectl;
    "utilities/lightctl".source = ./scripts/lightctl;
    "utilities/wofi-emoji".source = ./scripts/wofi-emoji;
    "utilities/hypr-fix-special".source = ./scripts/hypr-fix-special;
    "utilities/rebuild".source = ./scripts/rebuild;
  };

  # Link scripts to PATH
  system.activationScripts.utilities = ''
    mkdir -p /home/px/.local/bin
    ln -sf /etc/utilities/* /home/px/.local/bin/
    chmod +x /home/px/.local/bin/*
    chown -R px:users /home/px/.local/bin
  '';
}
