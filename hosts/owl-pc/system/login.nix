{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.greetd.enable = false;

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "dur_file";
      dur_file_path = "${./blackhole.dur}"; 
      save = true;
      full_color = true;
    };
  };
}
