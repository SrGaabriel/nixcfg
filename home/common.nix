{ pkgs, ... }:
{
  imports = [
    ./shell.nix
    ./dev.nix
    ./editors.nix
  ];

  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";
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
    dust
    gh
    nil
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
    typos
    rage
    ocaml
    dune
    ocamlPackages.utop
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat
    taplo
    bottom
    nixd
    nixfmt
    zls
    radicle-node
    radicle-desktop
    gdb
    typeshare
    koka
    fastfetch
    lm_sensors
    zig
    protobuf
    ghc
    songrec
    qbittorrent
    aria2
    cabal-install
    haskell-language-server
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
