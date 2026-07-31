{ inputs, ... }:
{
  flake.modules.homeManager.dms =
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
    };

  # Plugins that only make sense on a machine with an AMD GPU and a controller.
  flake.modules.homeManager.dms-desktop =
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
    };

  flake.modules.homeManager.noctalia =
    {
      pkgs,
      lib,
      ...
    }:
    let
      desktopShell = pkgs.writeShellApplication {
        name = "desktop-shell";
        runtimeInputs = [ pkgs.systemd ];
        text = ''
          case "''${1:-toggle}" in
            dms)
              systemctl --user stop noctalia.service
              systemctl --user start dms.service
              ;;
            noctalia)
              systemctl --user stop dms.service
              systemctl --user start noctalia.service
              ;;
            launcher)
              if systemctl --user --quiet is-active noctalia.service; then
                exec noctalia msg panel-toggle launcher
              else
                exec dms ipc spotlight toggle
              fi
              ;;
            toggle)
              if systemctl --user --quiet is-active noctalia.service; then
                exec "$0" dms
              else
                exec "$0" noctalia
              fi
              ;;
            *)
              echo "usage: desktop-shell {dms|noctalia|launcher|toggle}" >&2
              exit 2
              ;;
          esac
        '';
      };
    in
    {
      imports = [ inputs.noctalia.homeModules.default ];

      programs.noctalia = {
        enable = true;
        systemd.enable = true;
      };

      # DMS remains the login shell. This keeps Noctalia's unit available for
      # desktop-shell without starting two bars and notification daemons.
      systemd.user.services.noctalia.Install.WantedBy = lib.mkForce [ ];

      home.packages = [ desktopShell ];
    };
}
