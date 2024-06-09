{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [ 
    foliate
  ];
}