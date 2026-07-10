{ pkgs, ... }:
{
  programs.dank-material-shell.plugins = {
    amdGpuMonitor = {
      src = pkgs.fetchFromGitHub {
        owner = "navidagz";
        repo = "dms-amd-gpu-monitor";
        rev = "v3.0.0";
        sha256 = "sha256-oQst63DAWR8GsH6X9g3DiXpkypx70VF9rnZlbJzXUnQ=";
      };
    };
    gameControllerBattery = {
      src = pkgs.fetchFromGitHub {
        owner = "Hujair";
        repo = "gameControllerBattery";
        rev = "v1.2.0";
        sha256 = "sha256-irWI2LI8IOhva/DpfF8nI23wQMKyOPGNv86G9ZDjJ4g=";
      };
    };
  };
}
