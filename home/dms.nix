{ pkgs, ... }:
{
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    plugins =
      let
        dmsPlugins = pkgs.fetchFromGitHub {
          owner = "AvengeMedia";
          repo = "dms-plugins";
          rev = "547023b3ba65bcb195c93fd4b111d0f1eebe0432";
          sha256 = "sha256-3cZOazX90nAhNZ8Z6lTa8OC6Y+ZmpJ2cYOv46oelIm0=";
        };
      in
      {
        DockerManager = {
          src = pkgs.fetchFromGitHub {
            owner = "LuckShiba";
            repo = "DmsDockerManager";
            rev = "v1.2.0";
            sha256 = "sha256-VoJCaygWnKpv0s0pqTOmzZnPM922qPDMHk4EPcgVnaU=";
          };
        };
        amdGpuMonitor = {
          src = pkgs.fetchFromGitHub {
            owner = "navidagz";
            repo = "dms-amd-gpu-monitor";
            rev = "v3.0.0";
            sha256 = "sha256-oQst63DAWR8GsH6X9g3DiXpkypx70VF9rnZlbJzXUnQ=";
          };
        };
        DankKDEConnect.src = "${dmsPlugins}/DankKDEConnect";
        DankLauncherKeys.src = "${dmsPlugins}/DankLauncherKeys";
        soccer = {
          src = pkgs.fetchFromGitHub {
            owner = "Nadoutti";
            repo = "nadotti-br-soccer-plugin";
            rev = "992f7046f32bca0a25441696869e111481f90b91";
            sha256 = "sha256-0uN4dJG/dfWRZ+5HXbgW2axd3iDdlg9P/EBMnNWNz6M=";
          };
        };
        screenshot = {
          src = pkgs.fetchFromGitHub {
            owner = "JDKamalakar";
            repo = "DMS-Screenshot";
            rev = "f40deaf839b6e45feb978fa83a28c3db117b3c87";
            sha256 = "sha256-Vf2J5Gmb/gyMDC9YhU4cxqSqPTbJR5WXdOheKssL8qw=";
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
        nixMonitor = {
          src = pkgs.fetchFromGitHub {
            owner = "antonjah";
            repo = "nix-monitor";
            rev = "v1.0.3";
            sha256 = "sha256-biRc7ESKzPK5Ueus1xjVT8OXCHar3+Qi+Osv/++A+Ls=";
          };
        };
      };
  };
}
