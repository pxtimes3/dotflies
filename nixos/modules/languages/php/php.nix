{
  pkgs,
  config,
  ...
}:
{
	packages = with pkgs; [
        php.withExtensions
    ];
}
