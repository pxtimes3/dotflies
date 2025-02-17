# /home/px/.config/nixos/modules/vscode/default.nix
{ config, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		vscode.fhs
	];
}
