# /etc/nixos/modules/hyprland/default.nix
{ config, pkgs, ... }: {
  # environment.etc."hypr/hyprland.conf".source = ./hyprland.conf;
  environment.systemPackages = [
    (pkgs.writeTextFile {
      name = "hyprland-config";
      destination = "/home/px/.config/hypr/hyprland.conf";
      text = builtins.readFile ./hyprland.conf;
    })
  ];

  # system.activationScripts.hyprland-config = ''
  #   mkdir -p /home/px/.config/hypr
  #   ln -sf /etc/hypr/hyprland.conf /home/px/.config/hypr/hyprland.conf
  #   chown -R px:users /home/px/.config/hypr
  # '';
}
