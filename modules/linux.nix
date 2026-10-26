{
  flake.modules.homeManager.linux =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-vaapi
          obs-pipewire-audio-capture
        ];
      };

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
