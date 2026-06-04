{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
    shellAliases = {
      zed = "zeditor";
      cd = "z";
      "dstopall" = "docker ps -q | lines | each { |id| docker stop $id }";
    };
    extraConfig = ''
      $env.config.show_banner = false
      $env.PATH = ($env.PATH | prepend "/home/gabriel/.svm/current/x86_64-unknown-linux-gnu/bin")
    '';
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };
}
