# /etc/nixos/modules/system.nix
{ config, pkgs, ... }: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "pxbeard";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Stockholm";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  console = {
    keyMap = "sv-latin1";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    dbus.enable = true;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}



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

# /etc/nixos/modules/users.nix
{ config, pkgs, ... }: {
  users.users.px = {
    isNormalUser = true;
    description = "px";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "docker"
    ];
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = false; # Optional: disable sudo password
}

# /etc/nixos/modules/hyprland/default.nix
{ config, pkgs, ... }: {
  imports = [
    ./config.nix
  ];
}

# /etc/nixos/modules/hyprland/config.nix
{ config, pkgs, ... }: {
  home-manager.users.px.xdg.configFile."hypr/hyprland.conf".text = ''
    # Monitor configuration
    monitor=,preferred,auto,1

    # Set programs
    $terminal = ghostty
    $menu = wofi --show drun
    $browser = firefox

    # Input configuration
    input {
        kb_layout = se
        follow_mouse = 1
        touchpad {
            natural_scroll = true
        }
        sensitivity = 0
    }

    general {
        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(33ccffee)
        col.inactive_border = rgba(595959aa)
        layout = dwindle
    }

    decoration {
        rounding = 10
        blur {
            enabled = true
            size = 3
            passes = 1
        }
        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = true
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }

    dwindle {
        pseudotile = true
        preserve_split = true
    }

    # Window rules
    windowrule = float, ^(pavucontrol)$
    windowrule = float, ^(blueman-manager)$

    # Key bindings
    bind = SUPER, Return, exec, $terminal
    bind = SUPER, Q, killactive,
    bind = SUPER, M, exit,
    bind = SUPER, E, exec, $fileManager
    bind = SUPER, V, togglefloating,
    bind = SUPER, R, exec, $menu
    bind = SUPER, P, pseudo,
    bind = SUPER, J, togglesplit,

    # Move focus
    bind = SUPER, left, movefocus, l
    bind = SUPER, right, movefocus, r
    bind = SUPER, up, movefocus, u
    bind = SUPER, down, movefocus, d

    # Workspaces
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5
    bind = SUPER, 6, workspace, 6
    bind = SUPER, 7, workspace, 7
    bind = SUPER, 8, workspace, 8
    bind = SUPER, 9, workspace, 9
    bind = SUPER, 0, workspace, 10

    # Move to workspace
    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4
    bind = SUPER SHIFT, 5, movetoworkspace, 5
    bind = SUPER SHIFT, 6, movetoworkspace, 6
    bind = SUPER SHIFT, 7, movetoworkspace, 7
    bind = SUPER SHIFT, 8, movetoworkspace, 8
    bind = SUPER SHIFT, 9, movetoworkspace, 9
    bind = SUPER SHIFT, 0, movetoworkspace, 10

    # Mouse bindings
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow

    # Startup
    exec-once = waybar
    exec-once = hyprpaper
  '';
}
