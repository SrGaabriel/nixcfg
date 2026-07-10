{
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/14C01EF7C01EDF34";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "nofail"
    ];
  };

  fileSystems."/mnt/windows/Program Files (x86)/Steam/steamapps/compatdata" = {
    device = "/home/gabriel/.local/share/Steam/steamapps/compatdata";
    fsType = "none";
    options = [
      "bind"
      "nofail"
      "x-systemd.requires=mnt-windows.mount"
    ];
  };
}
