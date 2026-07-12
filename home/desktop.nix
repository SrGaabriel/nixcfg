{ pkgs, inputs, ... }:
{
  programs.dsearch = {
    enable = true;
    package = inputs.dsearch.packages.${pkgs.stdenv.hostPlatform.system}.dsearch.overrideAttrs {
      vendorHash = "sha256-Gq3tVwe39m5KGfkI3DEnQEQEGs/cLDCiwx6XFM61f6c=";
    };
  };

  programs.niri.config = builtins.readFile ../niri-config.kdl;

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "breeze";
      package = pkgs.kdePackages.breeze;
    };
  };

  home.pointerCursor = {
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 18;
    gtk.enable = true;
    x11.enable = true;
  };

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
        image = [
          {
            run = ''xdg-open "$@"'';
            desc = "Open";
            orphan = true;
          }
        ];
        video = [
          {
            run = ''xdg-open "$@"'';
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
}
