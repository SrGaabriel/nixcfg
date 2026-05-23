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
  ];

  home.username = "gabriel";
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
    yazi
    numbat
    bat
    ripgrep
    hexyl
    hyperfine
    fd
    eza
    pastel
    diskus
    binocle
    zoxide
    tokei
    just
    elan
    vscode
    llvm
    clang
    typos
    rage
    taplo
    bottom
    nixd
    lm_sensors
    amdgpu_top
    mission-center
    helium.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  nixpkgs.config.allowUnfree = true;

  wayland.windowManager.hyprland = {
    enable = true;
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

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
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
    '';
  };
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.home-manager.enable = true;
}
