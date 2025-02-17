# /home/px/.config/nixos/modules/programs.nix
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Terminal
    kitty
    ghostty

    # Development
    git
    neovim
    gcc
    gnumake

    # System monitoring
    btop
    htop
    neofetch

    # Media
    ffmpeg
    x264
    x265

    # Wayland utilities
    wl-clipboard
    grim
    slurp

    # File management
    ranger

    # Utilities
    wget
    curl
    ripgrep
    fd
    tree
    unzip
    zip
    jq

    # Audio
    pavucontrol
    plexamp

    # Theming
    gtk3
    gtk4
    nwg-look

    # Browser
    firefox

    # code
    sublime4
    sublime-merge
    # vscode is in modules/vscode/

    # procrastination
    telegram-desktop
    discord
    plexamp
    steam
  ];

  programs = {
    fish.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
