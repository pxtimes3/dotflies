{ config, pkgs, ... }: {
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;  # Keep only 5 generations
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";  # Your EFI is mounted at /boot
    };
  };
}
