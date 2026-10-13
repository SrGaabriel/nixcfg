top@{ inputs, ... }:
{
  flake.modules.nixos.core =
    { pkgs, ... }:
    {
      nix = {
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        settings.auto-optimise-store = true;
      };

      networking.networkmanager = {
        enable = true;
        wifi.powersave = false;
        dns = "none";
      };
      networking.nameservers = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      services.nscd.enableNsncd = true;

      time.timeZone = top.config.flake.timeZone;
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "pt_BR.UTF-8";
        LC_IDENTIFICATION = "pt_BR.UTF-8";
        LC_MEASUREMENT = "pt_BR.UTF-8";
        LC_MONETARY = "pt_BR.UTF-8";
        LC_NAME = "pt_BR.UTF-8";
        LC_NUMERIC = "pt_BR.UTF-8";
        LC_PAPER = "pt_BR.UTF-8";
        LC_TELEPHONE = "pt_BR.UTF-8";
        LC_TIME = "pt_BR.UTF-8";
      };
      i18n.inputMethod = {
        enable = true;
        type = "ibus";
      };

      virtualisation.docker.enable = true;
      virtualisation.podman.enable = true;

      users.users.gabriel = {
        isNormalUser = true;
        description = "Gabriel";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
        ];
        shell = pkgs.nushell;
      };

      environment.systemPackages = with pkgs; [
        helix
        nushell
        ghostty
        git
        usbutils
        jujutsu
        clang
        clang-tools
        libgcc
        gcc
        llvm
        xwayland-satellite
        grim
        slurp
        satty
        gnumake
        cmake
      ];
      environment.shells = [ pkgs.nushell ];

      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          ncurses
          gmp
        ];
      };
      programs.mtr.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      programs.kdeconnect.enable = true;

      services = {
        openssh.enable = true;
        accounts-daemon.enable = true;
        power-profiles-daemon.enable = true;
        printing.enable = true;
        syncthing = {
          enable = true;
          user = "gabriel";
          group = "users";
          dataDir = "/home/gabriel";
          configDir = "/home/gabriel/.config/syncthing";
          openDefaultPorts = true;
        };
      };

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      nixpkgs.config.allowUnfree = true;
    };

  flake.modules.homeManager.core =
    { pkgs, ... }:
    {
      imports = with top.config.flake.modules.homeManager; [
        shell
        dev
        editors
      ];

      home.username = "gabriel";
      home.homeDirectory =
        if pkgs.stdenv.hostPlatform.isDarwin then "/Users/gabriel" else "/home/gabriel";
      home.stateVersion = "25.11";
      home.sessionVariables = {
        EDITOR = "hx";
        VISUAL = "hx";
        GIT_EDITOR = "hx";
        TERMINAL = "ghostty";
      };

      home.packages = with pkgs; [
        rustup
        python3
        deno
        nodejs
        uv
        inputs.bend.packages.${pkgs.stdenv.hostPlatform.system}.default
        ghc
        cabal-install
        ocaml
        dune_3
        ocamlPackages.utop
        elan
        zig
        koka
        sea-orm-cli
        nil
        nixd
        nixfmt
        zls
        haskell-language-server
        ocamlPackages.ocaml-lsp
        ocamlPackages.ocamlformat
        taplo
        typeshare
        typos
        bat
        ripgrep
        fd
        eza
        zoxide
        dust
        diskus
        hexyl
        hyperfine
        tokei
        just
        zellij
        numbat
        pastel
        binocle
        bottom
        fastfetch
        rage
        aria2
        ngrok
        gh
        protobuf
      ];

      nixpkgs.config.allowUnfree = true;
      programs.home-manager.enable = true;
    };
}
