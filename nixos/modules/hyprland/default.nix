# /etc/nixos/modules/hyprland/default.nix
{ config, pkgs, ... }: {
  # Basic Hyprland enablement is already in desktop.nix
  environment.systemPackages = [
    (pkgs.writeTextFile {
      name = "hyprland-config";
      destination = "/etc/hypr/hyprland.conf";
      text = builtins.readFile ./hyprland.conf;
    })
  ];

  # Ensure config directory exists and symlink is created
  system.activationScripts.hyprland-config = ''
    mkdir -p /home/px/.config/hypr
    ln -sf /etc/hypr/hyprland.conf /home/px/.config/hypr/hyprland.conf
    chown -R px:users /home/px/.config/hypr
  '';
}

# Create a separate /etc/nixos/modules/hyprland/hyprland.conf file
# This keeps the configuration clean and easily editable
