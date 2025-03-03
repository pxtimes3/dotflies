# modules/foot/default.nix
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    foot
  ];

  environment.etc."foot/foot.ini".source = ./foot.ini;

  system.activationScripts.foot-config = ''
    if id "px" &>/dev/null; then
      mkdir -p /home/px/.config/foot/conf.d
      touch /home/px/.config/foot/conf.d/00-default.ini
      ln -sf /etc/foot/foot.ini /home/px/.config/foot/foot.ini
      chown -R px:users /home/px/.config/foot
    else
      echo "User 'px' does not exist, skipping foot config setup"
    fi
  '';
}
