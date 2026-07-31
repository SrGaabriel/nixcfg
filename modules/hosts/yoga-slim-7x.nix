{ config, inputs, ... }:
let
  nixos = config.flake.modules.nixos;
  hm = config.flake.modules.homeManager;
in
{
  # These labels match the X1E project's installation instructions. Create
  # them during installation, or replace them with the labels/UUIDs you use.
  flake.modules.nixos.hw-yoga-slim-7x =
    { ... }:
    {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/root";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-label/SYSTEM_DRV";
          fsType = "vfat";
        };
      };
    };

  flake.modules.homeManager.yoga-slim-7x-host =
    { inputs, ... }:
    {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        inputs.dsearch.homeModules.dsearch
        hm.core
        hm.linux
        hm.desktop
        hm.dms
        hm.noctalia
      ];
    };

  flake.modules.nixos.yoga-slim-7x-host =
    { ... }:
    {
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
    };

  flake.nixosConfigurations.yoga-slim-7x = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      nixos.hw-yoga-slim-7x
      nixos.core
      nixos.desktop
      nixos.yoga-slim-7x-host

      inputs.niri.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.users.gabriel = hm.yoga-slim-7x-host;
        home-manager.extraSpecialArgs = {
          inherit (inputs) helium;
          inherit inputs;
        };
        home-manager.backupFileExtension = "hm-bak";
      }

      inputs.x1e-nixos-config.nixosModules.x1e
    ];
  };
}
