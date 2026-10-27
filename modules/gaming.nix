{
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        extraCompatPackages = [
          pkgs.proton-ge-bin
          pkgs.dwproton-bin
          (pkgs.proton-ge-bin.overrideAttrs (finalAttrs: _: {
            pname = "proton-cachyos-bin";
            version = "cachyos-11.0-20261014-slr";
            steamDisplayName = "Proton-CachyOS";
            toolName = "proton-cachyos-11.0-20261014-slr-x86_64";
            src = pkgs.fetchzip {
              url = "https://github.com/CachyOS/proton-cachyos/releases/download/${finalAttrs.version}/${finalAttrs.toolName}.tar.xz";
              hash = "sha256-L0CzBfelMJP2jj4VNEQY/ZswJo16TN6nNf9qKVryCRU=";
            };
          }))
        ];
        gamescopeSession.enable = true;
      };
      programs.gamescope.enable = true;
      programs.gamemode.enable = true;
      hardware.graphics.enable32Bit = true;
      boot.kernelModules = [ "ntsync" ];

      systemd.services.amdgpu-high-clocks = {
        description = "Force AMD GPU to high performance level";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = pkgs.writeShellScript "amdgpu-high-clocks" ''
            for f in /sys/class/drm/card*/device/power_dpm_force_performance_level; do
              [ -e "$f" ] && echo high > "$f"
            done
          '';
        };
      };
    };
}
