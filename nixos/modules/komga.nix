{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [ 
    komga
  ];
}