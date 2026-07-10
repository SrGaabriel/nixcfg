{
  pkgs,
  helium,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dsearch.homeModules.dsearch
    ../common.nix
    ../desktop.nix
    ../dms.nix
    ../dms-desktop.nix
  ];

  programs.niri.config = lib.mkForce (
    (builtins.readFile ../../niri-config.kdl)
    + ''
      spawn-at-startup "sh" "-c" "niri msg action focus-output DP-3"

      output "DP-3" {
          scale 1.25
          position x=0 y=0
      }
      output "HDMI-A-1" {
          position x=2752 y=0
      }
    ''
  );

  home.packages = with pkgs; [
    zed-editor
    vesktop
    mangohud
    spotifywm
    vscode
    onlyoffice-desktopeditors
    krita
    signal-desktop
    amdgpu_top
    kdePackages.plasma-systemmonitor
    thunderbird
    jetbrains.idea
    jetbrains.rust-rover
    helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.lotus.packages.${pkgs.stdenv.hostPlatform.system}.lopus
    inputs.plum.packages.${pkgs.stdenv.hostPlatform.system}.default
    (pkgs.haskell.lib.dontCheck (
      pkgs.haskellPackages.callCabal2nix "dhall-lsp-server"
        /home/gabriel/Developer/dhall-haskell/dhall-lsp-server
        { }
    ))
  ];
}
