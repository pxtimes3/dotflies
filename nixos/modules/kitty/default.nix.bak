# /etc/nixos/modules/kitty/default.nix
{ config, pkgs, ... }: {
  # Make sure kitty is installed
  environment.systemPackages = with pkgs; [
    kitty
  ];

  # Create config directory and file
  environment.etc."kitty/kitty.conf".source = ./kitty.conf;

  # Setup activation script
  system.activationScripts.kitty-config = ''
    mkdir -p /home/px/.config/kitty
    ln -sf /etc/kitty/kitty.conf /home/px/.config/kitty/kitty.conf
    chown -R px:users /home/px/.config/kitty
  '';
}
