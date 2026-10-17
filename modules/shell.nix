{
  flake.modules.homeManager.shell =
    { pkgs, ... }:
    let
      openCommand = if pkgs.stdenv.hostPlatform.isDarwin then "open" else "xdg-open";
    in
    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableNushellIntegration = true;
      };

      programs.nushell = {
        enable = true;
        # rustc drops rustc-ice-*.txt in the cwd on an internal compiler error;
        # "0" is the documented opt-out.
        environmentVariables.RUSTC_ICE = "0";
        shellAliases = {
          zed = "zeditor";
          cd = "z";
          cat = "bat";
          "dstopall" = "docker ps -q | lines | each { |id| docker stop $id }";
        };
        extraConfig = ''
          $env.config.show_banner = false

          def cnew [name: string] {
            cargo new $"crates/($name)" --name $"(($env.PWD | path basename))-($name)" --lib
          }

          def --wrapped claude [model: string, ...rest] {
            npx @anthropic-ai/claude-code@latest --model $model --dangerously-skip-permissions ...$rest
          }
        '';
      };

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks."server.purduehackers.com" = {
          hostname = "server.purduehackers.com";
          user = "gabriel";
          port = 10022;
          setEnv.TERM = "xterm-256color";
        };
      };

      programs.zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };

      programs.starship = {
        enable = true;
        enableNushellIntegration = true;
      };

      programs.yazi = {
        enable = true;
        shellWrapperName = "y";
        settings = {
          manager.editor = "hx";
          opener = {
            image = [
              {
                run = ''${openCommand} "$@"'';
                desc = "Open";
                orphan = true;
              }
            ];
            video = [
              {
                run = ''${openCommand} "$@"'';
                desc = "Open";
                orphan = true;
              }
            ];
          };
          open.rules = [
            {
              mime = "image/*";
              use = "image";
            }
            {
              mime = "video/*";
              use = "video";
            }
          ];
        };
      };
    };
}
