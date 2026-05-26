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
  };

  home.packages = with pkgs; [
    zed-editor
    rustup
    python3
    deno
    nodejs
    uv
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
    binocle
    zoxide
    tokei
    just
    elan
    vscode
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
    zls
    gdb
    typeshare
    fastfetch
    lm_sensors
    amdgpu_top
    kdePackages.plasma-systemmonitor
    zig
    helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.lotus.packages.${pkgs.stdenv.hostPlatform.system}.lopus
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
