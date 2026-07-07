{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.printing = {
    enable = true;
    logLevel = "debug";
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.printing.drivers = [
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
    pkgs.gutenprint
  ];
}
