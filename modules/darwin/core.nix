{ lib, pkgs, ... }:
{
  imports = [ ../shared.nix ];

  nix.enable = false;

  nixpkgs.config.allowUnfree = true;

  system.primaryUser = "gabriel";
  users.knownUsers = [ "gabriel" ];
  users.users.gabriel = {
    name = "gabriel";
    uid = 501;
    gid = 20;
    home = "/Users/gabriel";
    shell = pkgs.nushell;
  };

  environment.systemPackages = with pkgs; [
    git
    nushell
    helix
    jujutsu
    gnumake
    cmake
  ];

  environment.shells = [
    pkgs.nushell
    pkgs.zsh
  ];

  programs.zsh.enable = true;

  environment.systemPath = lib.mkOrder 1100 [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  # macOS otherwise saves the open-app set at shutdown and relaunches it at
  # login. nix-darwin has no typed option for this, hence the raw domain.
  system.defaults.CustomUserPreferences."com.apple.loginwindow" = {
    TALLogoutSavesState = false;
    LoginwindowLaunchesRelaunchApps = false;
  };

  documentation.doc.enable = false;
  system.tools.darwin-uninstaller.enable = false;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

}
