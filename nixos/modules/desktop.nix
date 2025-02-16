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
        rocmPackages.clr.icd
        rocmPackages.clr
      ];
    };
    cpu.amd.updateMicrocode = true;
  };

  # Updated XDG portal configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # Configure portal
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XCURSOR_SIZE = "24";
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
