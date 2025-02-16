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

  # Optimize journald
  services.journald = {
    extraConfig = ''
      Storage=volatile
      SystemMaxUse=50M
      RuntimeMaxUse=50M
      MaxFileSec=5day
      ForwardToSyslog=no
    '';
  };

  # USB optimizations
  boot = {
    kernelParams = [
      "quiet"
      "usbcore.autosuspend=-1"  # Disable USB autosuspend
      "usbhid.mousepoll=4"      # Reduce USB mouse polling rate
    ];
    
    kernelModules = [ "usbhid" "usbcore" ];
    
    # Optional: disable problematic port if needed
    extraModprobeConfig = ''
      options usbcore autosuspend=-1
    '';
  };

  # Optimize udev rules
  services.udev = {
    extraRules = ''
      # Reduce USB device timeout
      ACTION=="add", SUBSYSTEM=="usb", ATTR{power/autosuspend}="-1"
      
      # Optional: disable specific port if it continues to cause issues
      # ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="*", ATTR{idProduct}=="*", ATTR{bConfigurationValue}="0"
    '';
  };

  # Systemd optimizations
  systemd = {
    services.systemd-udevd.serviceConfig = {
      TimeoutSec = "60";
      Nice = "-10";  # Give udev higher priority
    };
    
    # Optimize journal
    services.systemd-journald.serviceConfig = {
      TimeoutStartSec = "30";
      Nice = "-10";
    };
  };
}
