{ ... }:
{
  imports = [
    ../../modules/darwin/core.nix
    ../../modules/darwin/homebrew.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "fortitudo";
  networking.computerName = "fortitudo";

  system.stateVersion = 6;
}
