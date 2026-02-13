{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.greetd = let
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  in {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --cmd start-hyprland";
        user = "greeter";
      };
    };
  };
}