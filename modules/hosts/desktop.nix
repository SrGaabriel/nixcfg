{ config, inputs, ... }:
let
  nixos = config.flake.modules.nixos;
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.hw-desktop =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "uas"
        "usbhid"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/06a7d396-0a75-4a30-b96c-336e6a852101";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/BA1D-EE93";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [ ];
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

  flake.modules.nixos.desktop-host =
    { ... }:
    {
      networking.hostName = "nixos";
      system.stateVersion = "25.11";

      services.keyd = {
        enable = true;
        keyboards.corsair-k65-plus = {
          ids = [ "k:1b1c:2b10" ];
          settings.main.home = "sysrq";
        };
      };

      boot.zswap.enable = true;
      swapDevices = [
        {
          device = "/swapfile";
          size = 32768;
        }
      ];
    };

  flake.modules.homeManager.desktop-host =
    {
      pkgs,
      helium,
      inputs,
      lib,
      ...
    }:
    let
      nbtExplorerDesktop = pkgs.makeDesktopItem {
        name = "nbtexplorer";
        desktopName = "NBTExplorer";
        comment = "Edit Minecraft NBT data";
        exec = "nbtexplorer";
        categories = [
          "Game"
          "Utility"
        ];
      };
      nbtExplorer = pkgs.stdenvNoCC.mkDerivation {
        pname = "nbtexplorer";
        version = "2.8.0";

        src = pkgs.fetchFromGitHub {
          owner = "jaquadro";
          repo = "NBTExplorer";
          rev = "v2.8.0-win";
          hash = "sha256-uOoELun0keFYN1N2/a1IkCP1AZQvfDLiUdrLxxrhE/A=";
        };

        nativeBuildInputs = [
          pkgs.mono
          pkgs.makeWrapper
        ];

        buildPhase = ''
          runHook preBuild
          xbuild /p:Configuration=Release NBTExplorer/NBTExplorer.csproj
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          install -Dm644 NBTExplorer/bin/Release/{NBTExplorer.exe,NBTExplorer.exe.config,NBTModel.dll,Substrate.dll} -t $out/lib/nbtexplorer
          makeWrapper ${pkgs.mono}/bin/mono $out/bin/nbtexplorer \
            --add-flags "$out/lib/nbtexplorer/NBTExplorer.exe"
          install -Dm444 ${nbtExplorerDesktop}/share/applications/nbtexplorer.desktop \
            -t $out/share/applications
          runHook postInstall
        '';

        meta = {
          description = "Graphical editor for Minecraft NBT data";
          homepage = "https://github.com/jaquadro/NBTExplorer";
          license = lib.licenses.mit;
          mainProgram = "nbtexplorer";
          platforms = lib.platforms.linux;
        };
      };
    in
    {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        inputs.dsearch.homeModules.dsearch
        hm.core
        hm.linux
        hm.desktop
        hm.dms
        hm.dms-desktop
      ];

      programs.niri.config = lib.mkForce (
        (builtins.readFile ../../niri-config.kdl)
        + ''
          output "Samsung Electric Company LC34G55T HX7L201471" {
              scale 1.25
              position x=0 y=0
          }

          output "Sceptre Tech Inc Sceptre K32 0x0002BB29" {
              mode "1920x1080@240"
              scale 1
              position x=0 y=0
          }

          output "Samsung Electric Company C27F390 HX5R200478" {
              scale 1.0
          }

          spawn-sh-at-startup "niri msg action focus-output 'Samsung Electric Company LC34G55T HX7L201471' || niri msg action focus-output 'Sceptre Tech Inc Sceptre K32 0x0002BB29'"
        ''
      );

      home.packages = with pkgs; [
        vesktop
        mangohud
        spotifywm
        onlyoffice-desktopeditors
        krita
        kdePackages.kdenlive
        nbtExplorer
        stremio-linux-shell
        temurin-bin-21
        (prismlauncher.override {
          jdks = [
            temurin-bin-17
            temurin-bin-21
          ];
        })
        signal-desktop
        amdgpu_top
        kdePackages.plasma-systemmonitor
        thunderbird
        jetbrains.idea
        jetbrains.rust-rover
        helium.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
        inputs.plum.packages.${pkgs.stdenv.hostPlatform.system}.default
        (pkgs.haskell.lib.dontCheck (
          pkgs.haskellPackages.callCabal2nix "dhall-lsp-server"
            /home/gabriel/Developer/dhall-haskell/dhall-lsp-server
            { }
        ))
      ];
    };

  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      nixos.hw-desktop
      nixos.core
      nixos.boot
      nixos.desktop
      nixos.desktop-mounts
      nixos.gaming
      nixos.ollama
      nixos.hardware
      nixos.desktop-host

      inputs.niri.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.users.gabriel = hm.desktop-host;
        home-manager.extraSpecialArgs = {
          inherit (inputs) helium;
          inherit inputs;
        };
        home-manager.backupFileExtension = "hm-bak";
      }

      {
        nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
        nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
        nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
      }
    ];
  };

  flake.nixosConfigurations.gabriel = config.flake.nixosConfigurations.desktop;
}
