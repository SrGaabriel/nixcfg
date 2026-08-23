{ lib, pkgs, ... }:
{
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

  documentation.doc.enable = false;
  system.tools.darwin-uninstaller.enable = false;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  time.timeZone = "America/Sao_Paulo";
}
