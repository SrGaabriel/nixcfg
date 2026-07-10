{ inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dsearch.homeModules.dsearch
    ../common.nix
    ../desktop.nix
    ../dms.nix
  ];
}
