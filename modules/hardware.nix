{ ... }:
{
  users.users.gabriel.extraGroups = [ "corectrl" ];

  programs.corectrl.enable = true;
  services.hardware.openrgb.enable = true;
  hardware.i2c.enable = true;
}
