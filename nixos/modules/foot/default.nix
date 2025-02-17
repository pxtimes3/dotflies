# ~/.config/nixos/modules/foot/default.nix
{ config, pkgs, ... }: let
  footTmux = pkgs.writeScriptBin "foot-tmux" ''
    #!/usr/bin/env bash
    exec ${pkgs.foot}/bin/foot ${pkgs.tmux}/bin/tmux
  '';

  # Create foot.ini as a package
  footConfig = pkgs.writeTextFile {
    name = "foot-config";
    destination = "/etc/foot/foot.ini";
    text = ''
      # Font configuration
      font=JetBrainsMono Nerd Font:size=12
      pad=10x10

      # Catppuccin Frappe Theme
      [colors]
      alpha=0.95
      foreground=c6d0f5
      background=303446
      selection_background=F2D5CF
      selection_foreground=303446
      cursor=F2D5CF
      cursor_text_color=303446

      # normal
      color0=51576D
      color1=E78284
      color2=A6D189
      color3=E5C890
      color4=8CAAEE
      color5=F4B8E4
      color6=81C8BE
      color7=B5BFE2

      # bright
      color8=626880
      color9=E78284
      color10=A6D189
      color11=E5C890
      color12=8CAAEE
      color13=F4B8E4
      color14=81C8BE
      color15=A5ADCE

      # extended colors
      color16=EF9F76
      color17=F2D5CF
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
