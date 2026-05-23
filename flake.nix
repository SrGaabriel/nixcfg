{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      helium,
      niri,
      dms,
      ...
    }:
    {
      nixosConfigurations.gabriel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          {
            home-manager.users.gabriel = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit helium inputs; };
            home-manager.backupFileExtension = "hm-bak";
          }
        ];
      };
    };
}
