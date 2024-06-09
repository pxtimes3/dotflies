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

    set -x GOPATH ~/go
    set -x GOCACHE $XDG_CACHE_HOME/go-build

    set -x TASKRC=~/.config/task/taskrc
    set -x TASKDATA=~/.config/taskdata

    fish_add_path -p ~/bin /usr/local/bin/ ~/.config/bin
  '';
in {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      g = "git";
      dc = "docker compose";
      n = "nvim";
    };

    shellAliases = {
      "..." = "cd ../..";
      "ls" = "eza -lahm";
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

    plugins = [
    ];
  };
}