# /home/px/.config/nixos/modules/programs.nix
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Terminal
    # kitty
    # ghostty
    zellij

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
    cargo

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
    git
    neovim
    # gcc
    # gnumake
    # love

    # procrastination
    telegram-desktop
    discord
    plexamp
    steam
    vlc

    # 3D
    # blender-hip

    # Printers
    gutenprint
    hplip

    # Audio
    audacity
  ];

  programs = {
    fish.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
