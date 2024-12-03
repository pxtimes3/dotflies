{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    package = pkgs.fish;
    plugins = [];

    # shellAbbrs = {
    #  g = "git";
    #  dc = "docker compose";
    #  n = "nvim";
    #  t = "task";
    #  ta = "task add";
    # };

    # shellAliases = {
    #  "..." = "cd ../..";
    #  "ls" = "eza -lahm";
    # };

    interactiveShellInit = ''
      # Environment variables
      set -x BAT_THEME 'GitHub'
      set -x MANPAGER 'nvim +Man!'
      set -x LUA_PATH "?.lua;?/init.lua;${pkgs.lua54Packages.lrexlib-pcre}/share/lua/5.4/?.lua;${pkgs.lua54Packages.lrexlib-pcre}/share/lua/5.4/?/init.lua;;"
      set -x LUA_CPATH "${pkgs.lua54Packages.lrexlib-pcre}/lib/lua/5.4/?.so;;"

      # Path modifications

      fish_add_path -p /run/current-system/sw/bin ~/.nix-profile/bin ~/bin /usr/local/bin/ ~/.config/bin
    '';

    # functions = {
    #   ls = ''
    #     eza -lahm $argv
    #   '';
    # };
  };
}
