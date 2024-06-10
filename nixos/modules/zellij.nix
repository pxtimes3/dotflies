{
  pkgs,
  config,
  ...
}:
{
  programs.zellij.settings = {
      theme = "gruvbox-dark";
      default_shell = "fish";
  };
}