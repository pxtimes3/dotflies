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

    # IOS
    libimobiledevice

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
    mongodb-compass
    gpsbabel-gui # Garmin FIT-files
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

    # Wine/Lutris
    lutris
    wine
    winetricks
  ];

  programs = {
    fish.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
