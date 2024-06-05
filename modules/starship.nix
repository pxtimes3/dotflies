{
  pkgs,
  config,
  ...
}:
{
  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[!](bold red)";
      };
    };
  };
}