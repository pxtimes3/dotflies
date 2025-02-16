# /etc/nixos/modules/desktop.nix
{ config, pkgs, ... }: {
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
      ];
    };
    cpu.amd.updateMicrocode = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    # Add these Wayland utilities
    wayland
    wayland-utils
    wlr-randr
    libinput
    xwayland
  ];

  security.pam.services.swaylock = {};

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XCURSOR_SIZE = "24";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
    ];
  };

  # Explicitly disable KDE/SDDM
  services.xserver.enable = false;
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = false;
}
