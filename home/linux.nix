{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.bluedevil
    kdePackages.kwallet
    kdePackages.kwallet-pam
    kdePackages.dolphin
    kdePackages.ark
    lm_sensors
    songrec
    ticktick
    ryubing
    radicle-desktop
    gdb
    obsidian
    qbittorrent
  ];
}
