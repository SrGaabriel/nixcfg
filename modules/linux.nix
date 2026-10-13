{
  flake.modules.homeManager.linux =
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
        gdb
        obsidian
        qbittorrent
      ];
    };
}
