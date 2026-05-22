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
    inputs.dms.homeModules.niri
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
    discord
    spotifywm
    yazi
    numbat
    bat
    ripgrep
    hexyl
    hyperfine
    fd
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
    nixd
    lm_sensors
    amdgpu_top
    mission-center
    helium.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  nixpkgs.config.allowUnfree = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "ghostty";

      monitor = [
        "DP-3, 3440x1440@165, 0x0, 1.25"
        "HDMI-A-1, 1920x1080@60, 2752x0, 1.0"
      ];

      general.layout = "scrolling";

      bind = [
        "$mod, M, exit"
        "$mod, Return, exec, ghostty"
        "$mod, Q, killactive"
        "$mod, D, exec, dms ipc spotlight toggle"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod, F, fullscreen"
        "$mod, V, togglefloating"

        "$mod SHIFT, L, exec, hyprlock"

        "$mod, Space, exec, dms ipc spotlight toggle"
        "$mod, C, exec, dms ipc clipboard toggle"
        "$mod, A, exec, dms ipc control-center toggle"
        "$mod, N, exec, dms ipc notifications toggle"
        "$mod, Escape, exec, dms ipc powermenu toggle"
        "$mod, slash, exec, dms ipc keybinds toggle"

        "$mod, bracketright, layoutmsg, colresize +conf"
        "$mod, P, layoutmsg, promote"
        "$mod, comma, layoutmsg, consume_or_expel prev"
        "$mod, period, layoutmsg, consume_or_expel next"

        "$mod, Tab, focusmonitor, +1"
        "$mod SHIFT, Tab, movewindow, mon:+1"
        "$mod CTRL, Tab, movecurrentworkspacetomonitor, +1"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, dms ipc audio increment"
        ", XF86AudioLowerVolume, exec, dms ipc audio decrement"
        ", XF86MonBrightnessUp, exec, dms ipc brightness increment"
        ", XF86MonBrightnessDown, exec, dms ipc brightness decrement"
      ];

      bindl = [
        ", XF86AudioMute, exec, dms ipc audio mute"
        ", XF86AudioMicMute, exec, dms ipc audio micmute"
        ", XF86AudioPlay, exec, dms ipc mpris playPause"
        ", XF86AudioPause, exec, dms ipc mpris playPause"
        ", XF86AudioNext, exec, dms ipc mpris next"
        ", XF86AudioPrev, exec, dms ipc mpris previous"
      ];
    };
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
    niri.includes.enable = false;
  };

  programs.nushell.enable = true;
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.home-manager.enable = true;
}
