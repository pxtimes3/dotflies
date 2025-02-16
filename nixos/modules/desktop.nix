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
      # Note the capital 'B' here
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };
    cpu.amd.updateMicrocode = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
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
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
    ];
  };

  # Explicitly disable KDE/SDDM
  services.xserver.enable = false;
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = false;
}
