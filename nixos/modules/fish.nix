{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      g = "git";
      dc = "docker compose";
      n = "nvim";
      t = "task";
      ta = "task add";
    };

    shellAliases = {
      "..." = "cd ../..";
      "ls" = "eza -lahm";
    };

    interactiveShellInit = ''
      # Environment variables
      set -x BAT_THEME 'GitHub'
      set -x MANPAGER 'nvim +Man!'

      # Path modifications
      fish_add_path -p ~/bin /usr/local/bin/ ~/.config/bin
    '';

    functions = {
      ls = ''
        eza -lahm $argv
      '';
    };
  };
}
