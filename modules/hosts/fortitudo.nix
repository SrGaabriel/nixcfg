{ config, inputs, ... }:
let
  darwin = config.flake.modules.darwin;
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.darwin.fortitudo-host =
    { ... }:
    {
      nixpkgs.hostPlatform = "aarch64-darwin";

      networking.hostName = "fortitudo";
      networking.computerName = "fortitudo";

      system.stateVersion = 6;
    };

  flake.modules.homeManager.fortitudo-host =
    { ... }:
    {
      imports = [
        hm.core
        hm.darwin
      ];
    };

  flake.darwinConfigurations.fortitudo = inputs.nix-darwin.lib.darwinSystem {
    specialArgs = { inherit inputs; };
    modules = [
      darwin.core
      darwin.homebrew
      darwin.fortitudo-host

      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.users.gabriel = hm.fortitudo-host;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.backupFileExtension = "hm-bak";
      }
    ];
  };
}
