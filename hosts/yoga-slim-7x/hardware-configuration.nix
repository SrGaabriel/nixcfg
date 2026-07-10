{ ... }:
{
  # These labels match the X1E project's installation instructions. Create
  # them during installation, or replace them with the labels/UUIDs you use.
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
}
