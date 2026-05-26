{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession.enable = true;
  };
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  hardware.graphics.enable32Bit = true;

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
}
