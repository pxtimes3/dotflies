# handbrake.nix
{
  pkgs,
  config,
  ...
}:
{
	programs.handbrake = {
    	enable = true;
	};
}
