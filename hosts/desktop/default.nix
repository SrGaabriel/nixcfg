{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/boot.nix
    ../../modules/desktop.nix
    ../../modules/desktop-mounts.nix
    ../../modules/gaming.nix
    ../../modules/hardware.nix
  ];

  networking.hostName = "nixos";
  system.stateVersion = "25.11";

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  boot.zswap.enable = true;
  swapDevices = [
    {
      device = "/swapfile";
      size = 32768;
    }
  ];
}
