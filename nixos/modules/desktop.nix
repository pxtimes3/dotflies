# /etc/nixos/modules/desktop.nix
{ config, pkgs, inputs, ... }: {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
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
    libsForQt5.qt5.qtwayland # ?
    qt6.qtwayland            # ?
    ifuse                    # mounting of iphone etc.
  ];

  security.pam.services.swaylock = {};

  environment.sessionVariables = {

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
}
