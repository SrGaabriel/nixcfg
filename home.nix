{
  config,
  pkgs,
  helium,
  inputs,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dsearch.homeModules.dsearch
  ];

  home.username = "gabriel";
  home.sessionPath = [ "/home/gabriel/.svm/current/x86_64-unknown-linux-gnu/bin" ];
  home.homeDirectory = "/home/gabriel";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    zed-editor
    rustup
    python3
    deno
    nodejs
    uv
    gh
    nil
    vesktop
    mangohud
    spotifywm
    numbat
    bat
    ripgrep
    hexyl
    hyperfine
    fd
    eza
    pastel
    diskus
    nautilus
    binocle
    zoxide
    tokei
    just
    elan
    vscode
    typos
    rage
    ocaml
    dune
    ocamlPackages.utop
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat
    taplo
    bottom
    nixd
    zls
    gdb
    typeshare
    fastfetch
    lm_sensors
    amdgpu_top
    mission-center
    zig
    helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.lotus.packages.${pkgs.stdenv.hostPlatform.system}.lopus
  ];

  nixpkgs.config.allowUnfree = true;

  wayland.windowManager.hyprland = {
    enable = false;
    configType = "lua";
    extraConfig = builtins.readFile ./hyprland.lua;
  };

  xdg.configFile."hypr/hyprsplit" = {
    source = "${inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplitlua}/share/hyprsplit";
    recursive = true;
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };
      background = [
        {
          color = "rgba(25, 20, 20, 1.0)";
          blur_passes = 2;
        }
      ];
      label = [
        {
          text = "$TIME";
          font_size = 90;
          position = "0, 120";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          size = "300, 60";
          position = "0, -80";
          halign = "center";
          valign = "center";
          outline_thickness = 2;
          placeholder_text = "Password...";
        }
      ];
    };
  };

  programs.dsearch = {
    enable = true;
    package = inputs.dsearch.packages.${pkgs.stdenv.hostPlatform.system}.dsearch.overrideAttrs {
      vendorHash = "sha256-scvZWbMHAhpYWCU0xZK1E6h6sAkoXegqI1iYS44fcCg=";
    };
  };

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

  xdg.desktopEntries.yazi = {
    name = "Yazi";
    exec = "ghostty -e yazi";
    terminal = false;
    icon = "yazi";
    categories = [ "FileManager" ];
  };

  programs.niri.config = builtins.readFile ./niri-config.kdl;

  programs.nushell = {
    enable = true;
    shellAliases = {
      zed = "zeditor";
      cd = "z";
    };
    extraConfig = ''
      $env.config.show_banner = false
      $env.PATH = ($env.PATH | prepend "/home/gabriel/.svm/current/x86_64-unknown-linux-gnu/bin")
    '';
  };
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        image = [ { run = ''helium "$@"''; desc = "Helium"; orphan = true; } ];
        video = [ { run = ''helium "$@"''; desc = "Helium"; orphan = true; } ];
      };
      open.rules = [
        { mime = "image/*"; use = "image"; }
        { mime = "video/*"; use = "video"; }
      ];
    };
  };

  programs.home-manager.enable = true;
}
