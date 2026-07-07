{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.power-profiles-daemon.enable = true;
  powerManagement.powertop.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="0",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
    # SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="1",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
  '';
}
