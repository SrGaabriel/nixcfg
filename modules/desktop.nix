{
  flake.modules.nixos.desktop =
    { pkgs, inputs, ... }:
    {
      services.xserver.xkb = {
        layout = "us";
        variant = "intl";
      };

      console.keyMap = "us-acentos";

      programs.niri.enable = true;
      programs.niri.package = pkgs.niri;

      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.kdePackages.xdg-desktop-portal-kde
          pkgs.xdg-desktop-portal-gnome
        ];

        config.niri = {
          "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
          "org.freedesktop.impl.portal.Settings" = [ "gnome" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.RemoteDesktop" = [ "gnome" ];
        };
      };

      services.displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs; [
          kdePackages.qtsvg
          kdePackages.qtmultimedia
          kdePackages.qtvirtualkeyboard
        ];
      };

      environment.systemPackages = [
        ((pkgs.sddm-astronaut.override { embeddedTheme = "pixel_sakura"; }).overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            substituteInPlace $out/share/sddm/themes/sddm-astronaut-theme/Components/Input.qml \
              --replace 'font.capitalization: config.AllowUppercaseLettersInUsernames == "false" ? Font.AllLowercase : Font.MixedCase' \
                        'font.capitalization: Font.AllUppercase'
          '';
        }))
      ];

      security.pam.services.sddm.kwallet.enable = true;
      fonts = {
        enableDefaultPackages = true;
        packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          liberation_ttf
          nerd-fonts.jetbrains-mono
          inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro
          inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-mono
        ];
        fontconfig = {
          antialias = true;
          hinting = {
            enable = true;
            style = "slight";
          };
          subpixel = {
            rgba = "rgb";
            lcdfilter = "default";
          };
        };
      };
    };

  flake.modules.homeManager.desktop =
    { pkgs, inputs, ... }:
    {
      programs.dsearch = {
        enable = true;
        package = inputs.dsearch.packages.${pkgs.stdenv.hostPlatform.system}.dsearch;
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
        enable = true;
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
    };
}
