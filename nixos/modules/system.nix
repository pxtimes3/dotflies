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

  environment.systemPackages = [
    (pkgs.writeTextFile {
      name = "hyprland-config";
      destination = "/etc/hypr/hyprland.conf";
      text = builtins.readFile ./hyprland.conf;
    })
  ];

  # Create symlinks for the config
  system.activationScripts.hyprland-config = ''
    mkdir -p /home/px/.config/hypr
    ln -sf /etc/hypr/hyprland.conf /home/px/.config/hypr/hyprland.conf
    chown -R px:users /home/px/.config/hypr
  '';
}
