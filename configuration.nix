{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/gaming.nix
    ./modules/hardware.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  networking.networkmanager.dns = "none";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/14C01EF7C01EDF34";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" "gid=100" "nofail" ];
  };

  fileSystems."/mnt/windows/Program Files (x86)/Steam/steamapps/compatdata" = {
    device = "/home/gabriel/.local/share/Steam/steamapps/compatdata";
    fsType = "none";
    options = [ "bind" "nofail" "x-systemd.requires=mnt-windows.mount" ];
  };

  time.timeZone = "America/Sao_Paulo";
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

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  users.users.gabriel = {
    isNormalUser = true;
    description = "Gabriel";
    extraGroups = [ "networkmanager" "wheel" "corectrl" "docker" ];
    shell = pkgs.nushell;
    packages = [ ];
  };

  environment.systemPackages = with pkgs; [
    helix
    nushell
    ghostty
    git
    jujutsu
    clang
    clang-tools
    libgcc
    gcc
    llvm
    xwayland-satellite
    gpu-screen-recorder
    grim
    slurp
    satty
    gnumake
    cmake
  ];
  environment.shells = [ pkgs.nushell ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    ncurses
    gmp
  ];
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.kdeconnect.enable = true;

  services.openssh.enable = true;
  services.accounts-daemon.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
