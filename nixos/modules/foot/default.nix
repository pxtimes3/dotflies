# /etc/nixos/modules/foot/default.nix
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    foot
  ];

  # Create config directory and file
  environment.etc."foot/foot.ini".source = ./foot.ini;

  # Setup activation script
  system.activationScripts.kitty-config = ''
    mkdir -p /home/px/.config/foot
    ln -sf /etc/foot/foot.ini /home/px/.config/foot/foot.ini
    chown -R px:users /home/px/.config/foot
  '';
}
