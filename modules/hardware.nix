{ ... }:
{
  programs.corectrl.enable = true;
  services.hardware.openrgb.enable = true;
  hardware.i2c.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
