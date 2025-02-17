# ~/.config/nixos/modules/foot/default.nix
{ config, pkgs, ... }: let
  footTmux = pkgs.writeScriptBin "foot-tmux" ''
    #!/usr/bin/env bash
    exec ${pkgs.foot}/bin/foot ${pkgs.tmux}/bin/tmux
  '';

  footConfig = pkgs.writeTextFile {
    name = "foot-config";
    destination = "/etc/foot/foot.ini";
    text = ''
      [main]
      font=JetBrainsMono Nerd Font:size=12
      pad=10x10
      term=xterm-256color

      [colors]
      alpha=0.95
      foreground=c6d0f5
      background=303446
      regular0=51576d  # black
      regular1=e78284  # red
      regular2=a6d189  # green
      regular3=e5c890  # yellow
      regular4=8caaee  # blue
      regular5=f4b8e4  # magenta
      regular6=81c8be  # cyan
      regular7=b5bfe2  # white
      bright0=626880   # bright black
      bright1=e78284   # bright red
      bright2=a6d189   # bright green
      bright3=e5c890   # bright yellow
      bright4=8caaee   # bright blue
      bright5=f4b8e4   # bright magenta
      bright6=81c8be   # bright cyan
      bright7=a5adce   # bright white
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    foot
    tmux
    footTmux
    footConfig
  ];

  environment.etc."foot/foot.ini".source = "${footConfig}/etc/foot/foot.ini";
}
