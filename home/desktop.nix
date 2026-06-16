{ pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = false;
    configType = "lua";
    extraConfig = builtins.readFile ../hyprland.lua;
  };

  xdg.configFile."hypr/hyprsplit" = {
    source = "${inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplitlua}/share/hyprsplit";
    recursive = true;
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general.hide_cursor = true;
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

  programs.niri.config = builtins.readFile ../niri-config.kdl;

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  xdg.desktopEntries.yazi = {
    name = "Yazi";
    exec = "ghostty -e yazi";
    terminal = false;
    icon = "yazi";
    categories = [ "FileManager" ];
  };

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "org.kde.dolphin.desktop" ];
  };

  xdg.configFile."ghostty/config".text = ''
    background-opacity = 0.85
    background-blur = 20

  '';

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    settings = {
      manager.editor = "hx";
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
}
