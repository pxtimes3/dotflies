# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    #./fish.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # nixpkgs config
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "px";
    homeDirectory = "/home/px/";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager
    # archives
    zip
    xz
    unzip
    p7zip
    rar

    # languages
    # python
    python3
    pipx

    # utils
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # compilers
    gcc

    # terminal
    kate
    nnn
    neofetch
    fish

    # hyprland
    kitty
    wofi

    # procrastination
    discord
    telegram-desktop
    vlc
    lutris
    wine
    steam

    # fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc
    grc

    # nosqlite?
    sqlite

    #godot
    godot_4
  ];

  # virtualisation.virtualbox.host.enable = true;

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Magnus Sandell";
    userEmail = "magols@gmail.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = false;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      import = [
        "~/.config/alacritty/my.config.toml"
      ];
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.fish = {
    enable = true;
    plugins = [

    ];
    shellAliases = {
      "..." = "cd ../..";
      "ls" = "eza -lahm";
    };
  };
  programs.fish.functions = {
    __fish_command_not_found_handler = {
      body = "__fish_default_command_not_found_handler $argv[1]";
      onEvent = "fish_command_not_found";
    };
    gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    monkey = "echo monkey";
  };


  programs.direnv.enable = true;
  programs.zsh.enable = true;
  programs.bash.enable = true;

  programs.nix-index.enable = true;

  programs.firefox.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # disable warning when on unstable
  home.enableNixpkgsReleaseCheck = false;
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
