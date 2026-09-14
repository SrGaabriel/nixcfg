{
  description = "NixOS and nix-darwin config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
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

    dsearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lotus = {
      url = "github:SrGaabriel/lotus/38a9fc8a3a3242844d699566eccf5c1f729b2ed3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plum = {
      url = "git+file:///home/gabriel/Developer/plum?rev=092c29fb1193993587a1b86d6ba1cbcc6e867ec3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bend = {
      url = "github:nicolas-abril/bend2-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      # The wrapper's own lock lags upstream; track bend directly.
      inputs.bend2.url = "github:bendlang/bend";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      helium,
      zen-browser,
      niri,
      dms,
      dsearch,
      lotus,
      plum,
      ...
    }:
    let
      mkHost =
        {
          system,
          hostModule,
          homeModule,
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            hostModule
            niri.nixosModules.niri
            home-manager.nixosModules.home-manager
            {
              home-manager.users.gabriel = import homeModule;
              home-manager.extraSpecialArgs = { inherit helium inputs; };
              home-manager.backupFileExtension = "hm-bak";
            }
          ] ++ extraModules;
        };

      mkDarwinHost =
        {
          hostModule,
          homeModule,
          extraModules ? [ ],
        }:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [
            hostModule
            home-manager.darwinModules.home-manager
            {
              home-manager.users.gabriel = import homeModule;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "hm-bak";
            }
          ] ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost {
          system = "x86_64-linux";
          hostModule = ./hosts/desktop;
          homeModule = ./home/hosts/desktop.nix;
          extraModules = [
            {
              nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.default ];
              nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
            }
          ];
        };
      };

      nixosConfigurations.gabriel = self.nixosConfigurations.desktop;

      darwinConfigurations = {
        fortitudo = mkDarwinHost {
          hostModule = ./hosts/fortitudo;
          homeModule = ./home/hosts/fortitudo.nix;
        };
      };
    };
}
