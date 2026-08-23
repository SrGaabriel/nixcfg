{ pkgs, ... }:
{
  imports = [
    ./shell.nix
    ./dev.nix
    ./editors.nix
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
    ghc
    cabal-install
    ocaml
    dune_3
    ocamlPackages.utop
    elan
    zig
    koka

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
    radicle-node
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
