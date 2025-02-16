# /etc/nixos/modules/programs.nix
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
    waybar
    wofi
    hyprpaper
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

    # Theming
    gtk3
    gtk4

    # Browser
    firefox
  ];

  programs = {
    fish.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
