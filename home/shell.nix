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

      def cnew [name: string] {
        cargo new $"crates/($name)" --name $"(($env.PWD | path basename))-($name)" --lib
      }
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
