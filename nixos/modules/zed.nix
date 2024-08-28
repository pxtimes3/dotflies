# zed.nix
{
  pkgs,
  config,
  ...
}:
{
	programs.zed-editor = {
    	enable = true;
	};
}

