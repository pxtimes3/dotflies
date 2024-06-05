{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: 
let
  filesIn = dir: (map (fname: dir + "/${fname}"))
                 (builtins.attrNames (builtins.readDir dir));
in
{
  # You can import other home-manager modules here
  imports = [] ++ (filesIn ../modules);

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

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

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
    ldns # replacement of `dig`, it provides the command `drill`
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
    gnumake

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
    wcalc # CLI-calculator
    taskwarrior # task manager

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
    keyd # key remapping
    
    # compilers
    gcc

    # terminal
    kate
    nnn
    neofetch
    fish

    # -- hyprland
    # kitty
    # wofi

    # procrastination
    discord
    telegram-desktop
    vlc
    lutris
    wine
    steam
    plexamp

    # fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc
    grc

    # nosqlite?
    sqlite

    # code
    sublime4
    sublime-merge
    vscode

    # gamedev
    godot_4
    blender
    unityhub

    # reverse engineering
    objconv

    # fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    #proggyfonts
    nerdfonts
  ];

  #fonts.fontconfig.enable = true;

  # allow openssl-1.1.1w due to sublime4
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # git, for obvious reasons
  programs.git = {
    enable = true;
    userName = "Magnus Sandell";
    userEmail = "magols@gmail.com";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
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
