{ ... }:
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
}
