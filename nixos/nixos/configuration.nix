{
  inputs,
  lib,
  config,
  pkgs,
  nixpkgs,
  ...
}: {
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
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
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://nixos.wiki/wiki/AMD_GPU
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];
  services.xserver.enable = true;
  # hardware.opengl.driSupport32Bit = true; # For 32 bit applications
  hardware.opengl = {
    enable = true;
    driSupport = true;
    #driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
      rocmPackages.rocminfo
      rocmPackages.rocm-runtime
      amdvlk
    ];
  };
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  
  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # enable flatpak 
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # TODO: Set your hostname
  networking.hostName = "pxbeard";

  users.users = {
    px = {
      isNormalUser = true;
      description = "Magnus";
      initialPassword = "johnsmith";
      packages = with pkgs; [
        # see home-manager/home.nix
      ];
      openssh.authorizedKeys.keys = [
      	"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoerzXnm+mdtHQaqG3dNThCRCzciv5ZEDQIN/rDj4Zu9lHgbW5PL1ZVQEZjNMLOFCBqwm3H0J6b2a7K8sC9Drypf1IlQ1hOpSIvFuYFUuYJIXxIqTTp6Rz9BVRx6HFKH1S4C7Aw9YLLfYp9AALEv8lp7R4a1boFmhOJsSZ4ZoHViBXQVnqNdSw+7OCIqg7h+L/LntOFl1RKcxOENJtDhVpyAb1TdFUYQg04tjeaBuJNI8ERf+vhXNQJ65d8/yUvtPK0uyVYBSKFj/rP+t7336SxGdbp6mYkZSV3aLsgyRhe/k/C20cAR/s+DB4Ri+FVhwiSMCpjV69oHQfGkYrUOkZn/OAcduUK7lIdY/SSHgeDccunjK5nR8qIl/L9FcRJcGN90t8y4vXpdZPSD9oSNfJN+LMbKABqzGAo2g9HIy3bvmUKokAGEg41uyYs8zXS4WXvVmqKAs/0oWGxOVqdGA5hLpMO1D4Pw5ydTfQzQUF81HxqjY8q453Hs1MJIiTl2Tp9+NJtYWFBCRBIT/r/Xsvl0QjMlvJ1cIWyv1Y30IZluVzETTX5ZqvMsMKpzUpfrME1fmQRJo71Kw/RhyUPKR8xajvSUxnBFQdEEbFMrvlruqYdtbwqDOrEt5aUrAiS7uW/T8l535fy9EqFViZRzxyMABhaH0nzWjwzH0Uy3u7QQ== m@mactop.lan" 
	      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDDf+RSelkuoVyfqf3sagpdCFMDNkFV0ABzxrZNdRYQr px@pxnix" 
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJm9tjiaAURpQx3HR/Y+rKHAq4p2Gc0GHb7LWoI61g4c px@pxLinux" 
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxb69wvAM7+umL6ERXfhxtiTG3+W400q3sf+2K10MPdEQrbVU81OabjpErgAE8q2nVYnCddvlVGyrgA7PB83wypg+pnaDFhZP+lIN1T3jxgi6+aJIPbiV5OK1gnFWh9NBOfgVVWA787dxa8Bhb0YAf9rZEd1qpR/u3YWfwi/ftAwg6BtIdxwgFyoEaRt4cxUt5Xpw4UEgCY3J+zl2pHn2c41JAmX4J7KUMLK3Rs5fBcWZwpmwe3CHWReImUClUNIScSfOH8cvMV8tk2r1qRbOmfXXkVM1/p5aRRNS9+C57Ag2HN1QmdYNKKZnDTAW7yiIvDyzL+hid51KNW6yF29/1 px@Magnuss-iMac.lan"
      ];
      extraGroups = ["networkmanager" "wheel" "qemu-libvirtd" "docker"];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    alejandra
    xorg.xev
    docker
    partition-manager
    libsForQt5.kpmcore
    ventoy-full
    gparted
    git
  ];

  programs.steam = {
      enable = true;
    };
  services.dbus.packages = [ pkgs.libsForQt5.kpmcore ];

  services.openssh = {
    enable = true;
    #ffs
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  ## network mounts
  services.rpcbind.enable = true;
  systemd.mounts = [{
    type = "nfs";
    mountConfig = {
      Options = "noatime";
    };
    what = "192.168.1.57:/volume1/ds423";
    where = "/mnt/ds423/volume1";
  }];
  systemd.automounts = [{
    wantedBy = [ "multi-user.target" ];
    automountConfig = {
      TimeoutIdleSec = "600";
    };
    where = "/mnt/ds423/volume1";
  }];

  systemd.user.services."pushToGit" = {
    description = "Push configs to git";
    wantedBy = ["multi-user.target"];
    path = [   
      pkgs.bash
      pkgs.openssh
    ];
    script = ''
      /home/px/.config/bin/push-dotflies >> /home/px/.config/bin/push-dotflies.log;
      /home/px/.config/bin/push-obsidian >> /home/px/.config/bin/push-obsidian.log;
      /home/px/.config/bin/push-taskdata >> /home/px/.config/bin/push-taskdata.log
    '';
    serviceConfig = {
      Type = "oneshot";
    };
    startAt = "hourly";
  };
  systemd.user.timers."pushToGit" = {
    timerConfig = {
      Persistent = true;
      OnCalendar = [ "*-*-* 16:15:00" ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
