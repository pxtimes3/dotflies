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
  imports = [
    ../modules/alacritty.nix
    ../modules/kitty.nix
    ../modules/wezterm.nix
    ../modules/terminals/foot.nix
    ../modules/fish.nix

    ../modules/taskwarrior.nix

    ../modules/sessionvariables.nix
  ];

  nixpkgs = {
    overlays = [];
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
    taskwarrior # task manager
    krita
    inkscape
    zellij
    obsidian

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

    # terminal
    # kitty       #
    # alacritty   # BATTLE OF THE TERMINAL EMULATORS!!!
    # wezterm     #
    foot          # FOOT WON!
    nnn
    neofetch
    fish

    # -- hyprland
    # wofi

    # procrastination
    discord
    telegram-desktop
    vlc
    wine
    plexamp
    komga

    # fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc
    fishPlugins.z
    grc

    # nosqlite?
    sqlite

    # code
    sublime4
    sublime-merge

    # gamedev
    godot_4
    unityhub

    # 3D
    #blender
    blender-hip
    clinfo
    amdgpu_top

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

    # lutris
    lutris
    # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
    gst_all_1.gstreamer
    # Common plugins like "filesrc" to combine within e.g. gst-launch
    gst_all_1.gst-plugins-base
    # Specialized plugins separated by quality
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    # Plugins to reuse ffmpeg to play almost every video format
    gst_all_1.gst-libav
    # Support the Video Audio (Hardware) Acceleration API
    gst_all_1.gst-vaapi
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # disable warning when on unstable
  home.enableNixpkgsReleaseCheck = false;

  # enable numlock
  xsession.numlock.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
