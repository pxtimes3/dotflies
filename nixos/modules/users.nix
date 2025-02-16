# /etc/nixos/modules/users.nix
{ config, pkgs, ... }:

{
  users.users.px = {
    isNormalUser = true;
    description = "px";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
    shell = pkgs.fish;
  };

  # Enable Fish shell system-wide
  programs.fish = {
    enable = true;
  };

  # Auto-start Hyprland for user px on TTY1
  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland
    fi
  '';
}
