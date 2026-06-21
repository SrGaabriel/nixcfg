{
  pkgs,
  helium,
  inputs,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dsearch.homeModules.dsearch
    ./home/shell.nix
    ./home/dev.nix
    ./home/editors.nix
    ./home/desktop.nix
    ./home/dms.nix
  ];

  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";
  home.sessionPath = [ "/home/gabriel/.svm/current/x86_64-unknown-linux-gnu/bin" ];
  home.stateVersion = "25.11";
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    GIT_EDITOR = "hx";
    TERMINAL = "ghostty";
  };

  home.packages = with pkgs; [
    zed-editor
    rustup
    python3
    deno
    nodejs
    uv
    dust
    gh
    nil
    vesktop
    mangohud
    spotifywm
    numbat
    bat
    ripgrep
    hexyl
    hyperfine
    fd
    eza
    pastel
    diskus
    kdePackages.bluedevil
    kdePackages.kwallet
    kdePackages.kwallet-pam
    kdePackages.dolphin
    kdePackages.ark
    binocle
    zoxide
    tokei
    just
    elan
    ryubing
    ngrok
    vscode
    typos
    rage
    ocaml
    onlyoffice-desktopeditors
    dune
    ocamlPackages.utop
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat
    taplo
    bottom
    nixd
    nixfmt
    zls
    krita
    radicle-node
    radicle-desktop
    gdb
    typeshare
    koka
    fastfetch
    signal-desktop
    lm_sensors
    amdgpu_top
    kdePackages.plasma-systemmonitor
    zig
    protobuf
    ghc
    songrec
    qbittorrent
    aria2
    cabal-install
    haskell-language-server
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

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
