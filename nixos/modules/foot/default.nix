# modules/foot/default.nix
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    foot
  ];

  # Create the main foot.ini with specific includes
  environment.etc."foot/foot.ini".text = ''
    # Catppuccin Mocha theme for foot
    [colors]
    foreground=cdd6f4
    background=1e1e2e
    regular0=45475a  # black
    regular1=f38ba8  # red
    regular2=a6e3a1  # green
    regular3=f9e2af  # yellow
    regular4=89b4fa  # blue
    regular5=f5c2e7  # magenta
    regular6=94e2d5  # cyan
    regular7=bac2de  # white
    bright0=585b70   # bright black
    bright1=f38ba8   # bright red
    bright2=a6e3a1   # bright green
    bright3=f9e2af   # bright yellow
    bright4=89b4fa   # bright blue
    bright5=f5c2e7   # bright magenta
    bright6=94e2d5   # bright cyan
    bright7=a6adc8   # bright white

    [main]
    include=/home/px/.config/foot/conf.d/00-base.ini
    include=/home/px/.config/foot/conf.d/01-host.ini
    include=/home/px/.config/foot/conf.d/99-user.ini
    font=JetBrainsMono Nerd Font:size=11
    pad=8x8
    term=xterm-256color
    shell=fish

    [cursor]
    color=1e1e2e cdd6f4
    style=beam
    blink=yes

    [mouse]
    hide-when-typing=yes

    [scrollback]
    lines=1000
  '';

  system.activationScripts.foot-config = ''
    if id "px" &>/dev/null; then
      mkdir -p /home/px/.config/foot/conf.d
      
      # base
      cat > /home/px/.config/foot/conf.d/00-base.ini << 'EOF'
    [main]
    # base conf override
    EOF
      
      # host
      cat > /home/px/.config/foot/conf.d/01-host.ini << 'EOF'
    [main]
    # host conf override
    # dpi-aware=yes
    EOF
      
      if [ ! -f /home/px/.config/foot/conf.d/99-user.ini ]; then
        cat > /home/px/.config/foot/conf.d/99-user.ini << 'EOF'
    [main]
    # user conf
    EOF
      fi
      
      ln -sf /etc/foot/foot.ini /home/px/.config/foot/foot.ini
      chmod 755 /home/px/.config/foot/conf.d
      chmod 644 /home/px/.config/foot/conf.d/*.ini
      chown -R px:users /home/px/.config/foot
    else
      echo "User 'px' does not exist, are you an impostor!? Skipping foot config setup."
    fi
  '';
}
