# /home/px/.config/nixos/modules/utilities/default.nix
# Home for scripts and stuff. Put applications in nixos/programs.nix (or a separate module, w/e)

{ config, pkgs, inputs, ... }: let
  rebuild = pkgs.writeScriptBin "rebuild" (builtins.readFile ./scripts/rebuild);
  kitty_start = pkgs.writeScriptBin "kitty_start" (builtins.readFile ./scripts/kitty_start);
in {
  environment.systemPackages = with pkgs; [
    rebuild
    kitty_start
  ];
}
