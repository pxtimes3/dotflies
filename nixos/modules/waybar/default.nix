# /etc/nixos/modules/waybar/default.nix
{ config, pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.writeTextFile {
      name = "waybar-config";
      destination = "/etc/waybar/config";
      text = builtins.readFile ./config.json;
    })
    (pkgs.writeTextFile {
      name = "waybar-style";
      destination = "/etc/waybar/style.css";
      text = builtins.readFile ./style.css;
    })
  ];

  # Create symlinks for the config
  system.activationScripts.waybar-config = ''
    mkdir -p /home/px/.config/waybar
    ln -sf /etc/waybar/config /home/px/.config/waybar/config
    ln -sf /etc/waybar/style.css /home/px/.config/waybar/style.css
    chown -R px:users /home/px/.config/waybar
  '';
}
