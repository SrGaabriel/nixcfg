{ pkgs, inputs, ... }:
{
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
        image = [
          {
            run = ''helium "$@"'';
            desc = "Helium";
            orphan = true;
          }
        ];
        video = [
          {
            run = ''helium "$@"'';
            desc = "Helium";
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
