# /etc/nixos/modules/foot/default.nix
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    foot
    tmux  # Since we're using foot-tmux
  ];

  # Create a foot-tmux wrapper script
  environment.etc."foot/foot-tmux".source = ./foot-tmux;
  environment.etc."foot/foot.ini".source = ./foot.ini;

  system.activationScripts.foot-config = ''
    mkdir -p /home/px/.config/foot
    ln -sf /etc/foot/foot.ini /home/px/.config/foot/foot.ini
    ln -sf /etc/foot/foot-tmux /home/px/.local/bin/foot-tmux
    chmod +x /home/px/.local/bin/foot-tmux
    chown -R px:users /home/px/.config/foot
    chown -R px:users /home/px/.local/bin/foot-tmux
  '';
}
