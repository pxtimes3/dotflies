# /home/px/.config/nixos/modules/system.nix
{ config, pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;  # Keep only 5 generations
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    kernel.sysctl = {
      "vm.swappiness" = 10;                # Reduce swap usage
      "vm.vfs_cache_pressure" = 50;        # Better inode/dentry cache
      "vm.dirty_background_ratio" = 5;     # Start writing at 5%
      "vm.dirty_ratio" = 10;               # Force write at 10%
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

  # NVME
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # USB optimizations
  boot = {
    kernelParams = [
      "quiet"
      "usbcore.autosuspend=-1"  # Disable USB autosuspend
      "usbhid.mousepoll=4"      # Reduce USB mouse polling rate
      "xhci_hcd.quirks=0x40"    # USB3.0?g
      "usb-port.port_disable=1-11" # -.-
    ];
    
    kernelModules = [ "usbhid" "usbcore" ];

    blacklistedKernelModules = [ "usb_port_1_11" ];
    
    extraModprobeConfig = ''
      options usbcore autosuspend=-1
    '';
  };

  # Optimize udev rules
  services.udev = {
    extraRules = ''
      # Reduce USB device timeout
      ACTION=="add", SUBSYSTEM=="usb", ATTR{power/autosuspend}="-1"

      # Ignore 1-11 since it's dead!
      SUBSYSTEM=="usb", DEVPATH=="*1-11*", ATTR{authorized}="0"
      SUBSYSTEM=="usb", KERNELS=="1-11", ATTR{authorized}="0"
      SUBSYSTEM=="usb", KERNEL=="1-11", ATTR{remove}="1"

      # Better scheduling for NVMe
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
      # Better scheduling for SSD and HDD
      ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/scheduler}="bfq"
    '';
  };

  # Systemd optimizations
  systemd = {
    services.systemd-udevd.serviceConfig = {
      TimeoutSec = "30";
      Nice = "-10";  # Give udev higher priority
    };
    
    # Optimize journal
    services.systemd-journald.serviceConfig = {
      TimeoutStartSec = "30";
      Nice = "-10";
    };
  };
}
