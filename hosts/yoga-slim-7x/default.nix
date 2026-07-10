{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/desktop.nix
  ];

  networking.hostName = "yoga-slim-7x";
  hardware.lenovo-yoga-slim7x.enable = true;

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 2;
  };
  boot.initrd.systemd = {
    enable = true;
    emergencyAccess = true;
  };

  # x1e-nixos-config's PR branch selects linuxPackages_latest by default.
  system.stateVersion = "25.11";
}
