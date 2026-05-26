{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    shellAliases = {
      zed = "zeditor";
      cd = "z";
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
