{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    theme = pkgs.catppuccin-grub;
    configurationLimit = 1;
    useOSProber = true;
    extraEntries = ''
      menuentry "UEFI Firmware Settings" {
        fwsetup
      }

      menuentry "NixOS Live USB" {
        insmod part_gpt
        insmod part_msdos
        insmod fat
        insmod chain
        search --no-floppy --fs-uuid --set=root 7210-FC57
        chainloader /EFI/BOOT/BOOTX64.EFI
      }
    '';
  };
  boot.loader.timeout = null;

  boot.plymouth = {
    enable = true;
    theme = "catppuccin-macchiato";
    themePackages = [ pkgs.catppuccin-plymouth ];
  };

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  boot.initrd.systemd.enable = true;
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
}
