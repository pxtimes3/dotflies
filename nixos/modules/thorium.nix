{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [ 
    thorium
  ];
}