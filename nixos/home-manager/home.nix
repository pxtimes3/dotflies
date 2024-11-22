{
  inputs,
  lib,
  config,
  pkgs,
  system,
  ...
}:
let
  nodePackages = pkgs.callPackage ../modules/languages/node/node-packages.nix {
    inherit pkgs;
    inherit (pkgs) system;
    nodejs = pkgs.nodejs_22;
  };

  # Helper function to safely get the bin directory of a package
  safeGetBin = pkg:
    if builtins.isAttrs pkg && pkg ? outPath
    then "${pkg}/bin"
    else if builtins.isAttrs pkg && pkg ? bin
    then "${pkg.bin}"
    else null;

  # Get a list of bin directories for all node packages
  nodeBinPaths = lib.filter (x: x != null) (map safeGetBin (builtins.attrValues nodePackages));

  filesIn = dir: (map (fname: dir + "/${fname}"))
                 (builtins.attrNames (builtins.readDir dir));
in
{
  imports = [
    ../modules/terminals/foot.nix
    #../modules/zed.nix
    ../modules/vscode.nix
    ../modules/sessionvariables.nix
    #../modules/languages/php/php.nix
  ];

  nixpkgs = {
    overlays = [
  (self: super: {
    docker-compose = super.docker-compose.overrideAttrs (oldAttrs: {
      version = "2.30.2";
      src = super.fetchFromGitHub {
        owner = "docker";
        repo = "compose";
        rev = "v2.30.2";
        sha256 = "sha256-OMqbDhfWBM/1AhCKRGr6yBp+ubdj69Sq9bilKWe18Fk=";
      };
    });
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "px";
    homeDirectory = "/home/px/";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    NODE_PATH = lib.makeSearchPath "lib/node_modules" nodeBinPaths;
    PATH = lib.makeSearchPath "bin" (["$HOME/.local/bin"] ++ nodeBinPaths);
  };

  home.packages = with pkgs; [
    docker-compose  # temp för att fixa idioting i 2.30
    # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager
    # archives
    zip
    xz
    unzip
    p7zip
    rar

    # c++
    gdb
    gcc
    clang-tools
    cmake
    codespell
    conan
    cppcheck
    doxygen
    gtest
    lcov
    #vcpkg
    vcpkg-tool

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
    nodejs
    tldr

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
    taskwarrior3 # task manager
    krita
    inkscape
    zellij
    obsidian

    # video
    handbrake
    x264
    x265
    ffmpeg

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
    duplicity
    watchexec
    #hplip           # HP Print drivers
    hplipWithPlugin # HP Print drivers
    logiops

    # terminal
    foot
    nnn
    neofetch
    fish

    # procrastination
    discord
    vesktop
    telegram-desktop
    vlc
    wine
    plexamp
    komga

    # fish
    fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    # fishPlugins.grc  # fucks with ls
    fishPlugins.z
    # grc

    # nosqlite?
    sqlite

    # code
    sublime4
    sublime-merge

    # gamedev
    # godot_4
    # unityhub

    # 3D
    # blender
    # blender-hip
    clinfo
    amdgpu_top

    # reverse engineering
    objconv

    # fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    #proggyfonts
    nerdfonts

    zed-editor
    nushell

    # NODEJS
    # nodejs_22
    # use nix-shell instead
];

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

  programs.nix-index.enable = true;

  programs.firefox.enable = true;
  programs.chromium.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # disable warning when on unstable
  home.enableNixpkgsReleaseCheck = false;

  # enable numlock
  xsession.numlock.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
