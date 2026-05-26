{ pkgs, ... }:
{
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  console.keyMap = "us-acentos";

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.niri.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "kde" ];
      "org.freedesktop.impl.portal.RemoteDesktop" = [ "kde" ];
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
    (pkgs.sddm-astronaut.override { embeddedTheme = "pixel_sakura"; })
  ];

  security.pam.services.sddm.kwallet.enable = true;
  security.pam.services.hyprlock = { };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      nerd-fonts.jetbrains-mono
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
}
