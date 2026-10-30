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

          def vcompress [
            input: path
            size_mb: number
            --output (-o): path
            --audio-kbps: int = 128
          ] {
            let duration = (^ffprobe -v error -show_entries format=duration -of csv=p=0 $input | str trim | into float)
            let total_kbps = ($size_mb * 8000 * 0.97 / $duration)
            let video_kbps = (($total_kbps - $audio_kbps) | math floor)
            if $video_kbps <= 0 {
              error make { msg: $"($size_mb)MB is too small for a ($duration | math round)s video" }
            }
            let out = if $output == null {
              $input | path parse | update stem { |p| $"($p.stem)-($size_mb)mb" } | update extension "mp4" | path join
            } else { $output }
            let tmp = (mktemp -d)
            let passlog = ($tmp | path join "pass")
            ^ffmpeg -y -i $input -c:v libx264 -preset medium -b:v $"($video_kbps)k" -pass 1 -passlogfile $passlog -an -f null /dev/null
            ^ffmpeg -y -i $input -c:v libx264 -preset medium -b:v $"($video_kbps)k" -pass 2 -passlogfile $passlog -c:a aac -b:a $"($audio_kbps)k" -movflags +faststart $out
            rm -rf $tmp
            print $"($out): (ls $out | get 0.size)"
          }

          def --wrapped claude [model: string, ...rest] {
            npx @anthropic-ai/claude-code@latest --model $model --dangerously-skip-permissions ...$rest
          }
        '';
      };

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."server.purduehackers.com" = {
          HostName = "server.purduehackers.com";
          User = "gabriel";
          Port = 10022;
          SetEnv.TERM = "xterm-256color";
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
