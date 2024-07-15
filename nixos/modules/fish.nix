{
  pkgs,
  config,
  ...
}: let
  # These options are set by home manager programs.fzf
  # https://github.com/rycee/home-manager/blob/master/modules/programs/fzf.nix#blob-path
  # It's pointless to use home manager programs.fzf if I'm setting these anyway
  fishConfig = ''
    bind \cb edit_command_buffer

    set -x BAT_THEME 'GitHub'

    set -x MANPAGER 'nvim +Man!'

    # https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
    # XDG_RUNTIME_DIR should be set by pam_systemd
    set -x XDG_CONFIG_HOME $HOME/.config
    set -x XDG_DATA_HOME $HOME/.local/share
    set -x XDG_CACHE_HOME $HOME/.cache

    ## HYDRO ##
    # -- symbols
    set --global hydro_symbol_prompt ❱
    set --global hydro_symbol_git_dirty 🞋
    set --global hydro_symbol_git_ahead ⬆
    set --global hydro_symbol_git_behind ⬇
    # -- colors
    set --global hydro_color_prompt 73daca
    set --global hydro_color_pwd 73daca
    set --global hydro_color_git ff9e64
    set --global hydro_color_error f7768e
    set --global hydro_color_duration 7dcfff
    # -- flags
    set --global hydro_fetch true
    set --global hydro_multiline false
    # -- misc
    set --global fish_prompt_pwd_dir_length 3
    set --global hydro_ignored_git_paths ""
    set --global hydro_cmd_duration_threshold 500

    fish_add_path -p ~/bin /usr/local/bin/ ~/.config/bin

    ## DIRENV
    set -g direnv_fish_mode disable_arrow
    direnv hook fish | source

    ## OPENCV
    set -x GDK_BACKEND wayland
    set -x QT_QPA_PLATFORM wayland
    set -x XDG_SESSION_TYPE wayland
    set -x SDL_VIDEODRIVER wayland

  '';
in {
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
      "ls" = "eza -lam";
    };

    interactiveShellInit = fishConfig;

    functions = {
      gi = {
        description = "Pick commit for interactive rebase";
        body = ''
          set -l commit (git log --oneline --decorate | fzf --preview 'git show (echo {} | awk \'{ print $1 }\')' | awk '{ print $1 }')
          if test -n "$commit"
            git rebase $commit~1 --interactive --autosquash
          end
        '';
      };

      gf = {
        description = "Fixup a commit then autosquash";
        body = ''
          set -l commit (git log --oneline --decorate | fzf --preview 'git show (echo {} | awk \'{ print $1 }\')' | awk '{ print $1 }')
          if test -n "$commit"
            git commit --fixup $commit
            GIT_SEQUENCE_EDITOR=true git rebase $commit~1 --interactive --autosquash
          end
        '';
      };

      gc = {
        description = "fzf git checkout";
        body = ''
          git checkout (git branch -a --sort=-committerdate |
            fzf --preview 'git log (echo {} | sed -E -e \'s/^(\+|\*)//\' | string trim) -- ' |
            sed -E -e 's/^(\+|\*)//' |
            xargs basename |
            string trim)
        '';
      };

      run_wayland = {
        description="run as wayland";
        body = ''
          env GDK_BACKEND=wayland QT_QPA_PLATFORM=wayland $argv
        '';
      };


      run_x11 = {
        description="run as x11";
        body = ''
          env GDK_BACKEND=x11 QT_QPA_PLATFORM=xcb $argv
        '';
      };

      fish_greeting = {
        body = ''
        '';
      };
      __fish_command_not_found_handler = {
        body = ''
          __fish_default_command_not_found_handler $argv[1]
        '';
        onEvent = ''
          fish_command_not_found
        '';
      };
      gitignore = ''
        curl -sL https://www.gitignore.io/api/$argv
      '';
    };
  };
}
