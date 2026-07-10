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

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    x1e-nixos-config = {
      url = "github:kuruczgy/x1e-nixos-config/pr/switch-to-upstream-kernel";
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
      dsearch,
      lotus,
      plum,
      x1e-nixos-config,
      ...
    }:
    let
      mkHost = {
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

        yoga-slim-7x = mkHost {
          system = "aarch64-linux";
          hostModule = ./hosts/yoga-slim-7x;
          homeModule = ./home/hosts/yoga-slim-7x.nix;
          extraModules = [ x1e-nixos-config.nixosModules.x1e ];
        };
      };

      # Compatibility alias for the current desktop rebuild command.
      nixosConfigurations.gabriel = self.nixosConfigurations.desktop;
    };
}
