{ pkgs, ... }:
{
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
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
}
